import '../../Data/DataSource/Remote/FirestorePackageRepository.dart';
import '../../Domain/Model/Packages.dart';
import '../../Domain/Model/UserApp.dart';

class PackagesManager {
  final FirestorePackagesRepository _firestorePackagesRepository =
      FirestorePackagesRepository();

  PackagesManager();

  Future<void> addPackages(Packages pack) async {
    return await _firestorePackagesRepository.addPackage(pack);
  }

  Future<void> updatePackages(Packages pack) async {
    return await _firestorePackagesRepository.updatePackage(pack);
  }

  Future<List<Packages>> getPackages() async {
    return await _firestorePackagesRepository.getPackages();
  }

  Future<Packages> getPackageById(String id) async {
    return await _firestorePackagesRepository.getPackageById(id);
  }

  Stream<List<Packages>> getUserSenderPackages(UserApp user) {
    return _firestorePackagesRepository.getUserSenderPackages(user);
  }

  Stream<List<Packages>> getTravelPackages(String id) {
    return _firestorePackagesRepository.getTravelPackages(id);
  }
}
