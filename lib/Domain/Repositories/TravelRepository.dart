import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';

import '/Domain/Model/Travel.dart';

abstract class TravelRepository {
  Future<void> addTravel(Travel travel);
  Stream<List<Travel>> getTravels();
  Stream<List<Travel>> getCommingTravels();
   Stream<List<Travel?>> getTravelsWithMotif(String motif);
   Stream<List<Travel>> getUserTravels(UserApp user);
  Future<Travel> getTravelById(String id);
  Future<void> updateTravel(Travel travel);
}
