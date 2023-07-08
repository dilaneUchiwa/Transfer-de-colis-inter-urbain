import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Domain/Model/UserApp.dart';
import '../../../Utils/Converter.dart';
import '/App/Manager/UserManager.dart';
import '/Data/DataSource/Remote/FirestoreUserRepository.dart';
import '/Domain/Model/Packages.dart';
import '/Domain/Repositories/PackageRepository.dart';

class FirestorePackagesRepository implements PackagesRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Packages');

  Future<Packages> documentsnapshotToPackage(
      DocumentSnapshot documentSnapshot) async {
    UserManager userManager = UserManager();

    final user1 =
        await userManager.getUserById(documentSnapshot.get('userSender'));
   
    final packages = Packages(
        documentSnapshot.id,
        documentSnapshot.get('PackageDescription'),
        documentSnapshot.get('PackagePhoto'),
        documentSnapshot.get('PackageValue'),
        user1,
        documentSnapshot.get('travelId'),
        );
    return packages;
  }

  @override
  Future<void> addPackage(Packages pack) async {
    return await _collectionReference.add({
      'PackageDescription': pack.packageDescription,
      'PackagePhoto': pack.packagePhoto,
      'PackageValue': pack.packageValue,
      'userSender': pack.userSender.userId,
      'travelId': pack.travelId,
    }).then((DocumentReference doc) => pack.packageId = doc.id);
  }

  @override
  Future<List<Packages>> getPackages() async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    List<Packages> packs = [];

    for (var doc in querySnapshot.docs) {
      final pack = await documentsnapshotToPackage(doc);
      packs.add(pack);
    }

    return packs;
  }

  Stream<List<Packages>> getUserSenderPackages(UserApp user) {
    return _collectionReference
        //.where("travelDate", isGreaterThanOrEqualTo: DateTime.now())
        .where("userSender", isEqualTo: user.userId)
        //.orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return await documentsnapshotToPackage(doc);
                }).toList()));
  }

  Stream<List<Packages>> getTravelPackages(String id) {
    return _collectionReference
        //.where("travelDate", isGreaterThanOrEqualTo: DateTime.now())
        .where("travelId", isEqualTo: id)
        //.orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return await documentsnapshotToPackage(doc);
                }).toList()));
  }

  @override
  Future<Packages> getPackageById(String id) async {
    final snapshot = await _collectionReference.doc(id).get();
    if (!snapshot.exists) {
      throw FirebaseException(
          message: 'Packages with id $id does not exist',
          code: 'not-found',
          plugin: '');
    }
    return documentsnapshotToPackage(snapshot);
  }

  @override
  Future<void> updatePackage(Packages pack) {
    return _collectionReference.doc(pack.packageId).update({
      'PackageDescription': pack.packageDescription,
      'PackagePhoto': pack.packagePhoto,
      'PackageValue': pack.packageValue,
      'userSender': pack.userSender.userId,
      'travelId': pack.travelId,
    });
  }

}
