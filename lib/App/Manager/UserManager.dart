import 'dart:math';

import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';

import '../../Domain/Model/UserApp.dart';

class UserManager {
  final FirestoreUserRepository _firestoreUserRepository =
      FirestoreUserRepository();

  UserManager();

  Future<void> addUser(UserApp user) async {
    return await _firestoreUserRepository.addUser(user);
  }

  Future<void> updateUser(UserApp user) async {
    return await _firestoreUserRepository.updateUser(user);
  }

  Stream<List<UserApp>> getUsers() {
    return _firestoreUserRepository.getUsers();
  }

  Future<UserApp> getUserById(String id) async {
    return await _firestoreUserRepository.getUserById(id);
  }

  Future<UserApp?> getUserByEmail(String email) async {
    return await _firestoreUserRepository.getUserByEmail(email);
  }

  Future<bool> checkEmailAvailability(String email) async {
    return await _firestoreUserRepository.checkEmailAvailability(email);
  }

  Future<void> validateUser(UserApp user) async {
    return await _firestoreUserRepository.validateUser(user);
  }

  Stream<List<UserApp>?> getUnalidatUsers() {
    return _firestoreUserRepository.getUnalidatUsers();
  }

  Future<List<String>?> getAdminMail() {
    return _firestoreUserRepository.getAdminMail();
  }
}
