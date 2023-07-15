import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';

import '../../Data/DataSource/Remote/FirestoreTravelRepository.dart';

import '../../Domain/Model/Travel.dart';

class TravelManager {
  final FirestoreTravelRepository _firestoreTravelRepository =
      FirestoreTravelRepository();

  TravelManager();

  Future<void> addTravel(Travel travel) async {
    return await _firestoreTravelRepository.addTravel(travel);
  }

  Future<void> updateTravel(Travel travel) async {
    return await _firestoreTravelRepository.updateTravel(travel);
  }

  Stream<List<Travel>> getTravels() {
    return _firestoreTravelRepository.getTravels();
  }

  Stream<List<Travel>> getCommingTravels() {
    return _firestoreTravelRepository.getCommingTravels();
  }
  Stream<List<Travel?>> getTravelsWithMotif(String motif) {
    return _firestoreTravelRepository.getTravelsWithMotif(motif);
  }

  Stream<List<Travel>> getUserTravels(UserApp user) {
    return _firestoreTravelRepository.getUserTravels(user);
  }

  Future<Travel> getTravelById(String id) async {
    return await _firestoreTravelRepository.getTravelById(id);
  }
}
