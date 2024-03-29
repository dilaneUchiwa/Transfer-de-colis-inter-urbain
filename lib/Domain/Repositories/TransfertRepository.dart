import '/Domain/Model/Transfert.dart';

abstract class TransfertRepository {
  Future<void> addTransfert(Transfert transfert);
  Future<Transfert?> getTransfertById(String id);
  Stream<List<Transfert>> getByTravelAcceptTansferts(String id);
  Future<Transfert?> getTransfertByCode(String code);
  Future<void> updateTransfert(Transfert transfert);
  Future<void> updateTransfertReceiverAdd(Transfert transfert, String id);
  Future<void> updateTransfertSetCode(Transfert transfert, int code);
  Future<void> updateTransfertAccept(Transfert transfert);
  Future<void> updateTransfertReject(Transfert transfert);
  Future<void> updateTransfertFinish(Transfert transfert);
  Future<void> updateTransfertExchange(Transfert transfert);
  Future<void> updateTransfertRead(Transfert transfert);
  Stream<List<Transfert>> getTransferts();

  Stream<List<Transfert>> getUserSenderTansferts(String userId);
  Stream<List<Transfert>> getUserReceiverTansferts(String userId);
  Stream<List<Transfert>> getUserTravellerTansferts(String userId);
  Stream<List<Transfert>> getByTravelTansferts(String id);
  Stream<int> getSenderTransferCount(String id);
  Stream<int> getTravellerTransferCount(String id);
  Stream<int> getTravellerUnReadTransferCount(String id);
}
