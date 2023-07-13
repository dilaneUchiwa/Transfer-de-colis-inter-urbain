import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/Traveller/TravellerTransferHistoryItem.dart';

import '../../App/Manager/TransfertManager.dart';
import '../../Domain/Model/Transfert.dart';
import '../../Domain/Model/Travel.dart';
import '../../Domain/Model/UserApp.dart';


class TravellerTransferHistoryList extends StatelessWidget {
  Travel travel;
  TravellerTransferHistoryList(this.travel,{super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Colis transporté"),),
      body: StreamBuilder(
        stream: TransfertManager().getByTravelTansferts(travel.travelId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Transfert> transfertData = snapshot.data!;
    
            if (transfertData.isEmpty) {
              return const Center(
                  child: Text("Aucun colis transféré durant ce voyage"));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Ci-dessous la liste des colis transférés"),
                    Column(
                      children: transfertData.map((transfert) {
                        return TravellerTransferHistoryItem(transfert);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
