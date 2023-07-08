import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/UserManager.dart';
import 'package:transfert_colis_interurbain/Data/DataSource/Remote/FirestoreUserRepository.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';

import 'Screen/HomePage.dart';
import 'Screen/SignInPage.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);    
     
    print("UserApp auth : ${user}");

    return user == null ? SignInPage() : const HomePage();
    //return SignInPage();
  }
}
