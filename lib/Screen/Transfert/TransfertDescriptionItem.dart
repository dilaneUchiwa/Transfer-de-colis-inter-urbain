import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import 'package:transfert_colis_interurbain/App/Service/Mailer.dart';
import 'package:transfert_colis_interurbain/App/Service/Notification.dart';
import 'package:transfert_colis_interurbain/Config/Theme/Theme.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Packages.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Travel.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import 'package:transfert_colis_interurbain/Utils/Generator.dart';

import '../../Utils/InternetChecker.dart';
import '../User/UserProfil.dart';
import '../Widgets/showSnackBar.dart';

class TranferDescriptionItem extends StatefulWidget {
  Transfert transfert;
  bool receiverUse;
  TranferDescriptionItem(this.transfert, this.receiverUse, {super.key});

  @override
  State<TranferDescriptionItem> createState() => _TranferDescriptionItemState();
}

class _TranferDescriptionItemState extends State<TranferDescriptionItem> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);
    ImageProvider<Object> photosender;

    if (widget.transfert.package.userSender.userPhoto == null) {
      photosender = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        photosender =
            NetworkImage(widget.transfert.package.userSender.userPhoto!);
      } catch (e) {
        photosender = const ExactAssetImage("assets/profile_img.png");
      }
    }

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

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                widget.receiverUse
                    ? const Text(
                        "Verifier qu'il s'agit bien du colis que vous souhaitez recevoir",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Themes.textcolor))
                    : const Text(""),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Expéditeur",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                    minVerticalPadding: 12,
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: photosender,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.transfert.package.userSender.userName!.toUpperCase()} ${widget.transfert.package.userSender.userSurname!.toUpperCase()}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        widget.transfert.package.userSender.userSexe == "M"
                            ? const Icon(
                                Icons.male,
                                size: 32,
                                color: Colors.black,
                              )
                            : const Icon(Icons.female,
                                size: 30, color: Colors.black)
                      ],
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lieu de résidence",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(height: 5),
                        Text(
                            "${widget.transfert.package.userSender.userTelephoneNumber!}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => UserProfil(
                              user: widget.transfert.package.userSender,
                              admin: false)));
                    }),
                widget.receiverUse
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Voyageur :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ListTile(
                              minVerticalPadding: 12,
                              tileColor: Colors.white,
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: phototraveller,
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${widget.transfert.travel.user.userName!.toUpperCase()} ${widget.transfert.travel.user.userSurname!.toUpperCase()}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  widget.transfert.travel.user.userSexe == "M"
                                      ? const Icon(
                                          Icons.male,
                                          size: 32,
                                          color: Colors.black,
                                        )
                                      : const Icon(Icons.female,
                                          size: 30, color: Colors.black)
                                ],
                              ),
                              subtitle: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Lieu de résidence",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  const SizedBox(height: 5),
                                  Text(
                                      "${widget.transfert.travel.user.userTelephoneNumber!}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserProfil(
                                            user: widget.transfert.travel.user,
                                            admin: false)));
                              }),
                        ],
                      )
                    : const Text(''),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Information sur le Colis",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description :",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.transfert.package.packageDescription,
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Valeur :",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("${widget.transfert.package.packageValue}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text(
                      " FCFA",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "Image du colis : ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                        alignment: Alignment.center,
                        child: Image.network(
                          height: 140,
                          width: 140,
                          widget.transfert.package.packagePhoto,
                          fit: BoxFit.contain,
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                widget.transfert.isReject
                    ? const Text(
                        "Vous avez déjà rejecté cette demande de transfert de colis",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontStyle: FontStyle.italic),
                      )
                    : Row(),
                widget.transfert.isAccept
                    ? Column(
                        children: [
                          const Text(
                            "Vous avez déjà accepté cette demande de transfert de colis",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text("code de Transfert : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("${widget.transfert.code}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Themes.textcolor,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          widget.receiverUse
                              ? Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, "/ReceiverAdd");
                                            },
                                            child: Text("Revenir")),
                                        const SizedBox(width: 40),
                                        ElevatedButton(
                                            onPressed: () async {
                                              await TransfertManager()
                                                  .updateTransfertReceiverAdd(
                                                      widget.transfert,user.userId!);
                                                      Navigator.pop(context);
                                            },
                                            child: Text("C'est le bon colis")),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                  ],
                                )
                              : const Text("")
                        ],
                      )
                    : Row(),
                widget.transfert.isAccept || widget.transfert.isReject
                    ? Row()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: Text(
                                            "Confirmation".toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: const Center(
                                                child: Text(
                                                    "Etes vous sur de vouloir refuser de transférer ce colis"),
                                              )),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Annuler');
                                              },
                                              child: const Text('Fermer'),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                if (await InternetChecker
                                                    .checkInternetConnection()) {
                                                  await TransfertManager()
                                                      .updateTransfertReject(
                                                          widget.transfert);
                                                  setState(() {
                                                    widget.transfert.reject =
                                                        true;
                                                  });
                                                  await MailerService
                                                      .sendColisReject(
                                                          widget
                                                              .transfert
                                                              .package
                                                              .userSender
                                                              .userEmail!,
                                                          widget.transfert);
                                                  await envoyerNotification(
                                                      widget
                                                          .transfert
                                                          .package
                                                          .userSender
                                                          .userToken!,
                                                      "Easy Transfer",
                                                      "Votre demande de colis a été rejecté  !",
                                                      "");

                                                  showNotificationSuccessWithDuration(
                                                      context,
                                                      "L'expéditeur a été notifiier du reject de son colis !",
                                                      10);
                                                } else {
                                                  showNotificationError(context,
                                                      "Pas de connexion internet !");
                                                }

                                                Navigator.pop(
                                                    context, 'Annuler');
                                              },
                                              child: const Text('ok'),
                                            ),
                                          ]));
                            },
                            child: const Text("Refuser"),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              int code = Generator.generateTransferCode();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: Text(
                                            "Confirmation".toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text(
                                                      "Etes vous sur de vouloir accepter de transférer ce colis",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const Text(
                                                        "code de Transfert ",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                      "$code",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Themes.textcolor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context, 'Annuler');
                                              },
                                              child: const Text('Fermer'),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                if (await InternetChecker
                                                    .checkInternetConnection()) {
                                                  await TransfertManager()
                                                      .updateTransfertAccept(
                                                          widget.transfert);
                                                  await TransfertManager()
                                                      .updateTransfertSetCode(
                                                          widget.transfert,
                                                          code);
                                                  setState(() {
                                                    widget.transfert.accept =
                                                        true;
                                                    widget.transfert.code =
                                                        code;
                                                  });
                                                  await MailerService
                                                      .sendColisAccept(
                                                          widget
                                                              .transfert
                                                              .package
                                                              .userSender
                                                              .userEmail!,
                                                          widget.transfert);
                                                  await envoyerNotification(
                                                      widget
                                                          .transfert
                                                          .package
                                                          .userSender
                                                          .userToken!,
                                                      "Easy Transfer",
                                                      "Votre demande de colis a été accepter . Vous devez remettre le colis le ${widget.transfert.travel.travelDate} avant ${widget.transfert.travel.travelMoment} à ${widget.transfert.travel.agence}(${widget.transfert.travel.quarterDeparture}) !",
                                                      "");

                                                  showNotificationSuccessWithDuration(
                                                      context,
                                                      "L'expéditeur a été notifiier . Il vous remettra le colis le ${widget.transfert.travel.travelDate.toString().substring(0, 11)} avant ${widget.transfert.travel.travelMoment} à ${widget.transfert.travel.agence}(${widget.transfert.travel.quarterDeparture}) !",
                                                      10);
                                                } else {
                                                  showNotificationError(context,
                                                      "Pas de connexion internet !");
                                                }

                                                Navigator.pop(
                                                    context, 'Annuler');
                                              },
                                              child: const Text('Accepter'),
                                            ),
                                          ]));
                            },
                            child: const Text("Accepter"),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
