import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/gen/colors.gen.dart';
import 'package:mood_press/helper/date_time_helper.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/screen/setting/backup/list_backup_screen.dart';
import 'package:mood_press/screen/setting/backup/widget/bottom_sheet_backup_reminder.dart';
import 'package:mood_press/screen/setting/backup/widget/function_widget.dart';
import 'package:mood_press/screen/setting/backup/widget/google_user_widget.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import 'package:googleapis/drive/v3.dart' as drive;

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
      backupProvider.getReminderType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.colorPrimary,
      appBar: AppBar(
        title: const Text('Sao lưu & Khôi phục'),
        centerTitle: false,
        backgroundColor: ColorName.colorPrimary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Sao lưu dữ liệu của bạn vào Google Drive trong trường hợp bạn quân mật khẩu hoặc mất dữ liệu.',style: TextStyle(
              color: Colors.white
            ),),
            const SizedBox(height: 16,),
            const GoogleUserWidget(),
            Divider(color: Colors.blueGrey.shade100,height: 32,),
            Selector<BackupProvider,List<drive.File>>(
              builder: (context,listFile,_){
                return FunctionWidget(
                  title: 'Sao lưu dữ liệu',
                    content:
                        (listFile.isNotEmpty && listFile.first.name != null)
                            ? listFile.first.name!.substring(0,listFile.first.name!.lastIndexOf('.'))
                            : 'Chưa có dữ liệu sao lưu',
                    iconData: Icons.backup,
                  onTap: () async {
                    if(backupProvider.currentUser != null){
                      showLoadingDialog(message: "Sao lưu dữ liệu...");
                      backupProvider.uploadFile("", "${DateTimeHelper.formatDateTimeToDDMMYYYYHHMMSS(DateTime.now())}.json").then((value){
                        Get.back();
                        showCustomToast(context: context, message: "Sao lưu thành công");
                      });
                    }
                    else{
                      showCustomToast(context: context, message: 'Bạn chưa đăng nhập tài khoản Google');
                    }
                  },
                );
              },
              selector: (context,backupProvider) => backupProvider.files
            ),
            Selector<BackupProvider,String>(
              builder: (context,reminderType,_){
                return FunctionWidget(
                  title: 'Nhắc nhở sao lưu',
                  content: reminderType,
                  iconData: Icons.notifications_active,
                  onTap: (){
                    Get.bottomSheet(const BottomSheetBackupReminder());
                  },
                );
              },
                selector: (context,backupProvider) => backupProvider.reminderType
            ),
            Selector<BackupProvider,List<drive.File>>(
              builder: (context,listFile,_){
                return FunctionWidget(
                  title: 'Bản sao lưu hiện có',
                  content: 'Có ${listFile.length} bản ghi',
                  iconData: Icons.list,
                  onTap: (){
                    Get.to(() => const ListBackupScreen());
                  },
                );
              },
              selector: (context,backupProvider) => backupProvider.files
            ),
          ],
        ),
      ),
    );
  }
}
