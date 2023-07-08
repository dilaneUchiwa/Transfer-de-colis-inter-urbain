import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:transfert_colis_interurbain/Config/Theme/Theme.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Utils/Converter.dart';

class ReceiverUserItem extends StatelessWidget {
  Transfert transfert;
  ReceiverUserItem(this.transfert, {super.key});

  @override
  Widget build(BuildContext context) {
    //ImageProvider<Object> photo;

    // if (transfert.user.userPhoto == null) {
    //   photo = const ExactAssetImage("assets/profile_img.png");
    // } else {
    //   try {
    //     photo = NetworkImage(transfert.user.userPhoto!);
    //   } catch (e) {
    //     photo = const ExactAssetImage("assets/profile_img.png");
    //   }
    //}

    return Card(
        elevation: 6,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(transfert.package.packageDescription,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Icon(Icons.watch_later_outlined),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        transfert.travel.travelDeparture,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Themes.textcolor),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "=>",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Themes.textcolor),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        transfert.travel.travelDestination,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Themes.textcolor),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: const [
                    SizedBox(width: 10),
                    Text("Envoyé le : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey)),
                  ]),
                  Row(
                    children: [
                      Text(MyConverter.convertDateTimeToHumanString(
                          transfert.createdAT)),
                      const SizedBox(width: 5)
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      SizedBox(width: 10),
                      Text("recu le : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black))
                    ],
                  ),
                  Row(
                    children: [
                      Text(MyConverter.convertDateTimeToHumanString(
                          transfert.createdAT)),
                      const SizedBox(width: 5)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
