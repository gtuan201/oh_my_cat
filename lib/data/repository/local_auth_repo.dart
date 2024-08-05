import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mood_press/ulti/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthRepo{
  final FlutterSecureStorage storage;
  final SharedPreferences prefs;

  LocalAuthRepo({required this.storage,required this.prefs});

  Future<void> savePassword(String password) async {
    await storage.write(key: Constant.password, value: password);
  }

  Future<String?> getPassword() async {
    return await storage.read(key: Constant.password);
  }

  Future<void> deletePassword() async {
    await storage.delete(key: Constant.password);
  }

  Future<void> enableLocalAuth() async {
    await prefs.setBool(Constant.enableLocalAuth, true);
  }
  Future<void> disableLocalAuth() async {
    await prefs.setBool(Constant.enableLocalAuth, false);
  }
  Future<bool> getStatusLocalAuth() async {
    return prefs.getBool(Constant.enableLocalAuth) ?? false;
  }
  Future<void> enableAuthBio() async {
    await prefs.setBool(Constant.enableAuthBiometric, true);
  }
  Future<void> disableAuthBio() async {
    await prefs.setBool(Constant.enableAuthBiometric, false);
  }
  Future<bool> getStatusAuthBio() async {
    return prefs.getBool(Constant.enableAuthBiometric) ?? false;
  }
}