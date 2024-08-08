import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mood_press/data/repository/backup_repo.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:mood_press/helper/database_helper.dart';
import 'package:mood_press/helper/notification_helper.dart';
import 'package:mood_press/ulti/constant.dart';

class BackupProvider extends ChangeNotifier{
  final BackupRepo repo;
  GoogleSignInAccount? currentUser;
  String reminderType = NotificationInterval.none.message;
  NotificationHelper notificationHelper;
  List<drive.File> files = [];

  BackupProvider({required this.repo,required this.notificationHelper});

  void getCurrentUser(){
    currentUser = repo.currentUser();
    notifyListeners();
  }
  Future<void> googleSignIn()async {
    await repo.googleSignIn();
    getCurrentUser();
  }
  Future<void> checkSignInOnStartup()async {
    await repo.checkSignInOnStartup();
    getCurrentUser();
  }
  Future<void> googleSignOut() async {
    await repo.googleSignOut();
    getCurrentUser();
  }
  Future<void> uploadFile(String filePath, String fileName)async {
    await repo.uploadFile(filePath, fileName);
    await getListFile();
  }
  Future<void> getListFile()async {
    files = await repo.getListFile();
    notifyListeners();
  }
  Future<void> saveReminderType(String type) async {
    DateTime now = DateTime.now();
    notificationHelper.schedulePeriodicNotification(
        id: Constant.NOTIFICATION_BACKUP,
        hour: now.hour,
        minute: now.minute + 2,
        title: "Sao lưu dữ liệu",
        body: "Đã đến lúc sao lưu dữ liệu của bạn rồi",
        interval: NotificationInterval.values.firstWhere((interval) => interval.name == type)
    );
    await repo.saveReminderType(type);
    getReminderType();
  }
  void getReminderType() {
    reminderType = NotificationInterval.values.firstWhere((interval) => interval.name == repo.getReminderType()).message;
    notifyListeners();
  }
  Future<bool> deleteFileFromDrive(String fileId) async{
    return await repo.deleteFileFromDrive(fileId);
  }
  Future<bool> sync(String fileId) async {
    String? jsonString = await repo.getFileContent(fileId);
    if(jsonString != null){
      await Get.find<DatabaseHelper>().updateDatabaseFromJsonString(jsonString);
      return true;
    }
    return false;
  }
}