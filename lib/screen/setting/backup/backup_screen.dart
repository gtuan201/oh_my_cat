import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/screen/setting/backup/list_backup_screen.dart';
import 'package:mood_press/screen/setting/backup/widget/bottom_sheet_backup_reminder.dart';
import 'package:mood_press/screen/setting/backup/widget/function_widget.dart';
import 'package:mood_press/screen/setting/backup/widget/google_user_widget.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import '../../../generated/l10n.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  late BackupProvider backupProvider;

  @override
  void initState() {
    super.initState();
    backupProvider = context.read<BackupProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      backupProvider.getListFile();
      backupProvider.getReminderType(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).backup_restore),
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.of(context).backup_data, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            const GoogleUserWidget(),
            Divider(color: Colors.blueGrey.shade100, height: 32),
            Selector<BackupProvider, List<drive.File>>(
              builder: (context, listFile, _) {
                return FunctionWidget(
                  title: S.of(context).backup_data,
                  content: (listFile.isNotEmpty && listFile.first.name != null)
                      ? listFile.first.name!.substring(0, listFile.first.name!.lastIndexOf('.'))
                      : S.of(context).no_backup_data,
                  iconData: Icons.backup,
                  onTap: () async {
                    if (backupProvider.currentUser != null) {
                      showLoadingDialog(message: S.of(context).backing_up_data);
                      backupProvider.uploadFile("", "${DateTimeHelper.formatDateTimeToDDMMYYYYHHMMSS(DateTime.now())}.json").then((value) {
                        Get.back();
                        showCustomToast(context: context, message: S.of(context).backup_success);
                      });
                    } else {
                      showCustomToast(context: context, message: S.of(context).not_logged_in);
                    }
                  },
                );
              },
              selector: (context, backupProvider) => backupProvider.files,
            ),
            Selector<BackupProvider, String>(
              builder: (context, reminderType, _) {
                return FunctionWidget(
                  title: S.of(context).reminder_backup,
                  content: reminderType,
                  iconData: Icons.notifications_active,
                  onTap: () {
                    Get.bottomSheet(const BottomSheetBackupReminder());
                  },
                );
              },
              selector: (context, backupProvider) => backupProvider.reminderType,
            ),
            Selector<BackupProvider, List<drive.File>>(
              builder: (context, listFile, _) {
                return FunctionWidget(
                  title: S.of(context).existing_backups,
                  content: S.of(context).backup_count(listFile.length.toString()),
                  iconData: Icons.list,
                  onTap: () {
                    Get.to(() => const ListBackupScreen());
                  },
                );
              },
              selector: (context, backupProvider) => backupProvider.files,
            ),
          ],
        ),
      ),
    );
  }
}
