import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/Traveller/TravelerAdd.dart';

import '../../App/Manager/TravelManager.dart';
import '../../Config/Theme/Theme.dart';
import '../../Domain/Model/Travel.dart';
import '../../Domain/Model/UserApp.dart';
import 'TravelItem.dart';
import 'TravelUserItem.dart';

class TravelUserHistory extends StatelessWidget {
  const TravelUserHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Mes Voyages".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Themes.textcolor,
                                fontWeight: FontWeight.bold))),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        travelAddDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text("Ajouter un voyage"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Divider(color: Theme.of(context).primaryColor),
                const SizedBox(height: 2),
              ],
            ),
          ),
          Flexible(
            flex: 12,
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: TravelManager().getUserTravels(user!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Travel> travelData = snapshot.data!;

                    if (travelData.isEmpty) {
                      return const Center(
                          child: Text(
                              "Vous n'avez jamais eu à effectuer de voyage"));
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: travelData.map((travel) {
                          return TravelUserItem(travel);
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void travelAddDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Programmer un voyage".toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              content: TravellerAdd(),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Fermer'),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text('Enregistrer'),
                )
              ],
            ));
  }
}
