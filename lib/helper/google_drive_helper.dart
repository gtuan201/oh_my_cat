import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:mood_press/helper/database_helper.dart';
import 'package:path_provider/path_provider.dart';

class GoogleDriveService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveFileScope,drive.DriveApi.driveReadonlyScope],
  );

  Future<void> googleSignIn() async {
    await _googleSignIn.signIn();
  }
  Future<void> checkSignInOnStartup() async {
    try {
      await _googleSignIn.signInSilently();
    } catch (error) {
      log('Lỗi khi kiểm tra đăng nhập: $error');
    }
  }

  Future<void> googleSignOut() async {
    await _googleSignIn.signOut();
  }

  Future<drive.DriveApi?> _getDriveApi() async {
    final auth.AuthClient? client = await currentUser()?.authHeaders.then(
          (headers) => auth.authenticatedClient(http.Client(), auth.AccessCredentials(
        auth.AccessToken('Bearer', headers['Authorization']!.split(' ')[1], DateTime.now().toUtc().add(const Duration(hours: 1))),
        null,
        [drive.DriveApi.driveFileScope],
      )),
    );
    return client == null ? null : drive.DriveApi(client);
  }

  GoogleSignInAccount? currentUser(){
    return _googleSignIn.currentUser;
  }

  Future<String?> createFolder()async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      log('Sign in failed');
      return null;
    }
    final result = await driveApi.files.list(
      q: "mimeType='application/vnd.google-apps.folder' and name='OhMyCat'",
      spaces: 'drive',
    );
    if(result.files!.isEmpty){
      final folder = await driveApi.files.create(
        drive.File()
          ..name = 'OhMyCat'
          ..mimeType = 'application/vnd.google-apps.folder',
      );
      return folder.id;
    }
    else{
      return result.files?.first.id;
    }
  }

  Future<void> uploadFile(String filePath, String fileName) async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      log('Sign in failed');
      return;
    }

    String folderID = await createFolder() ?? '';

    String jsonString = await Get.find<DatabaseHelper>().getDataAsJsonString();
    final file = await writeJson(jsonString);
    final media = drive.Media(file.openRead(), file.lengthSync());
    final driveFile = drive.File()
      ..name = fileName..parents = [folderID];

    try {
      final result = await driveApi.files.create(driveFile, uploadMedia: media);
      log('File uploaded. ID: ${result.id}');
    } catch (e) {
      log('Error uploading file: $e');
    }
  }

  Future<List<drive.File>> getListFile()async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      log('Sign in failed');
      return [];
    }

    String folderID = await createFolder() ?? '';
    try {
      final fileList = await driveApi.files.list(
        q: "'$folderID' in parents and trashed = false",
        $fields: 'files(id, name, mimeType)',
      );

      final files = fileList.files ?? [];
      return files;
    } catch (e) {
      log('Lỗi khi lấy danh sách file: $e');
      return [];
    }
  }

  Future<String?> getFileContent(String fileId) async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      log('Sign in failed');
      return null;
    }

    try {
      drive.Media fileContent = await driveApi.files.get(fileId,
          downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

      List<int> dataStore = [];
      await for (var data in fileContent.stream) {
        dataStore.addAll(data);
      }

      String jsonString = utf8.decode(dataStore);
      return jsonString;

    } catch (e) {
      log('Lỗi khi lấy nội dung file: $e');
      return null;
    }
  }

  Future<bool> deleteFileFromDrive(String fileId) async {
    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      log('Sign in failed');
      return false;
    }
    try {
      await driveApi.files.delete(fileId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<File> writeJson(String json) async {
    final file = await _localFile;
    return file.writeAsString(json);
  }
}