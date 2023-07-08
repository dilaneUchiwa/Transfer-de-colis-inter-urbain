import '../Model/UserApp.dart';
import '/Domain/Model/Packages.dart';

abstract class PackagesRepository {
  Future<void> addPackage(Packages pack);
  Future<List<Packages>> getPackages();
  Future<Packages> getPackageById(String id);
  Future<void> updatePackage(Packages pack);
  Stream<List<Packages>> getUserSenderPackages(UserApp user);
  Stream<List<Packages>> getTravelPackages(String id);
}
