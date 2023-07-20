import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import '../../../Utils/Converter.dart';
import '/App/Manager/UserManager.dart';
import '/Domain/Model/Travel.dart';
import '/Domain/Repositories/TravelRepository.dart';

class FirestoreTravelRepository implements TravelRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('travel');

  Future<Travel> documentsnapshotToTravel(
      DocumentSnapshot documentSnapshot) async {
    UserManager userManager = UserManager();
    final user =
        await userManager.getUserById(documentSnapshot.get('travelUserId'));
    final travel = Travel(
        documentSnapshot.id,
        documentSnapshot.get('townDepature'),
        documentSnapshot.get('townDestination'),
        documentSnapshot.get('quarterDepature'),
        documentSnapshot.get('quarterDestination'),
        documentSnapshot.get('agence'),
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('travelDate')),
        documentSnapshot.get('travelMoment'),
        user,
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('timestamp')));

    return travel;
  }

Future<Travel?> documentsnapshotToTravelWithMotif(
      DocumentSnapshot documentSnapshot,String motif) async {
    UserManager userManager = UserManager();
    final user =
        await userManager.getUserById(documentSnapshot.get('travelUserId'));
    final travel = Travel(
        documentSnapshot.id,
        documentSnapshot.get('townDepature'),
        documentSnapshot.get('townDestination'),
        documentSnapshot.get('quarterDepature'),
        documentSnapshot.get('quarterDestination'),
        documentSnapshot.get('agence'),
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('travelDate')),
        documentSnapshot.get('travelMoment'),
        user,
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('timestamp')));

    if(!documentSnapshot.get('townDestination').toString().toUpperCase().startsWith(motif.toUpperCase())) return null;
    return travel;
  }
  @override
  Future<void> addTravel(Travel travel) {
    return _collectionReference.add({
      'townDepature': travel.travelDeparture,
      'townDestination': travel.travelDestination,
      'quarterDepature': travel.quarterDeparture,
      'quarterDestination': travel.quarterDestination,
      'agence': travel.agence,
      'travelDate': travel.travelDate,
      'travelMoment': travel.travelMoment,
      'travelUserId': travel.user.userId,
      'timestamp': DateTime.now()
    }).then((DocumentReference doc) => travel.travelId = doc.id);
  }

  @override
  Stream<List<Travel>> getTravels() {
    return _collectionReference
        //.orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return await documentsnapshotToTravel(doc);
                }).toList()));
  }

  @override
  Stream<List<Travel>> getCommingTravels() {
    return _collectionReference
        .where("travelDate", isGreaterThanOrEqualTo: DateTime.now())
        .orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return await documentsnapshotToTravel(doc);
                }).toList()));
  }

  @override
  Stream<List<Travel?>> getTravelsWithMotif(String motif) {
    return _collectionReference
        //.where("travelDate", isGreaterThanOrEqualTo: DateTime.now())
        // .orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return await documentsnapshotToTravelWithMotif(doc,motif);
                }).toList()));
  }

  @override
  Stream<List<Travel>> getUserTravels(UserApp user) {
    return _collectionReference
        //.where("travelDate", isGreaterThanOrEqualTo: DateTime.now())
        .where("travelUserId", isEqualTo: user.userId)
        //.orderBy("timestamp", descending: true)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return await documentsnapshotToTravel(doc);
                }).toList()));
  }

  @override
  Future<Travel> getTravelById(String id) async {
    final snapshot = await _collectionReference.doc(id).get();
    if (!snapshot.exists) {
      throw FirebaseException(
          message: 'Travel with id $id does not exist',
          code: 'not-found',
          plugin: '');
    }
    return documentsnapshotToTravel(snapshot);
  }

  @override
  Future<void> updateTravel(Travel travel) {
    return _collectionReference.doc(travel.travelId).update({
      'townDepature': travel.travelDeparture,
      'townDestination': travel.travelDestination,
      'quarterDepature': travel.quarterDeparture,
      'quarterDestination': travel.quarterDestination,
      'agence': travel.agence,
      'travelDate': travel.travelDate,
      'travelMoment': travel.travelMoment,
      'travelUserId': travel.user.userId,
      'timestamp': travel.timestamp
    });
  }
}
