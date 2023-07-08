import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Data/DataSource/Remote/FirestoreTransfertRepository.dart';
import '../../Domain/Model/Transfert.dart';
import '../../Domain/Model/UserApp.dart';
import 'NotificationMessageItem.dart';

class SeeNotification extends StatefulWidget {
  Transfert transfert;
  SeeNotification(this.transfert, {super.key});

  @override
  State<SeeNotification> createState() => _SeeNotificationState();
}

class _SeeNotificationState extends State<SeeNotification> {
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserApp?>(context);

    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
              color: widget.transfert.isRead ? Colors.white : Colors.grey.shade400,
              child: ListTileTheme(
                child: ListTile(
                    minVerticalPadding: 8,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          widget.transfert.package.userSender.userPhoto!),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    title: Text(
                        "${widget.transfert.package.userSender.userName!} ${widget.transfert.package.userSender.userSurname!}",
                        style: const TextStyle(fontSize: 18)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Demande un transfert de colis",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                            "Colis : ${widget.transfert.package.packageDescription}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    onTap: () {
                      if (!widget.transfert.isRead) {
                        FirestoreTransfertRepository()
                            .updateTransfertRead(widget.transfert);
                      }

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NotificationMessageItem(widget.transfert)));
                    }),
              )),
        ],
      ),
    );
  }
}
