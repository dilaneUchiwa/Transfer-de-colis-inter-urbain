import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:transfert_colis_interurbain/Config/AppConfig.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import 'package:transfert_colis_interurbain/Utils/Crypto.dart';

import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';
import '../Manager/UserManager.dart';

class AuthentificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserApp? userApp;

  //Connexion avec google
  Future<UserCredential> signInWithGoogle() async {
    // Declenchement du flux d;authentification
    final googleUser = await _googleSignIn.signIn();

    //obtenir les details de la demande d'authentification

    final googleAuth = await googleUser!.authentication;

    // creer un nouvel identificatiom

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // une fois connecté , on renvoi l'identifiant de l'utilisateur connecté

    final usercredential = await _auth.signInWithCredential(credential);

    return usercredential;
  }

  //retourne l'état de l'utiisateur en temps réel

  Stream<UserApp?> get user {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        // L'utilisateur n'est pas connecté
        return null;
      } else {
        // L'utilisateur est connecté, on récupère les informations de l'utilisateur avec getUserByEmail()
        final user = await UserManager().getUserByEmail(firebaseUser.email!);

        if (user == null) {
          return null;
        }
        if (user.isValid!) {
          String? token = await FirebaseMessaging.instance.getToken();
          user.userToken != token ? user.userToken = token : null;
          await UserManager().updateUser(user);
          return user;
        } else {
          return null;
        }
      }
    });
  }

  // deconnexion du compte
  Future<void> signOutWithGoogle() async {
    _googleSignIn.signOut();
    return signOut();
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await UserManager().getUserByEmail(email);

      if (!checkPassword(password, user!.userPassword)) {
        return false;
      }
      password = user.userPassword!;

      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null && result == null) {
        AuthentificationService()
            .signUpWithEmailAndPassword(user.userEmail!, user.userPassword!);
        result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      if (result.user != null) {
        final userApp = await UserManager().getUserByEmail(result.user!.email!);

        if (userApp!.isValid!) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // signUp with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
}
