import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/App/Manager/TravelManager.dart';
import 'package:transfert_colis_interurbain/Screen/Traveller/TravelItem.dart';
import '../../Data/DataSource/Remote/FirestoreTravelRepository.dart';
import '../../Domain/Model/Travel.dart';

class TravelList extends StatelessWidget {
  const TravelList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TravelManager().getCommingTravels(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Travel> travelData = snapshot.data!;

          if (travelData.isEmpty) {
            return const Center(child: Text("Aucun voyage n'a été programmé"));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: travelData.map((travel) {
                  return TravelItem(travel);
                }).toList(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
