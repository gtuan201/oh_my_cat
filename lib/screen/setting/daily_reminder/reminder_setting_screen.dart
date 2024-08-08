import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/reminder.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/providers/reminder_provider.dart';
import 'package:mood_press/screen/setting/daily_reminder/widget/info_reminder_widget.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';

class ReminderSettingScreen extends StatefulWidget {
  final Reminder reminder;
  const ReminderSettingScreen({super.key, required this.reminder});

  @override
  State<ReminderSettingScreen> createState() => _ReminderSettingScreenState();
}

class _ReminderSettingScreenState extends State<ReminderSettingScreen> {

  late ReminderProvider reminderProvider;

  RxInt hour = 0.obs;
  RxInt minute = 0.obs;

  final BoxDecoration decoration = BoxDecoration(
      color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
          color: Colors.blueGrey.withBlue(140),
          width: 3
      )
  );

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode bodyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    reminderProvider = context.read<ReminderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        title: Text(widget.reminder.title),
        backgroundColor: ColorName.colorPrimary,
        centerTitle: false,
        elevation: 0,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            margin: const EdgeInsets.only(right: 16,left: 16),
            child: ElevatedButton(
              onPressed: (){
                updateReminder();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(100, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                backgroundColor: Colors.teal
              ),
              child: const Text('Lưu',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InfoReminderWidget(reminder: widget.reminder,
                titleController: titleController,
                bodyController: bodyController,
                titleFocusNode: titleFocusNode,
                bodyFocusNode: bodyFocusNode,
                hour: hour,
                minute: minute),
            ElevatedButton(
              onPressed: () {
                showConfirmationDialog(context).then((confirm){
                  if(confirm == true){
                    reminderProvider.deleteReminder(widget.reminder.id!).then((canDelete){
                      if(!canDelete){
                        showCustomToast(context: context, message: 'Không thể xoá mục này');
                      }
                      else{
                        Get.back();
                      }
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: Size(Get.width, 42)
              ),
              child: const Text('Xoá',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
            )
          ],
        ),
      ),
    );
  }

  void updateReminder(){
    if(titleController.text.isEmpty || bodyController.text.isEmpty){
      showCustomToast(
          context: context,
          message: 'Hãy điền đầy đủ thông tin',
          backgroundColor: Colors.redAccent);
    }
    else{
      widget.reminder..time = TimeOfDay(hour: hour.value, minute: minute.value)
        ..title = titleController.text
        ..body = bodyController.text;
      reminderProvider.updateReminder(widget.reminder);
      showCustomToast(context: context, message: "Cập nhật thành công");
      titleFocusNode.unfocus();
      bodyFocusNode.unfocus();
    }
  }
}
