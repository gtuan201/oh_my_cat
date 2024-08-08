import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/repository/reminder_repo.dart';
import 'package:mood_press/data/model/reminder.dart';
import 'package:mood_press/helper/notification_helper.dart';
import 'package:mood_press/ulti/constant.dart';

class ReminderProvider extends ChangeNotifier {
  final ReminderRepo repo;
  List<Reminder> _reminders = [];

  ReminderProvider({required this.repo});

  List<Reminder> get reminders => _reminders;

  Future<void> loadReminders() async {
    _reminders = await repo.getAllReminders();
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    await repo.addReminder(reminder);
    await loadReminders();
  }

  Future<void> updateReminder(Reminder reminder) async {
    await repo.updateReminder(reminder);
    await loadReminders();
  }

  Future<bool> deleteReminder(int id) async {
    if(await isDefaultReminder(id)){
      return false;
    }
    await Get.find<NotificationHelper>().cancelNotification(id);
    await repo.deleteReminder(id);
    await loadReminders();
    return true;
  }

  Future<Reminder?> getReminderById(int id) async {
    return await repo.getReminderById(id);
  }

  Future<Reminder?> getDefaultReminder() async {
    return await repo.getDefaultReminder();
  }

  Future<bool> isDefaultReminder(int id) async {
    return await repo.isDefaultReminder(id);
  }

  Future<void> toggleReminderEnable(int id) async {
    await repo.toggleReminderEnable(id);
    await loadReminders();
  }

  Future<List<Reminder>> getEnabledReminders() async {
    return _reminders.where((reminder) => reminder.enable).toList();
  }

  Future<int> getReminderCount() async {
    return _reminders.length;
  }

  Future<void> deleteAllReminders() async {
    await repo.deleteAllReminders();
    await loadReminders();
  }

  List<Reminder> getRemindersForDate(DateTime date) {
    return _reminders.where((reminder) {
      final reminderTime = TimeOfDay(hour: reminder.time.hour, minute: reminder.time.minute);
      return reminderTime.hour == date.hour && reminderTime.minute == date.minute;
    }).toList();
  }

  void syncReminderNotification(){
    Get.find<NotificationHelper>().cancelAllNotificationsExceptOne(exceptNotificationId: Constant.NOTIFICATION_BACKUP);
    for (var reminder in _reminders) {
      if(reminder.enable){
        Get.find<NotificationHelper>().schedulePeriodicNotification(
          id: reminder.id!,
          hour: reminder.time.hour,
          minute: reminder.time.minute,
          title: reminder.title,
          body: reminder.body,
        );
      }
      else{
        Get.find<NotificationHelper>().cancelNotification(reminder.id!);
      }
    }
  }
}