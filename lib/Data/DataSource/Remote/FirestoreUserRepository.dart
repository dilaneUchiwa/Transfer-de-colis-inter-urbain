import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transfert_colis_interurbain/App/Service/Authentification.dart';
import '../../../Domain/Model/UserApp.dart';
import '../../../Domain/Repositories/UserRepository.dart';
import '../../../Utils/Converter.dart';

class FirestoreUserRepository implements UserRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('user');

  Future<UserApp> documentsnapshotToUser(
      DocumentSnapshot documentSnapshot) async {
    final user = UserApp(
        documentSnapshot.id,
        documentSnapshot.get('userName'),
        documentSnapshot.get('userSurname'),
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('userDateOfBirth')),
        documentSnapshot.get('userSexe'),
        documentSnapshot.get('userPhotoIdCardRecto'),
        documentSnapshot.get('userPhotoIdCardVerso'),
        documentSnapshot.get('userPhoto'),
        documentSnapshot.get('userTelephoneNumber'),
        documentSnapshot.get('userEmail'),
        documentSnapshot.get('userPassword'),
        documentSnapshot.get('userToken'),
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('createdAt')),
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('modifiedAt')),
        documentSnapshot.get('isValid') as bool,
        documentSnapshot.get('isAdmin') as bool);
    return user;
  }

  @override
  Future<void> addUser(UserApp user) async {
    final now = DateTime.now();
    return await _collectionReference.add({
      'userName': user.userName,
      'userSurname': user.userSurname,
      'userDateOfBirth': user.userDateOfBirth,
      'userSexe': user.userSexe,
      'userPhotoIdCardRecto': user.userPhotoIdCardRecto,
      'userPhotoIdCardVerso': user.userPhotoIdCardVerso,
      'userPhoto': user.userPhoto,
      'userTelephoneNumber': user.userTelephoneNumber,
      'userEmail': user.userEmail,
      'userPassword': user.userPassword,
      'userToken': user.userToken,
      'createdAt': now,
      'modifiedAt': null,
      'isValid': false,
      'isAdmin': false
    }).then((DocumentReference doc) {
      user.userId = doc.id;
      user.createdAt = now;
      AuthentificationService()
          .signUpWithEmailAndPassword(user.userEmail!, user.userPassword!);
    });
  }

  @override
  Stream<List<UserApp>> getUsers() {
    return _collectionReference.snapshots().asyncMap(
        (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
              return documentsnapshotToUser(doc);
            }).toList()));
  }

  @override
  Future<UserApp> getUserById(String id) async {
    final snapshot = await _collectionReference.doc(id).get();
    if (!snapshot.exists) {
      throw FirebaseException(
          message: 'User with id $id does not exist',
          code: 'not-found',
          plugin: '');
    }
    return documentsnapshotToUser(snapshot);
  }

  Future<UserApp?> getUserByEmail(String email) async {
    final snapshot =
        await _collectionReference.where("userEmail", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return documentsnapshotToUser(snapshot.docs.first);
      // Utilisez l'objet user ici
    } else {
      // Aucun document ne correspond à la condition de filtre
      return null;
    }
  }

  Future<bool> checkEmailAvailability(String email) async {
    final snapshot =
        await _collectionReference.where("userEmail", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      return false;
      // Utilisez l'objet user ici
    } else {
      // Aucun document ne correspond à la condition de filtre
      return true;
    }
  }

  @override
  Future<void> updateUser(UserApp user) async {
    final now = DateTime.now();

    print("User token : ${user.userToken}");
    
    return await _collectionReference.doc(user.userId).update({
      'userName': user.userName,
      'userSurname': user.userSurname,
      'userDateOfBirth': user.userDateOfBirth,
      'userSexe': user.userSexe,
      'userPhotoIdCardRecto': user.userPhotoIdCardRecto,
      'userPhotoIdCardVerso': user.userPhotoIdCardVerso,
      'userPhoto': user.userPhoto,
      'userTelephoneNumber': user.userTelephoneNumber,
      'userEmail': user.userEmail,
      'userPassword': user.userPassword,
      'userToken': user.userToken,
      'createdAt': user.createdAT,
      'modifiedAt': now
    }).then((e) {
      user.ModifiedAt = now;
    });
  }

  @override
  Future<void> validateUser(UserApp user) async {
    final now = DateTime.now();
    return await _collectionReference
        .doc(user.userId)
        .update({'isValid': true});
  }

  @override
  Stream<List<UserApp>?> getUnalidatUsers() {
    return _collectionReference
        .where("isValid", isEqualTo: false)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return documentsnapshotToUser(doc);
                }).toList()));
  }

  Future<List<String>?> getAdminMail() async {
    var querySnapshot =
        await _collectionReference.where("isAdmin", isEqualTo: true).get();

    List<String> emails = [];

    querySnapshot.docs.forEach((doc) async {
      final email = doc.get("userEmail");
      emails.add(email);
    });
    return emails;
  }
}
