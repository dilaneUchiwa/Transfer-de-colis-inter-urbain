import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfert_colis_interurbain/Config/Theme/Theme.dart';
import '../App/Service/Authentification.dart';
import '../Utils/Format.dart';
import 'Widgets/showSnackBar.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Declaration d'une variable pour le processus de connexion
  bool inLoginProcessFacebook = false;
  bool inLoginProcessGoogle = false;
  bool inLoginProcess = false;

  String email = "";
  String password = "";
  String authResult = "";

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
             Text("Page Connexion",textAlign: TextAlign.center),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Stack(
            children: [
              SafeArea(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Bienvenue sur Easy Transfer",textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              setState(() {
                                email = Format.validateAndFormatEmail(value!);
                              });
                            },
                            validator: (value) => value == null || value.isEmpty
                                ? 'Email invalide'
                                : null,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              // hintText: "Enter Email",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                // borderSide: BorderSide(width:50),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                            obscureText: true,
                            onSaved: (value) {
                              setState(() {
                                password = value!;
                              });
                            },
                            validator: (value) => value == null || value.isEmpty
                                ? value!.length < 6
                                    ? "Mot de pass trop court"
                                    : 'mot de passe Incorrect'
                                : null,
                            decoration: const InputDecoration(
                              labelText: "Mot de passe",
                              //hintText: "Enter password",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          authResult,
                          style: Styles.styleAuthFailed,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Expanded(child: Column()),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Mot de passe oublié ?"))
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),

                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: inLoginProcess
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      _formkey.currentState!.save();
                                      setState(() {
                                        inLoginProcess = true;
                                        inLoginProcessFacebook = false;
                                        inLoginProcessGoogle = false;
                                      });
                                      if (!(await AuthentificationService()
                                          .signInWithEmailAndPassword(
                                              email, password))) {
                                        showNotificationSuccessWithDuration(
                                            context,
                                            "Veuillez patienter , Votre inscription est en cours de validation !  ",
                                            10);

                                        setState(() {
                                          inLoginProcess = false;
                                          authResult =
                                              "Echec d'authentification";
                                        });
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.mail),
                                          ],
                                        ),
                                      ),
                                      const Center(
                                          child: Text(
                                              ' Connexion avec email et mot de passe',
                                              textAlign: TextAlign.right)),
                                    ],
                                  ),
                                ),
                        ),

                        const SizedBox(height: 10),

                        //facebook buttpn account

                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: inLoginProcessFacebook
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      inLoginProcessFacebook = true;
                                      inLoginProcess = false;
                                      inLoginProcessGoogle = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.facebook),
                                          ],
                                        ),
                                      ),
                                      const Center( 
                                          child: Text(' Connexion avec FaceBook',
                                              textAlign: TextAlign.right)),
                                    ],
                                  ),
                                ),
                        ),

                        const SizedBox(height: 10),

                        // SignIn Button with google Account
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: inLoginProcessGoogle
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      inLoginProcess = false;
                                      inLoginProcessFacebook = false;
                                      inLoginProcessGoogle = true;
                                    });
                                    if ((await AuthentificationService()
                                                .signInWithGoogle())
                                            .user ==
                                        null) {
                                      showNotificationSuccessWithDuration(
                                          context,
                                          "Veuillez patienter , Votre inscription est en cours de validation !  ",
                                          30);

                                      setState(() {
                                        inLoginProcessGoogle = false;
                                        authResult = "Echec d'authentification";
                                      });
                                    } else {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed("/Wrapper");
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      FaIcon(
                                        FontAwesomeIcons.google,
                                        size: 18,
                                      ),
                                      Center(
                                          child: Text(' Connexion avec Google',
                                              textAlign: TextAlign.right)),
                                    ],
                                  ),
                                ),
                        ),

                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Text("Pas de compte ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/SignUp");
                                  },
                                  child: const Text("Créez en un "))
                            ],
                          ),
                        ),
                      ]),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
