import 'package:cloud_firestore/cloud_firestore.dart';
import '/Domain/Model/Payment.dart';
import '/Domain/Repositories/PaymentRepository.dart';

class FirestorePaymentRepository implements PaymentRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Payment');

  Future<Payment> documentsnapshotToPayment(
      DocumentSnapshot documentSnapshot) async {
    final payment = Payment(
        documentSnapshot.id,
        documentSnapshot.get('PaymentOperator'),
        int.parse(documentSnapshot.get('PaymentPrice')),
        documentSnapshot.get('status'),
        documentSnapshot.get('account'),
        documentSnapshot.get('timestamp'));
    return payment;
  }

  @override
  Future<void> addPayment(Payment payment) {
    return _collectionReference.add({
      'PaymentOperator': payment.paymentOperator,
      'PaymentPrice': payment.paymentPrice,
      'status': payment.status,
      'account': payment.account,
      'timestamp': DateTime.now()
    }).then((DocumentReference doc) => payment.paymentId = doc.id);
  }

  @override
  Future<List<Payment>> getPayments() async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    List<Payment> Payments = [];

    querySnapshot.docs.forEach((doc) async {
      final payment = await documentsnapshotToPayment(doc);
      Payments.add(payment);
    });

    return Payments;
  }

  @override
  Future<Payment> getPaymentById(String id) async {
    final snapshot = await _collectionReference.doc(id).get();
    if (!snapshot.exists) {
      throw FirebaseException(
          message: 'Payment with id $id does not exist',
          code: 'not-found',
          plugin: '');
    }
    return documentsnapshotToPayment(snapshot);
  }

  @override
  Future<void> updatePayment(Payment payment) {
    return _collectionReference.doc(payment.paymentId).update({
      'PaymentOperator': payment.paymentOperator,
      'PaymentPrice': payment.paymentPrice,
      'status': payment.status,
      'account': payment.account,
      'timestamp':payment.timestamp
    });
  }
}
