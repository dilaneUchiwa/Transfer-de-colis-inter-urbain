
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';  
 

class AuthService{


  final _firebaseAuth = FirebaseAuth.instance;

  // creation d'une instance de personne
  CollectionReference _person = FirebaseFirestore.instance.collection("Users");
  FirebaseStorage _storage = FirebaseStorage.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> singIn(String email, String password) async{
      
    try{
      final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(result.user!=null){
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }

  Future signOut() async{
    try{
      return await _firebaseAuth.signOut();
    // ignore: empty_catches
    }catch(e){ 
    }
  }
  // signUp with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  // connexion avec le google
   Future<UserCredential>signInWithGoogleAccount() async{
    // declencher des flux d'authentification

      final googleUser = await _googleSignIn.signIn();
  
      // obtenir les détails de demande d'autorisation de la demande
      final googleAuth = await googleUser!.authentication;

      // creer un nouvel identifiant
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ); 
      // une fois connecté, l'identifiant de l'utilisateur est renvoyer
      return await _firebaseAuth.signInWithCredential(credential);
   } 

    // declaration d'une fonction qui va nous permettre d'avoir l'etat de connexion de l'utilisateur

    Stream<User?> get user => _firebaseAuth.authStateChanges();


  // fonction pour ajouter les données dans cloud_firestore



}