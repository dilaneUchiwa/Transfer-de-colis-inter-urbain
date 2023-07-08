import '../../Data/DataSource/Remote/FirestorePaymentRepository.dart';

import '../../Domain/Model/Payment.dart';

class PaymentManager{
  final FirestorePaymentRepository _firestorePaymentRepository=FirestorePaymentRepository();

  PaymentManager();

  Future<void> addPayment(Payment payment) async{
    return await _firestorePaymentRepository.addPayment(payment);
  }
  Future<void> updatePayment(Payment payment) async{
    return await _firestorePaymentRepository.updatePayment(payment);
  }
  Future<List<Payment>> getPayments() async{
    return await _firestorePaymentRepository.getPayments();
  }
  Future<Payment> getPaymentById(String id) async{
    return await _firestorePaymentRepository.getPaymentById(id);
  }
}