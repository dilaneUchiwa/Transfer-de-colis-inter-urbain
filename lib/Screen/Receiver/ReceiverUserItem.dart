import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import 'package:transfert_colis_interurbain/Config/Theme/Theme.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Utils/Converter.dart';

import '../../Utils/InternetChecker.dart';
import '../Transfert/TransfertDescriptionItem.dart';
import '../Widgets/showSnackBar.dart';
import '../localisation/location.dart';

class ReceiverUserItem extends StatefulWidget {
  Transfert transfert;
  ReceiverUserItem(this.transfert, {super.key});

  @override
  State<ReceiverUserItem> createState() => _ReceiverUserItemState();
}

class _ReceiverUserItemState extends State<ReceiverUserItem> {
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
              widget.transfert.isfinish
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "( terminé )",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "( en cours )",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(widget.transfert.package.packageDescription,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.transfert.travel.travelDeparture,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Themes.textcolor),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        " => ",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Themes.textcolor),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.transfert.travel.travelDestination,
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
                          widget.transfert.createdAT)),
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
                          widget.transfert.createdAT)),
                      const SizedBox(width: 5)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.transfert.isfinish
                      ? const Text("")
                      : ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MapScreen(widget.transfert))),
                          child: const Text("Suivre le colis"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange.shade800,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ),
                  const SizedBox(width: 20),
                  widget.transfert.isfinish?const Text(""):
                  ElevatedButton(
                    onPressed: () async => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                    "Confirmation".toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.18,
                                      child: const Center(
                                        child: Text(
                                          "Etes vous sur de vouloir confirmer avoir recu ce colis",
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  actions: <Widget>[
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'Annuler');
                                      },
                                      child: const Text('Fermer'),
                                    ),
                                    MaterialButton(
                                      onPressed: () async {
                                        if (await InternetChecker
                                            .checkInternetConnection()) {
                                          await TransfertManager()
                                              .updateTransfertFinish(
                                                  widget.transfert);
                                          setState(() {
                                            widget.transfert.finish = true;
                                          });
                                          //Navigator.pop(context);
                                          showNotificationSuccess(context,
                                              "Le colis a été marqué comme recu");
                                          // showDialog(
                                          //     barrierDismissible: false,
                                          //     context: context,
                                          //     builder: (BuildContext context) =>
                                          //         AlertDialog(
                                          //           title: Text(
                                          //             "RESULTAT".toUpperCase(),
                                          //             style: TextStyle(
                                          //                 fontSize: 16,
                                          //                 fontWeight:
                                          //                     FontWeight.bold,
                                          //                 color: Theme.of(
                                          //                         context)
                                          //                     .primaryColor),
                                          //           ),
                                          //           content: SizedBox(
                                          //             height:
                                          //                 MediaQuery.of(context)
                                          //                         .size
                                          //                         .height *
                                          //                     0.20,
                                          //             child: Center(
                                          //                 child: Column(
                                          //               mainAxisAlignment:
                                          //                   MainAxisAlignment
                                          //                       .center,
                                          //               crossAxisAlignment:
                                          //                   CrossAxisAlignment
                                          //                       .center,
                                          //               children: [
                                          //                 const SizedBox(
                                          //                     height: 40),
                                          //                 const Text(
                                          //                     "code de transfert"),
                                          //                 const SizedBox(
                                          //                     height: 5),
                                          //                 Text(
                                          //                   "${widget.transfert.code}",
                                          //                   style: const TextStyle(
                                          //                       fontSize: 18,
                                          //                       color: Themes
                                          //                           .textcolor,
                                          //                       fontWeight:
                                          //                           FontWeight
                                          //                               .bold),
                                          //                 ),
                                          //                 const SizedBox(
                                          //                     height: 5),
                                          //                 const Text(
                                          //                   "Le colis a été marqué comme recu",
                                          //                   textAlign: TextAlign
                                          //                       .center,
                                          //                 )
                                          //               ],
                                          //             )),
                                          //           ),
                                          //           actions: <Widget>[
                                          //             MaterialButton(
                                          //               onPressed: () {
                                          //                 Navigator.pop(context,
                                          //                     'Annuler');
                                          //               },
                                          //               child: const Text(
                                          //                   'Fermer'),
                                          //             )
                                          //           ],
                                          //         ));
                                        } else {
                                          showNotificationError(context,
                                              "Pas de connexion internet !");
                                        }

                                        Navigator.pop(context, 'Annuler');
                                      },
                                      child: const Text('ok'),
                                    ),
                                  ]))
                    },
                    child: const Text("Recevoir"),
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
                                      title: Text("Description du transfert")),
                                  body: TranferDescriptionItem(
                                      widget.transfert, false, false),
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
        ));
  }
}
