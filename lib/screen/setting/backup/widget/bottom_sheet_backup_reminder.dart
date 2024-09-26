import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../helper/notification_helper.dart';

class BottomSheetBackupReminder extends StatefulWidget {
  const BottomSheetBackupReminder({super.key});

  @override
  BottomSheetBackupReminderState createState() => BottomSheetBackupReminderState();
}

class BottomSheetBackupReminderState extends State<BottomSheetBackupReminder> {
  NotificationInterval _selectedInterval = NotificationInterval.none;
  final FixedExtentScrollController _controller = FixedExtentScrollController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedInterval =
          NotificationInterval.values.firstWhere((interval) => interval.getLocalizedMessage(context) == context.read<BackupProvider>().reminderType);
      _controller.jumpToItem(NotificationInterval.values.indexOf(_selectedInterval));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            titleAlignment: ListTileTitleAlignment.center,
            leading: const Icon(Icons.star,color: Colors.transparent,),
            title: Center(child: Text(S.of(context).selectReminderTime,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
            trailing: InkWell(
              onTap: (){
                Get.back();
                context.read<BackupProvider>().saveReminderType(_selectedInterval.name,context);
              },
              child: const Icon(Icons.check,color: Colors.white,)),
          ),
          SizedBox(
            height: 240,
            child: ListWheelScrollView(
              controller: _controller,
              itemExtent: 50,
              diameterRatio: 1.5,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedInterval = NotificationInterval.values[index];
                });
              },
              children: NotificationInterval.values.map((interval) {
                return Container(
                  decoration: BoxDecoration(
                    color: _selectedInterval == interval ? Theme.of(context).cardTheme.color : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      interval.getLocalizedMessage(context),
                      style: TextStyle(
                        fontSize: 18,
                        color: _selectedInterval == interval ? Colors.white : Colors.blueGrey.shade100,
                        fontWeight: _selectedInterval == interval ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}