import '/Domain/Model/UserApp.dart';

abstract class UserRepository {
  Future<void> addUser(UserApp user);
  Stream<List<UserApp>> getUsers();
  Future<List<String>?> getAdminMail();
  Future<UserApp> getUserById(String id);
  Future<void> updateUser(UserApp user);
  Future<void> validateUser(UserApp user);
  Stream<List<UserApp>?> getUnalidatUsers();
}
