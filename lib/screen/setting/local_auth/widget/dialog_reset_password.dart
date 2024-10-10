import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/providers/local_auth_provider.dart';
import 'package:mood_press/screen/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import '../../../../generated/l10n.dart';
import '../../../../helper/date_time_helper.dart';
import '../../../../ulti/function.dart';

class DialogResetPassword extends StatefulWidget {
  const DialogResetPassword({super.key});

  @override
  State<DialogResetPassword> createState() => _DialogResetPasswordState();
}

class _DialogResetPasswordState extends State<DialogResetPassword> {

  RxBool backupSuccess = false.obs;
  RxBool deleteSuccess = false.obs;
  bool isRestart = false;

  @override
  Widget build(BuildContext context) {
    BackupProvider backupProvider = context.read<BackupProvider>();
    isRestart = backupProvider.currentUser != null;
    if(backupProvider.currentUser == null){
      backupSuccess.value = true;
    }
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Text(S.of(context).forgot_password,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
            const SizedBox(height: 16,),
            Text(S.of(context).instruction,style: const TextStyle(color: Colors.white,),),
            const SizedBox(height: 10,),
            Text(S.of(context).sync_to_drive,style: const TextStyle(color: Colors.white,),),
            const SizedBox(height: 10,),
            if(backupProvider.currentUser == null)
            Text(S.of(context).google_not_logged_in,style: const TextStyle(color: Colors.yellow,),),
            if(backupProvider.currentUser == null)
            const SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                onPressed: backupProvider.currentUser != null ? (){
                  showLoadingDialog(message: S.of(context).backing_up_data);
                  backupProvider.uploadFile("", "${DateTimeHelper.formatDateTimeToDDMMYYYYHHMMSS(DateTime.now())}.json").then((value) {
                    Get.back();
                    showCustomToast(context: context, message: S.of(context).backup_success);
                    backupSuccess.value = true;
                  });
                } : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.backup),
                    const SizedBox(width: 10,),
                    Text(S.of(context).backup_to_google_drive),
                  ],
                )
              ),
            ),
            const SizedBox(height: 10,),
            Text(S.of(context).delete_ohmycat_data,style: const TextStyle(color: Colors.white,),),
            const SizedBox(height: 10,),
            Center(
              child: Obx((){
                return ElevatedButton(
                    onPressed: backupSuccess.value ? (){
                      showLoadingDialog(message: S.of(context).deleting_data);
                      backupProvider.cleanAllData().then((_){
                        Get.back();
                        showCustomToast(context: context, message: S.of(context).deleted_success);
                        deleteSuccess.value = true;
                        backupSuccess.value = false;
                        backupProvider.googleSignOut();
                        context.read<LocalAuthProvider>().getStatusLocalAuth();
                      });
                    } : null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.folder_delete),
                        const SizedBox(width: 10,),
                        Text(S.of(context).clear_app_data),
                      ],
                    )
                );
              }),
            ),
            const SizedBox(height: 10,),
            Text(S.of(context).restart_and_sign_in,style: const TextStyle(color: Colors.white,),),
            const SizedBox(height: 10,),
            Center(
              child: Obx((){
                return ElevatedButton(
                    onPressed: deleteSuccess.value ? (){
                      Get.offAll(() => DashBoardScreen(isRestart: isRestart,));
                    }: null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.restart_alt),
                        const SizedBox(width: 10,),
                        Text(S.of(context).restart),
                      ],
                    )
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
