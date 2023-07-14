import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/Screen/Transfert/TransfertDescriptionItem.dart';

import '../../Domain/Model/Transfert.dart';

// ignore: must_be_immutable
class NotificationMessageItem extends StatefulWidget {
  Transfert transfert;
  NotificationMessageItem(this.transfert, {super.key});

  @override
  State<NotificationMessageItem> createState() =>
      _NotificationMessageItemState();
}

class _NotificationMessageItemState extends State<NotificationMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail Notification"),
      ),
      body: TranferDescriptionItem(widget.transfert,false,false),
    );
  }
}
