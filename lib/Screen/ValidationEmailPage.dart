import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import 'package:transfert_colis_interurbain/Screen/Widgets/showSnackBar.dart';

import '../App/Service/Mailer.dart';
import 'Widgets/ImageCam.dart';

class ValidationEmailPage extends StatefulWidget {
  int code;
  UserApp user;
  ValidationEmailPage(this.code, this.user, {super.key});

  @override
  State<ValidationEmailPage> createState() => _ValidationEmailPageState();
}

class _ValidationEmailPageState extends State<ValidationEmailPage> {
  final _formKey = GlobalKey<FormState>();

  int _validationCode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification de l\'email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Un code de validation a été envoyé à l\'adresse :',
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                ' ${widget.user.userEmail}  .',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Veuillez saisir le code ci-dessous :',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Code de validation',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le code de validation';
                  }
                  return null;
                },
                onSaved: (value) {
                  _validationCode = int.parse(value!);
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      int code = await MailerService.sendValidationCode(
                          widget.user.userEmail!);
                      if (code != 0) {
                        setState(() {
                          widget.code = code;
                        });
                        showNotificationSuccess(
                            context, 'Le code de validation a été renvoyé.');
                      } else {
                        showNotificationError(
                            context, "Pas de connexion internet !");
                      }
                    },
                    child: Text('Renvoyer le code'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_validationCode == widget.code) {
                          showNotificationSuccess(
                              context, 'Le code de validation est correct.');

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageCamFile(
                                        user: widget.user,
                                      )));
                        } else {
                          showNotificationError(
                              context, 'Le code de validation est incorrect.');
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
      ),
    );
  }
}
