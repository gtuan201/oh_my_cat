import 'package:google_sign_in/google_sign_in.dart';
import 'package:mood_press/helper/google_drive_helper.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:mood_press/ulti/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/notification_helper.dart';

class BackupRepo{
  final GoogleDriveService googleDriveService;
  final SharedPreferences prefs;

  BackupRepo({required this.googleDriveService,required this.prefs});

  GoogleSignInAccount? currentUser(){
    return googleDriveService.currentUser();
  }
  Future<void> googleSignIn()async {
    await googleDriveService.googleSignIn();
  }
  Future<void> checkSignInOnStartup()async {
    await googleDriveService.checkSignInOnStartup();
  }
  Future<void> googleSignOut() async {
    await googleDriveService.googleSignOut();
  }
  Future<void> uploadFile(String filePath, String fileName)async {
    await googleDriveService.uploadFile(filePath, fileName);
  }
  Future<List<drive.File>> getListFile() async {
    return await googleDriveService.getListFile();
  }
  Future<void> saveReminderType(String type) async {
    await prefs.setString(Constant.reminderBackup, type);
  }
  String getReminderType() {
    return prefs.getString(Constant.reminderBackup) ?? NotificationInterval.none.name;
  }
  Future<bool> deleteFileFromDrive(String fileId) async{
    return await googleDriveService.deleteFileFromDrive(fileId);
  }
  Future<String?> getFileContent(String fileId) async {
    return await googleDriveService.getFileContent(fileId);
  }
}