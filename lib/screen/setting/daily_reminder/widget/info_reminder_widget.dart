import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/reminder.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helper/date_time_helper.dart';
import '../../../components/text_field_custom.dart';

class InfoReminderWidget extends StatefulWidget {
  final Reminder reminder;
  final TextEditingController titleController;
  final TextEditingController bodyController;

  final FocusNode titleFocusNode;
  final FocusNode bodyFocusNode;

  final RxInt hour;
  final RxInt minute;

  const InfoReminderWidget(
      {super.key,
      required this.reminder,
      required this.titleController,
      required this.bodyController,
      required this.titleFocusNode,
      required this.bodyFocusNode,
      required this.hour,
      required this.minute});

  @override
  State<InfoReminderWidget> createState() => _InfoReminderWidgetState();
}

class _InfoReminderWidgetState extends State<InfoReminderWidget> {

  @override
  void initState() {
    super.initState();
    widget.hour.value = widget.reminder.time.hour;
    widget.minute.value = widget.reminder.time.minute;
    widget.titleController.text = widget.reminder.title;
    widget.bodyController.text = widget.reminder.body;
  }

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).cardTheme.shadowColor!,
            width: 3
        )
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12,),
        InkWell(
          onTap: (){
            showTimePicker();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
            decoration: decoration,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      'Thời gian nhắc nhở',
                      style: TextStyle(
                          color: Colors.blueGrey.shade100,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                Obx(() => Text(
                  DateTimeHelper.formatTimeOfDay(
                      TimeOfDay(hour: widget.hour.value, minute: widget.minute.value)),
                  style: TextStyle(color: Colors.blueGrey.shade200),
                )),
                const SizedBox(width: 8,),
                Icon(Icons.arrow_forward_ios,size: 18,color: Colors.blueGrey.shade200,)
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 18),
          margin: const EdgeInsets.only(top: 16),
          decoration: decoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tiêu đề',style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 16,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              TextFieldCustom(controller: widget.titleController,hint: "Nhập văn bản",maxLength: 30,focusNode: widget.titleFocusNode,),
              const SizedBox(height: 10,),
              Text('Nội dung thông báo',style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 16,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              TextFieldCustom(controller: widget.bodyController,hint: "Nhập văn bản",maxLength: 200,focusNode: widget.bodyFocusNode,),
            ],
          ),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }
  void showTimePicker(){
    Navigator.of(context).push(
        showPicker(
          context: context,
          is24HrFormat: true,
          cancelText: 'Đóng',
          okText: 'Chọn',
          backgroundColor: ColorName.colorPrimary,
          accentColor: Colors.white,
          okStyle: const TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.w800,fontSize: 18),
          cancelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w800,fontSize: 18),
          value: Time(hour: widget.hour.value, minute: widget.minute.value),
          onChange: (time ) {
            widget.hour.value = time.hour;
            widget.minute.value = time.minute;
          },
        )
    );
  }
}

