import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService{
  // declaration et initialisation

  CollectionReference _person = FirebaseFirestore.instance.collection("Users");
  FirebaseStorage _storage = FirebaseStorage.instance;

  // pour uploader l'image vers le cloud
  Future<String> uploadFile(file) async{
    Reference reference = _storage.ref().child("users/${DateTime.now()}.png");
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  //ajout de l'utilisateur


}