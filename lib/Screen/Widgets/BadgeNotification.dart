import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';

class BadgeNotification extends StatefulWidget {
  const BadgeNotification({Key? key}) : super(key: key);

  @override
  State<BadgeNotification> createState() => _BadgeNotificationState();
}

class _BadgeNotificationState extends State<BadgeNotification> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);

    return StreamBuilder(
        stream: TransfertManager().getTravellerUnReadTransferCount(user.userId!),
        builder: (context, snapshot) {
          int nbre;
          snapshot.data==null ? nbre=0 : nbre = snapshot.data!;
          return badges.Badge(
              position: BadgePosition.topEnd(top: 0, end: 0),
              badgeContent: Text(
                "$nbre",
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, "/AcceptRejectPackage");
                },
              ));
        });
  }
}
