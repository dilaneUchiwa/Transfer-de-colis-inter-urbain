import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_auth/firebase_auth.dart';
import '../../App/Manager/PackageManager.dart';
import '../../App/Manager/UserManager.dart';
import '../../Data/DataSource/Remote/FirestorePackageRepository.dart';
import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';
import '../../Domain/Model/Packages.dart';
import '../../Domain/Model/UserApp.dart';

class FirebaseStorageService {

  //Instance de notre espace de stockage pour nos fichiers
 final FirebaseStorage _storage = FirebaseStorage.instance;

  // fonction de téléchargement et sauvegarde d'elements

  // une fonction upload generique

  Future<String?> upload(
      String className, File? file, String? id, String cloudFileName) async {
    //l'aborescence ou sera stocker l'element dans cloud_storage
    final String projectLocation = "$className/$className---$id";
    Reference reference; //le chemin d'acess et le nom de stockage
    UploadTask uploadTask; //le tache de mise en ligne
    TaskSnapshot taskSnapshot; //les resultats de cette taches
    String? resultPath; // le chemin d'acces de stokage apres sauvegarde e ligne

    // sauvegarde des du fichier
    try {
      reference = _storage
          .ref()
          .child("$projectLocation/$cloudFileName${p.extension(file!.path)}");
      uploadTask = reference.putFile(file);
      taskSnapshot = await uploadTask;
      resultPath = await taskSnapshot.ref.getDownloadURL();
    } on FirebaseException catch (_, exc) {
      exc.toString();
      return null;
    }
    return resultPath;
  }

  Future<int> uploadUserFile(UserApp user, File photo, File photoRecto,File photoVerso) async {
    int result =
        0; //l'etat de l'ajout 1-un seul fichier à ete ajouter , 3 -3fichier ont ete ajoute , 0 -tout a echouer
    String? path;

    if (photo != null) {
      path = await upload("User", photo, user.userId, "userPhoto");
      if (path != null) {
        user.userPhoto = path;
        path = null;
        UserManager().updateUser(user);
        result++;
      }
    }
    if (photoRecto != null) {
      path = await upload("User", photoRecto, user.userId, "userPhotoIdCardRecto");
      if (path != null) {
        user.userPhotoIdCardRecto= path;
        path = null;
        UserManager().updateUser(user);
        result++;
      }
    }

     if (photoVerso != null) {
      path = await upload("User", photoVerso, user.userId, "userPhotoIdCardVerso");
      if (path != null) {
        user.userPhotoIdCardVerso= path;
        path = null;
        UserManager().updateUser(user);
        result++;
      }
    }

    return result;
  }
  Future<int> uploadUserOneFile(UserApp user, File file) async {
    int result =
        0; //l'etat de l'ajout 1-un seul fichier à ete ajouter , 2-3fichier ont ete ajoute , 0 -tout a echouer
    String? path;

    if (file != null) {
      path = await upload("User", file, user.userId, "userPhoto");
      if (path != null) {
        user.userPhoto = path;
        path = null;
        UserManager().updateUser(user);
        result++;
      }
    }
    return result;
  }
  
  Future<int> uploadPackageOneFile(Packages packages, File file) async {
    int result =
        0; //l'etat de l'ajout 1-un seul fichier à ete ajouter , 2-3fichier ont ete ajoute , 0 -tout a echouer
    String? path;

    if (file != null) {
      path = await upload("Package", file, packages.packageId, "packagePhoto");
      if (path != null) {
        packages.packagePhoto = path;
        path = null;
        PackagesManager().updatePackages(packages);
        result++;
      }
    }
    return result;
  }
}
