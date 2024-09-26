import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:mood_press/providers/reminder_provider.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';

import '../../../../generated/l10n.dart';
import '../../../../providers/statisticaL_provider.dart';

class ItemBackupData extends StatelessWidget {
  final drive.File file;
  const ItemBackupData({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            file.name?.substring(0, file.name?.lastIndexOf('.')) ?? '',
            style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                showLoadingDialog(message: S.of(context).syncing_data);
                context.read<BackupProvider>().sync(file.id ?? '').then((success){
                  Get.back();
                  getDataSync(context);
                  showCustomToast(context: context,
                      message: success ? S.of(context).sync_completed : S.of(context).sync_error,
                      backgroundColor: success ? Colors.teal : Colors.red
                  );
                });
              },
              icon: const Icon(
                Icons.sync,
                color: Colors.white,
              )
          ),
          IconButton(
              onPressed: () {
                showConfirmationDialog(context,
                    nameDelete: file.name?.substring(0, file.name?.lastIndexOf('.')))
                    .then((confirm) {
                  if(confirm!){
                    delete(context);
                  }
                });
              },
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.white,
              )
          )
        ],
      ),
    );
  }
  delete(BuildContext context) async {
    showLoadingDialog(message: S.of(context).deleting_data);
    context.read<BackupProvider>().deleteFileFromDrive(file.id ?? '').then((value) async {
      await context.read<BackupProvider>().getListFile();
      Get.back();
      if (context.mounted) {
        showCustomToast(context: context,
            message: value ? S.of(context).deleted_success : S.of(context).delete_error,
            backgroundColor: value ? Colors.teal : Colors.red
        );
      }
    });
  }
  getDataSync(BuildContext context) {
    context.read<HomeProvider>().getMoods().then((value){
      context.read<StatisticalProvider>().percentOfMood();
    });
    context.read<StatisticalProvider>().getListTestResult();
    context.read<ReminderProvider>().loadReminders().then((value){
      context.read<ReminderProvider>().syncReminderNotification();
    });
  }
}