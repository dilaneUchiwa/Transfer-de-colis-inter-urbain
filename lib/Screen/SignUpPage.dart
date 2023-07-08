import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/ValidationEmailPage.dart';
import 'package:transfert_colis_interurbain/Utils/Generator.dart';

import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';
import '../../Domain/Model/UserApp.dart';
import '../App/Service/Mailer.dart';
import '../Utils/Format.dart';
import '../Utils/InternetChecker.dart';
import 'Widgets/ImageCam.dart';
import 'Widgets/showSnackBar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  bool sexeSelected = false;
  UserApp? user;
  String? temppassword;
  String? tempconfirmpassword;

  // for date
  String dateController = "";

  @override
  void initState() {
    user = UserApp.empty();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != user!.userDateOfBirth) {
      setState(() {
        user!.userDateOfBirth = picked;
        dateController = DateFormat("dd-MM-yyyy").format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: SafeArea(
              child: Container(
            alignment: Alignment.center,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Register",
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name', style: TextStyle(fontSize: 16)),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                            onSaved: (value) => user!.userName = value,
                            decoration: const InputDecoration(
                              hintText: 'Ex: Sagueu wakam',
                              suffixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Text('SurName', style: TextStyle(fontSize: 16)),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prenom';
                              }
                              return null;
                            },
                            onSaved: (value) => user!.userSurname = value,
                            decoration: const InputDecoration(
                              hintText: 'Ex: Valdes',
                              suffixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text('Date de naissance',
                              style: TextStyle(fontSize: 16)),
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2000),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100))
                                .then((date) {
                              setState(() {
                                user!.userDateOfBirth = date;
                              });
                            });
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    user!.userDateOfBirth == null
                                        ? Text('Sélectionner une date')
                                        : Text(user!.userDateOfBirth
                                            .toString()
                                            .split(' ')[0]),
                                    const Icon(Icons.calendar_month)
                                  ],
                                ),
                              )),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('Sexe', style: TextStyle(fontSize: 16)),
                        ),
                        Row(
                          children: [
                            Radio(
                              groupValue: user!.userSexe,
                              value: 'M',
                              onChanged: (value) {
                                setState(() {
                                  user!.userSexe = value as String;
                                  sexeSelected = true;
                                });
                              },
                            ),
                            Text('Masculin'),
                            Radio(
                              groupValue: user!.userSexe,
                              value: 'F',
                              onChanged: (value) {
                                setState(() {
                                  user!.userSexe = value as String;
                                  sexeSelected = true;
                                });
                              },
                            ),
                            Text('Féminin'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text('Phone Number', style: TextStyle(fontSize: 16)),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre numéro de telephone';
                              }
                              if (!Format.isPhoneNumberValid(value)) {
                                return 'Veuillez entrer votre numéro de telephone valide';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                user!.userTelephoneNumber = int.parse(value!),
                            decoration: const InputDecoration(
                              hintText: 'Ex: 693856214',
                              suffixIcon: Icon(Icons.phone),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number),
                        const SizedBox(height: 20),
                        Text('Adresse Mail', style: TextStyle(fontSize: 16)),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre adresse mail';
                              }
                               if (!Format.isEmailValid(value)) {
                                return 'Veuillez entrer votre adresse mail valide';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) => user!.userEmail =
                                Format.validateAndFormatEmail(value!),
                            decoration: const InputDecoration(
                              hintText: 'Ex: matchindastella@gmail.com',
                              suffixIcon: Icon(Icons.mail),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Text('Mot de passe', style: TextStyle(fontSize: 16)),
                        TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre un mot de passe';
                              }
                              if (temppassword != tempconfirmpassword) {
                                return 'Veuillez entrer un même mot de passe';
                              }
                              return null;
                            },
                            onSaved: (value) => user!.userPassword = value,
                            onChanged: (value) => temppassword = value,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Text('Confirmation de Mot de passe',
                            style: TextStyle(fontSize: 16)),
                        TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer votre un mot de passe';
                              }
                              if (temppassword != tempconfirmpassword) {
                                return 'Veuillez entrer un même mot de passe';
                              }
                              return null;
                            },
                            onSaved: (value) => user!.userPassword = value,
                            onChanged: (value) => tempconfirmpassword = value,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            )),
                        const SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate() &&
                                  sexeSelected) {
                                _formkey.currentState!.save();

                                if (await InternetChecker
                                    .checkInternetConnection()) {
                                  if (await FirestoreUserRepository()
                                      .checkEmailAvailability(
                                          user!.userEmail!)) {
                                    int code = await MailerService.sendValidationCode(
                                        user!.userEmail!);
                                    // ignore: use_build_context_synchronously
                                    if (code != 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ValidationEmailPage(
                                                      code, user!)));
                                    } else {
                                      showNotificationError(context,
                                          "Pas de connexion internet !");
                                    }
                                  } else {
                                    //_formkey.currentState!
                                    showNotificationError(context,
                                        "Cette adresse mail a déjà été utilisée !");
                                  }
                                } else {
                                  showNotificationError(
                                      context, "Pas de connexion internet !");
                                }
                              } else {
                                showNotificationError(context,
                                    "Veuillez correctement remplir tout les champs !");
                              }
                            },
                            child: const Text('Next'),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
