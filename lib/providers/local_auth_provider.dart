import 'package:flutter/cupertino.dart';
import 'package:mood_press/data/repository/local_auth_repo.dart';

class LocalAuthProvider extends ChangeNotifier{
  final LocalAuthRepo repo;

  bool enableAuth = false;
  bool enableBiometric = false;

  LocalAuthProvider({required this.repo});

  Future<void> savePassword(String password) async {
    await repo.savePassword(password);
  }

  Future<String?> getPassword() async {
    return repo.getPassword();
  }

  Future<void> deletePassword() async {
    await repo.deletePassword();
  }

  Future<void> enableLocalAuth() async {
    await repo.enableLocalAuth();
    await getStatusLocalAuth();
  }
  Future<void> disableLocalAuth() async {
    await repo.disableLocalAuth();
    await repo.disableAuthBio();
    await getStatusAuthBio();
    await getStatusLocalAuth();
  }
  Future<void> getStatusLocalAuth() async {
    enableAuth = await repo.getStatusLocalAuth();
    notifyListeners();
  }
  Future<void> enableAuthBio() async {
    await repo.enableAuthBio();
    await getStatusAuthBio();
  }
  Future<void> disableAuthBio() async {
    await repo.disableAuthBio();
    await getStatusAuthBio();
  }
  Future<void> getStatusAuthBio() async {
    enableBiometric = await repo.getStatusAuthBio();
    notifyListeners();
  }
  void toggleBiometricAuth(bool enable){
    enableBiometric = enable;
    notifyListeners();
  }
}