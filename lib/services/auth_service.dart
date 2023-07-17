import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  Future<void> storeCredentialToLocal(
      String name, String email, String password) async {
    try {
      print('name : $name , email : $email , password : $password');
      const storage = FlutterSecureStorage();
      await storage.write(key: 'name', value: name);
      await storage.write(key: 'email', value: email);
      await storage.write(key: 'password', value: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getCredentialFromLocal() async {
    String email = "";

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'email');

    if (value != null) {
      email = value;
    }

    return email;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
