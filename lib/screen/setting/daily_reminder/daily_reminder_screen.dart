import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/screen/setting/daily_reminder/widget/info_reminder_widget.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:mood_press/screen/setting/daily_reminder/widget/item_reminder.dart';
import 'package:mood_press/data/model/reminder.dart';
import '../../../generated/l10n.dart';
import '../../../providers/reminder_provider.dart';

class DailyReminderScreen extends StatefulWidget {
  const DailyReminderScreen({super.key});

  @override
  State<DailyReminderScreen> createState() => _DailyReminderScreenState();
}

class _DailyReminderScreenState extends State<DailyReminderScreen> {
  late ReminderProvider _reminderProvider;

  @override
  void initState() {
    super.initState();
    _reminderProvider = Provider.of<ReminderProvider>(context, listen: false);
    _reminderProvider.loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).setup_reminder),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12,),
          Expanded(
            child: Consumer<ReminderProvider>(
              builder: (context, provider, child) {
                final List<Reminder> reminders = provider.reminders;
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ItemReminder(
                    reminder: reminders[index],
                    onToggle: (enabled) {
                      provider.toggleReminderEnable(reminders[index].id!);
                    },
                    onDelete: () {
                      provider.deleteReminder(reminders[index].id!);
                    },
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 12,),
                  itemCount: reminders.length,
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: ElevatedButton(
              onPressed: () {
                _addNewReminder();
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width, 42),
                  backgroundColor: Theme.of(context).splashColor
              ),
              child: Text(S.of(context).add_daily_reminder,),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewReminder() {
    RxInt hour = 0.obs;
    RxInt minute = 0.obs;
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();

    FocusNode titleFocusNode = FocusNode();
    FocusNode bodyFocusNode = FocusNode();
    Reminder newReminder = Reminder(
      id: DateTime.now().millisecond,
      title: '',
      body: '',
      enable: false,
      time: const TimeOfDay(hour: 20,minute: 0),
    );
    Get.bottomSheet(
      isScrollControlled: false,
        Container(
          height: 450,
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(width: 40,height: 4,color: Colors.blueGrey.shade100,),
              InfoReminderWidget(reminder: newReminder,
                titleController: titleController,
                bodyController: bodyController,
                titleFocusNode: titleFocusNode,
                bodyFocusNode: bodyFocusNode,
                hour: hour,
                minute: minute),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                  if(titleController.text.isEmpty || bodyController.text.isEmpty){
                    showCustomToast(
                    context: context,
                    message: S.of(context).fill_all_info,
                    backgroundColor: Colors.redAccent);
                  }
                  else{
                    newReminder..time = TimeOfDay(hour: hour.value, minute: minute.value)
                      ..title = titleController.text
                      ..body = bodyController.text;
                    _reminderProvider.addReminder(newReminder);
                    Get.back();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).splashColor,
                  fixedSize: Size(Get.width, 42)
                ),
                child: Text(S.of(context).add_reminder)
              )
            ],
          ),
        ),
      )
    );
  }
}