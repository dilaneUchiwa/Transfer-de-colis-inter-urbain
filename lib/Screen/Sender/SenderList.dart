import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../App/Manager/TransfertManager.dart';
import '../../Domain/Model/Transfert.dart';
import '../../Domain/Model/UserApp.dart';
import 'SenderItem.dart';

class SenderList extends StatelessWidget {
  const SenderList({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);

    return StreamBuilder(
      stream: TransfertManager().getUserSenderTansferts(user.userId!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Transfert> transfertData = snapshot.data!;

          if (transfertData.isEmpty) {
            return const Center(
                child: Text("Aucun transfert de colis éffectué "));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Ci-dessous la liste de vos expédition de colis"),
                  Column(
                    children: transfertData.map((transfert) {
                      return SenderPackageItem(transfert);
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
    );
  }
}
