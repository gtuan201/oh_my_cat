import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mood_press/data/model/reminder.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/screen/setting/daily_reminder/reminder_setting_screen.dart';

class ItemReminder extends StatefulWidget {
  final Reminder reminder;
  final Function(bool) onToggle;
  final Function() onDelete;
  const ItemReminder({super.key, required this.reminder, required this.onToggle, required this.onDelete});

  @override
  State<ItemReminder> createState() => _ItemReminderState();
}

class _ItemReminderState extends State<ItemReminder> {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => ReminderSettingScreen(reminder: widget.reminder));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Colors.blueGrey.withBlue(140),
                width: 3
            )
        ),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.bell,color: Colors.blueGrey.shade100,),
            const SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.reminder.title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
                  const SizedBox(height: 4,),
                  Text(DateTimeHelper.formatTimeOfDay(widget.reminder.time),style: TextStyle(color: Colors.blueGrey.shade100),)
                ],
              )
            ),
            Switch(
              value: widget.reminder.enable,
              activeColor: Colors.tealAccent,
              onChanged: widget.onToggle
            )
          ],
        ),
      ),
    );
  }
}
