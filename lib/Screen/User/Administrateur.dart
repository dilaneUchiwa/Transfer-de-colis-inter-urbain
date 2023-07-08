import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transfert_colis_interurbain/Screen/User/UserValidItem.dart';

import '../../App/Manager/UserManager.dart';
import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';
import '../../Domain/Model/UserApp.dart';

class AdministrateurPanel extends StatelessWidget {
  const AdministrateurPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Espace Administrateur"),),
      body: StreamBuilder(
        stream: UserManager().getUnalidatUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserApp> UserAppData = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: UserAppData.map((UserApp) {
                    return ItemValidUser(UserApp);
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
      ),
    );
  }
}
