import 'package:flutter/material.dart';

import '../../Domain/Model/Transfert.dart';
import '../Transfert/TransfertDescriptionItem.dart';

class SenderPackageItem extends StatefulWidget {
  Transfert transfert;
  SenderPackageItem(this.transfert, {super.key});

  @override
  State<SenderPackageItem> createState() => _SenderPackageItemState();
}

class _SenderPackageItemState extends State<SenderPackageItem> {
  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> phototraveller;

    if (widget.transfert.travel.user.userPhoto == null) {
      phototraveller = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        phototraveller = NetworkImage(widget.transfert.travel.user.userPhoto!);
      } catch (e) {
        phototraveller = const ExactAssetImage("assets/profile_img.png");
      }
    }

    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
              color:
                  widget.transfert.isRead ? Colors.white : Colors.grey.shade400,
              child: ListTileTheme(
                child: Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 8,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: phototraveller,
                      ),
                      trailing: widget.transfert.isfinish
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "( terminé )",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "( en cours )",
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                      title: Text(
                          "${widget.transfert.travel.user.userName!} ${widget.transfert.travel.user.userSurname!}",
                          style: const TextStyle(fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Colis : ${widget.transfert.package.packageDescription}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            "Valeur : ${widget.transfert.package.packageValue} Fcfa",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TranferDescriptionItem(
                                      widget.transfert, false))),
                          child: const Text("Suivre le colis"),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                            title: Text(
                                                "Description du transfert")),
                                        body: TranferDescriptionItem(
                                            widget.transfert, false),
                                      ))),
                          child: const Text("Voir"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
