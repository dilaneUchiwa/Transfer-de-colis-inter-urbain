import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Converter.dart';
import '/App/Manager/PackageManager.dart';
import '/App/Manager/PaymentManager.dart';
import '/App/Manager/TravelManager.dart';
import '/App/Manager/UserManager.dart';
import '/Data/DataSource/Remote/FirestorePackageRepository.dart';
import '/Data/DataSource/Remote/FirestorePaymentRepository.dart';
import '/Data/DataSource/Remote/FirestoreTravelRepository.dart';
import '/Domain/Model/Transfert.dart';
import '/Domain/Repositories/TransfertRepository.dart';

import 'FirestoreUserRepository.dart';

class FirestoreTransfertRepository implements TransfertRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('transfert');

  Future<Transfert> documentsnapshotToTransfert(
      DocumentSnapshot documentSnapshot) async {
    UserManager userManager = UserManager();
    TravelManager travelManager = TravelManager();
    PaymentManager paymentManager = PaymentManager();
    PackagesManager packagesManager = PackagesManager();

    final receiver = documentSnapshot.get('ReceiverId') == null
        ? null
        : await userManager.getUserById(documentSnapshot.get('ReceiverId'));

    final travel =
        await travelManager.getTravelById(documentSnapshot.get('travelId'));

    final payment = documentSnapshot.get('paymentId') == null
        ? null
        : await paymentManager
            .getPaymentById(documentSnapshot.get('paymentId'));

    final pack =
        await packagesManager.getPackageById(documentSnapshot.get('packageId'));

    final receiptAt = documentSnapshot.get('receiptAt') == null
        ? null
        : MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('receiptAt'));

    final transfert = Transfert(
        documentSnapshot.id,
        travel,
        payment,
        pack,
        receiver,
        documentSnapshot.get('code'),
        documentSnapshot.get('finish'),
        documentSnapshot.get('read'),
        documentSnapshot.get('accept'),
        documentSnapshot.get('reject'),
        MyConverter.convertTimestampToDateTime(
            documentSnapshot.get('createdAt')),
        receiptAt);
    return transfert;
  }

  // @override
  // Future<void> addTransfert(Transfert transfert) {
  //   return _collectionReference.add({
  //     'travelId': transfert.travel.travelId,
  //     'code': null,
  //     'paymentId': transfert.payment.paymentId,
  //     'packageId': transfert.package.packageId,
  //     'ReceiverId': transfert.receiver.userId,
  //     'SenderId': transfert.travel.user.userId,
  //     'finish': false,
  //     'read': false,
  //     'accept': false,
  //     'createdAt': DateTime.now(),
  //     'receiptAt': null
  //   }).then((DocumentReference doc) => transfert.transfertId = doc.id);
  // }

  @override
  Future<void> addTransfert(Transfert transfert) {
    return _collectionReference.add({
      'travelId': transfert.travel.travelId,
      'code': 0,
      'paymentId': null,
      'packageId': transfert.package.packageId,
      'ReceiverId': null,
      'TravellerId': transfert.travel.user.userId,
      'SenderId': transfert.travel.user.userId,
      'finish': false,
      'read': false,
      'accept': false,
      'reject': false,
      'createdAt': DateTime.now(),
      'receiptAt': null
    }).then((DocumentReference doc) => transfert.transfertId = doc.id);
  }

  @override
  Stream<List<Transfert>> getUserTravellerTansferts(String userId) {
    return _collectionReference
        .where("TravellerId", isEqualTo: userId)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return documentsnapshotToTransfert(doc);
                }).toList()));
  }

  @override
  Stream<List<Transfert>> getUserReceiverTansferts(String userId) {
    return _collectionReference
        .where("ReceiverId", isEqualTo: userId)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return documentsnapshotToTransfert(doc);
                }).toList()));
  }

  @override
  Stream<List<Transfert>> getUserSenderTansferts(String userId) {
    return _collectionReference
        .where("SenderId", isEqualTo: userId)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return documentsnapshotToTransfert(doc);
                }).toList()));
  }

  @override
  Future<Transfert?> getTransfertById(String id) async {
    final snapshot = await _collectionReference.doc(id).get();
    if (!snapshot.exists) {
      return null;
    }
    return documentsnapshotToTransfert(snapshot);
  }

  @override
  Future<Transfert?> getTransfertByCode(String code) async {
    QuerySnapshot snapshot = await _collectionReference
        .where("code", isEqualTo: int.parse(code))
        .where("finish", isEqualTo: false)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return documentsnapshotToTransfert(snapshot.docs.first);
  }

  @override
  Stream<List<Transfert>> getTransferts() {
    return _collectionReference.snapshots().asyncMap(
        (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
              return documentsnapshotToTransfert(doc);
            }).toList()));
  }

  @override
  Future<void> updateTransfert(Transfert transfert) {
    return _collectionReference.doc(transfert.transfertId).update({
      'travelId': transfert.travel.travelId,
      //'paymentId': transfert.payment.paymentId,
      'packageId': transfert.package.packageId,
      //'ReceiverId': transfert.receiver.userId,
      'finish': transfert.isfinish,
      'read': transfert.isRead,
      'reject': transfert.isReject,
      'accept': transfert.isAccept,
      'createdAt': transfert.createdAT
    });
  }

  Future<void> updateTransfertRead(Transfert transfert) {
    return _collectionReference.doc(transfert.transfertId).update({
      'read': true,
    });
  }

  Future<void> updateTransfertReceiverAdd(Transfert transfert, String id) {
    return _collectionReference.doc(transfert.transfertId).update({
      'ReceiverId': id,
    });
  }

  Future<void> updateTransfertFinish(Transfert transfert) {
    return _collectionReference
        .doc(transfert.transfertId)
        .update({'finish': true, 'receiptAt': DateTime.now()});
  }

  Future<void> updateTransfertAccept(Transfert transfert) {
    return _collectionReference.doc(transfert.transfertId).update({
      'accept': true,
    });
  }

  Future<void> updateTransfertReject(Transfert transfert) {
    return _collectionReference.doc(transfert.transfertId).update({
      'reject': true,
    });
  }

  Future<void> updateTransfertSetCode(Transfert transfert, int code) {
    return _collectionReference.doc(transfert.transfertId).update({
      'code': code,
    });
  }

  @override
  Stream<int> getSenderTransferCount(String id) {
    return _collectionReference
        .where("SenderId", isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Stream<int> getTravellerTransferCount(String id) {
    return _collectionReference
        .where("TravellerId", isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Stream<int> getTravellerUnReadTransferCount(String id) {
    return _collectionReference
        .where("TravellerId", isEqualTo: id)
        .where("read", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
}
