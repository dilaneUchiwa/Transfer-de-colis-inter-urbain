import '/Domain/Model/Payment.dart';

abstract class PaymentRepository{
  Future<void> addPayment(Payment payment);
  Future<List<Payment>> getPayments();
  Future<Payment> getPaymentById(String id);
  Future<void> updatePayment(Payment payment);
}
