//RECUPERATION DES DONNEES DANS UN INKWELL

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Packages.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Screen/Notification/NotificationMessageItem.dart';
import '../../Domain/Model/UserApp.dart';
import 'NotificationItem.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);

    return StreamBuilder(
      stream: TransfertManager().getUserTravellerTansferts(user!.userId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Transfert> data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text("Aucune notification"));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Column(
                children: data.map((transfert) {
                  return NotificationItem(transfert);
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
