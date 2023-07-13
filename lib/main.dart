import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/Notification/NotificationPage.dart';
import 'package:transfert_colis_interurbain/Screen/Receiver/ReceiverAdd.dart';
import 'package:transfert_colis_interurbain/Screen/Traveller/TravelerAdd.dart';
import 'package:transfert_colis_interurbain/Screen/User/Administrateur.dart';
import 'App/Service/Authentification.dart';
import 'App/Service/LocationService.dart';
import 'Config/Theme/Theme.dart';
import 'Wrapper.dart';
import 'Screen/HomePage.dart';
import 'Screen/SignInPage.dart';
import 'Screen/SignUpPage.dart';
import 'Screen/WelcomePage.dart';

Future<void> main() async {
  bool isFullAutorisation = false;

  // on s'assure que tous les widgets sont initialisé
  WidgetsFlutterBinding.ensureInitialized();
  // attende de l'initialisation du service firevalse
  await Firebase.initializeApp();

  isFullAutorisation = await checkLocationPermission();
  while (!isFullAutorisation) {
    isFullAutorisation = await checkLocationPermission();
  }
  await initializeLocationService();


  runApp(MultiProvider(
    providers: [
      StreamProvider.value(
          initialData: null, value: AuthentificationService().user)
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String? userToken;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black12,
      title: 'Easy Transfer',
      theme: Themes.principal,
      home: const Wrapper(),
      //initialRoute: "/",
      routes: {
        "/Welcome": (context) => WelcomePage(),
        "/SignIn": (context) => SignInPage(),
        "/Home": (context) => HomePage(),
        "/SignUp": (context) => SignUpPage(),
        "/Wrapper": (context) => Wrapper(),
        "/AdministrateurPanel": (context) => AdministrateurPanel(),
        "/TravellerAdd": (context) => TravellerAdd(),
        "/ReceiverAdd": (context) => ReceiverAdd(),
        "/NotificationPage": (context) => NotificationPage(),
      },
    );
  }
}
