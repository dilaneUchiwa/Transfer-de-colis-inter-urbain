import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/Screen/Widgets/showSnackBar.dart';
import 'package:transfert_colis_interurbain/Screen/localisation/location.dart';

import '../../App/Manager/TransfertManager.dart';
import '../../Config/Theme/Theme.dart';
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
                        widget.transfert.isfinish?const Text(""):
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen(widget.transfert)));
                          },
                          child: const Text("Suivre le colis"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange.shade800,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                        ),
                        const SizedBox(width: 10),
                        widget.transfert.isexchange
                            ? const Text("")
                            : ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final _formKey = GlobalKey<FormState>();
                                        int code = 0;
                                        return AlertDialog(
                                          title: Text(
                                            "Confirmation de l'échange"
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          content: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 8.0),
                                                Text(
                                                  'Le code a été généré au début de la transaction . le même code doit être utilisé pour confirmer l\'échange',
                                                  style: TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(height: 20),
                                                Text(
                                                  'Veuillez saisir le code ci-dessous :',
                                                  style: TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(height: 16.0),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Code de transfert',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Veuillez saisir le code';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    code = int.parse(value!);
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                ),
                                                const SizedBox(height: 16.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          _formKey
                                                              .currentState!
                                                              .save();

                                                          Transfert?
                                                              transfert =
                                                              await TransfertManager()
                                                                  .getTransfertByCode(
                                                                      "$code");

                                                          if (transfert ==
                                                              null) {
                                                            // ignore: use_build_context_synchronously
                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                      content:
                                                                          SizedBox(
                                                                        height:
                                                                            MediaQuery.of(context).size.height * 0.20,
                                                                        child: Center(
                                                                            child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            const SizedBox(height: 40),
                                                                            const Text("Le code de transfert"),
                                                                            const SizedBox(height: 5),
                                                                            Text(
                                                                              "$code",
                                                                              style: const TextStyle(fontSize: 18, color: Themes.textcolor, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            const Text(
                                                                              "ne correspond à aucune transaction en cours",
                                                                              textAlign: TextAlign.center,
                                                                            )
                                                                          ],
                                                                        )),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        MaterialButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context, 'Annuler');
                                                                          },
                                                                          child:
                                                                              const Text('Fermer'),
                                                                        )
                                                                      ],
                                                                    ));
                                                          } else {
                                                            await TransfertManager()
                                                                .updateTransfertExchange(
                                                                    widget
                                                                        .transfert);
                                                            setState(() {
                                                              widget.transfert
                                                                      .exchange =
                                                                  true;
                                                            });
                                                            Navigator.pop(
                                                                context);

                                                            showDialog(
                                                                barrierDismissible:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                      content:
                                                                          SizedBox(
                                                                        height:
                                                                            MediaQuery.of(context).size.height * 0.10,
                                                                        child: Center(
                                                                            child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            const SizedBox(height: 40),
                                                                            const Text(
                                                                              "l'échange de colis a été enregistré",
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            const SizedBox(height: 40),
                                                                          ],
                                                                        )),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        MaterialButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context, 'Annuler');
                                                                          },
                                                                          child:
                                                                              const Text('Fermer'),
                                                                        )
                                                                      ],
                                                                    ));
                                                          }
                                                        }
                                                      },
                                                      child: Text('Valider'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: const Text("Confirmer l'échange"),
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )),
                              ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                        appBar: AppBar(
                                            title: Text(
                                                "Description du transfert")),
                                        body: TranferDescriptionItem(
                                            widget.transfert, true,true),
                                      ))),
                          child: const Text("Voir"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
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
