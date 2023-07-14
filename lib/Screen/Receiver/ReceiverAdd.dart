import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Screen/Notification/NotificationMessageItem.dart';
import 'package:transfert_colis_interurbain/Screen/Transfert/TransfertDescriptionItem.dart';

import '../../Config/Theme/Theme.dart';

class ReceiverAdd extends StatefulWidget {
  ReceiverAdd({super.key});
  bool transferFound = false;
  Transfert? transfert;
  @override
  State<ReceiverAdd> createState() => _ReceiverAddState();
}

class _ReceiverAddState extends State<ReceiverAdd> {
  final _formKey = GlobalKey<FormState>();
  int? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reception de colis'),
        ),
        body: !widget.transferFound
            ? Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.0),
                      Text(
                        'Le code utilisé lors de l\'échange de colis est . le même code doit être utilisé pour lors de la reception',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Veuillez saisir le code ci-dessous :',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Code de transfert',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir le code';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          code = int.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // if (_validationCode == widget.code) {
                                //   showNotificationSuccess(
                                //       context, 'Le code de validation est correct.');

                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => ImageCamFile(
                                //                 user: widget.user,
                                //               )));
                                // } else {
                                //   showNotificationError(
                                //       context, 'Le code de validation est incorrect.');
                                // }
                                widget.transfert = await TransfertManager()
                                    .getTransfertByCode("$code");

                                if (widget.transfert == null) {
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 40),
                                                  const Text(
                                                      "Le code de transfert"),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "$code",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Themes.textcolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  const Text(
                                                    "ne correspond à aucune transaction en cours",
                                                    textAlign: TextAlign.center,
                                                  )
                                                ],
                                              )),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'Annuler');
                                                },
                                                child: const Text('Fermer'),
                                              )
                                            ],
                                          ));
                                } else {
                                  setState(() {
                                    widget.transferFound = true;
                                  });
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
              )
            : TranferDescriptionItem(widget.transfert!, true,false));
  }
}
