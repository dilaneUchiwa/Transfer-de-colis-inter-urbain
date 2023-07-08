import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:transfert_colis_interurbain/Config/Theme/Theme.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Travel.dart';
import 'package:transfert_colis_interurbain/Utils/Converter.dart';

class TravelUserItem extends StatelessWidget {
  Travel travel;
  TravelUserItem(this.travel, {super.key});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> photo;

    if (travel.user.userPhoto == null) {
      photo = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        photo = NetworkImage(travel.user.userPhoto!);
      } catch (e) {
        photo = const ExactAssetImage("assets/profile_img.png");
      }
    }

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
                    children: const [
                      SizedBox(width: 10),
                      Text("Horaire ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      Icon(Icons.watch_later_outlined),
                      Text(" : "),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${MyConverter.convertDateTimeToHumanString(travel.travelDate)} à ${travel.travelMoment}",
                        style: const TextStyle(fontStyle: FontStyle.italic,color:Themes.textcolor),
                      ),
                      const SizedBox(width: 5)
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
                    Text("Départ ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey)),
                    Icon(Icons.airplanemode_active_outlined),
                    Text(" : "),
                  ]),
                  Row(
                    children: [
                      Text("${travel.travelDeparture} (${travel.quarterDeparture})"),
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
                      Text("Arrivée ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black)),
                      Icon(Icons.airport_shuttle_sharp),
                      Text(" : "),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "${travel.travelDestination} (${travel.quarterDestination})"),
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
