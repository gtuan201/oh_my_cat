import 'package:get/get.dart';
import 'package:mood_press/helper/database_helper.dart';
import 'package:mood_press/data/model/reminder.dart';
import 'package:mood_press/helper/notification_helper.dart';

class ReminderRepo {
  final DatabaseHelper db;

  ReminderRepo({required this.db});

  // Create
  Future<void> addReminder(Reminder reminder) async {
    await db.insertReminder(reminder);
  }

  // Read
  Future<List<Reminder>> getAllReminders() async {
    return await db.getReminders();
  }

  Future<Reminder?> getReminderById( id) async {
    return await db.getReminder(id);
  }

  // Update
  Future<void> updateReminder(Reminder reminder) async {
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
    await db.updateReminder(reminder);
  }

  // Delete
  Future<void> deleteReminder(int id) async {
    await db.deleteReminder(id);
  }

  // Các phương thức bổ sung

  // Lấy bản ghi mặc định
  Future<Reminder?> getDefaultReminder() async {
    return await db.getReminder(DatabaseHelper.DEFAULT_REMINDER_ID);
  }

  // Kiểm tra xem một reminder có phải là mặc định không
  Future<bool> isDefaultReminder(int id) async {
    final reminder = await db.getReminder(id);
    return reminder?.isDefault ?? false;
  }

  // Bật/tắt reminder
  Future<void> toggleReminderEnable(int id) async {
    final reminder = await db.getReminder(id);
    if (reminder != null) {
      reminder.enable = !reminder.enable;
      if(reminder.enable){
        Get.find<NotificationHelper>().schedulePeriodicNotification(
          id: id,
          hour: reminder.time.hour,
          minute: reminder.time.minute,
          title: reminder.title,
          body: reminder.body,
        );
      }
      else{
        Get.find<NotificationHelper>().cancelNotification(id);
      }
      await db.updateReminder(reminder);
    }
  }

  // Lấy tất cả reminder đang bật
  Future<List<Reminder>> getEnabledReminders() async {
    final allReminders = await db.getReminders();
    return allReminders.where((reminder) => reminder.enable).toList();
  }

  // Đếm số lượng reminder
  Future<int> getReminderCount() async {
    final allReminders = await db.getReminders();
    return allReminders.length;
  }

  // Xóa tất cả reminder (trừ bản ghi mặc định)
  Future<void> deleteAllReminders() async {
    final allReminders = await db.getReminders();
    for (var reminder in allReminders) {
      if (!reminder.isDefault) {
        await db.deleteReminder(reminder.id!);
      }
    }
  }
}