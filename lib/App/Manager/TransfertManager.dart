import '../../Data/DataSource/Remote/FirestoreTransfertRepository.dart';

import '../../Domain/Model/Transfert.dart';

class TransfertManager {
  final FirestoreTransfertRepository _firestoreTransfertRepository =
      FirestoreTransfertRepository();

  TransfertManager();

  Future<void> addTransfert(Transfert transfert) async {
    return await _firestoreTransfertRepository.addTransfert(transfert);
  }

  Future<void> updateTransfert(Transfert transfert) async {
    return await _firestoreTransfertRepository.updateTransfert(transfert);
  }

  Future<Transfert> getTransfertById(String id) async {
    return await _firestoreTransfertRepository.getTransfertById(id);
  }

  Future<void> updateTransfertRead(Transfert transfert) async {
    return await _firestoreTransfertRepository.updateTransfertRead(transfert);
  }

  Future<void> updateTransfertFinish(Transfert transfert) async {
    return await _firestoreTransfertRepository.updateTransfertFinish(transfert);
  }

  Future<void> updateTransfertAccept(Transfert transfert) async {
    return await _firestoreTransfertRepository.updateTransfertAccept(transfert);
  }

  Future<void> updateTransfertSetCode(Transfert transfert, int code) async {
    return await _firestoreTransfertRepository.updateTransfertSetCode(
        transfert, code);
  }

  Stream<List<Transfert>> getTransferts() {
    return _firestoreTransfertRepository.getTransferts();
  }

  Stream<List<Transfert>> getTransfertByCode(String code) {
    return _firestoreTransfertRepository.getTransfertByCode(code);
  }

  Stream<List<Transfert>> getUserSenderTansferts(String userId) {
    return _firestoreTransfertRepository.getUserSenderTansferts(userId);
  }

  Stream<List<Transfert>> getUserTravellerTansferts(String userId) {
    return _firestoreTransfertRepository.getUserTravellerTansferts(userId);
  }
    Stream<List<Transfert>> getUserReceiverTansferts(String userId) {
    return _firestoreTransfertRepository.getUserReceiverTansferts(userId);
  }
  Stream<int> getTravellerUnReadTransferCount(String id){
   return _firestoreTransfertRepository.getTravellerUnReadTransferCount(id); 
  }
  Stream<int> getTravellerTransferCount(String id){
   return _firestoreTransfertRepository.getTravellerTransferCount(id); 
  }
   Stream<int> getSenderTransferCount(String id){
   return _firestoreTransfertRepository.getSenderTransferCount(id); 
  }

}
