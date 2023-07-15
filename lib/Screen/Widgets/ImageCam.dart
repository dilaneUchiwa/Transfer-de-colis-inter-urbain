import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/Widgets/waitingOverLay.dart';
import 'package:transfert_colis_interurbain/Utils/InternetChecker.dart';
import '../../App/Manager/UserManager.dart';
import '../../App/Service/FirebaseStorage.dart';
import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';
import '../../Domain/Model/UserApp.dart';
import 'showSnackBar.dart';

class ImageCamFile extends StatefulWidget {
  final UserApp user;

  const ImageCamFile({Key? key, required this.user}) : super(key: key);

  @override
  ImageCamFileState createState() => ImageCamFileState();
}

class ImageCamFileState extends State<ImageCamFile> {
  final ImagePicker imagePicker = ImagePicker();
  File? imageRecto;
  File? imageVerso;
  File? userPhoto;

  @override
  Widget build(BuildContext context) {
    // recuperation des données de l'utilisateur connecté
    //final _user  = Provider.of<User?>(context);
    bool _isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vérification de l\'identité'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Fournisser une image actuelle de vous même",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        pickUserPhoto(ImageSource.gallery),
                                    child:
                                        const Text('Importé depuis la galérie'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        pickUserPhoto(ImageSource.camera),
                                    child: const Text('Prendre une image'),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(),
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: userPhoto != null
                                        ? Image.file(
                                            fit: BoxFit.cover,
                                            userPhoto!,
                                            height: 150,
                                            width: 250,
                                            alignment: Alignment.center,
                                          )
                                        : Text("Aucune image Sélectionnée"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Fournisser une image du côté recto de votre CNI",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        pickImageRecto(ImageSource.gallery),
                                    child:
                                        const Text('Importé depuis la galérie'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        pickImageRecto(ImageSource.camera),
                                    child: const Text('Prendre une image'),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(),
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: imageRecto != null
                                        ? Image.file(
                                            fit: BoxFit.cover,
                                            imageRecto!,
                                            height: 150,
                                            width: 250,
                                            alignment: Alignment.center,
                                          )
                                        : Text("Aucune image Sélectionnée"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Fournisser une image du côté verso de votre CNI",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        pickImageVerso(ImageSource.gallery),
                                    child:
                                        const Text('Importé depuis la galérie'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () =>
                                        pickImageVerso(ImageSource.camera),
                                    child: const Text('From Camera'),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(),
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: imageVerso != null
                                        ? Image.file(
                                            fit: BoxFit.cover,
                                            imageVerso!,
                                            height: 150,
                                            width: 250,
                                            alignment: Alignment.center,
                                          )
                                        : Text("Aucune image Sélectionnée"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await InternetChecker.checkInternetConnection()) {
                          if (userPhoto == null ||
                              imageRecto == null ||
                              imageVerso == null) {
                            showNotificationError(context,
                                "Vous n'avez pas fournir certaines images !");
                            return;
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            widget.user.userToken =
                                await FirebaseMessaging.instance.getToken();
                            showNotification(
                                context, "Enregistrememt en cours");
                            //if (widget.user.isFullProvide()) {
                            UserManager userManager = UserManager();
                            print(" User :${widget.user.toString()}");
                            await userManager.addUser(widget.user);

                            if (await FirebaseStorageService().uploadUserFile(
                                    widget.user,
                                    userPhoto!,
                                    imageRecto!,
                                    imageVerso!) ==
                                3) {
                              setState(() {
                                _isLoading = false;
                              });
                              showNotificationSuccessWithDuration(
                                  context,
                                  "Votre demande d'enregistrement a bien été prise en compte sera validée dans un délai de 24h !",
                                  30);

                              Navigator.pushNamed(context, '/SignIn');
                            }
                          }
                          setState(() {
                            _isLoading = false;
                          });
                          //}else{

                          //}
                        } else {
                          showNotificationError(
                              context, "Pas de connexion internet !");
                        }
                      },
                      child: const Text('Soummettre mes informations'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) const WaitingOverlay(),
        ],
      ),
    );
  }

  pickImageRecto(ImageSource source) async {
    XFile? xFileImage = await imagePicker.pickImage(source: source);
    if (xFileImage != null) {
      setState(() {
        imageRecto = File(xFileImage.path);
      });
    }
  }

  pickImageVerso(ImageSource source) async {
    XFile? xFileImage = await imagePicker.pickImage(source: source);
    if (xFileImage != null) {
      setState(() {
        imageVerso = File(xFileImage.path);
      });
    }
  }

  pickUserPhoto(ImageSource source) async {
    XFile? xFileImage = await imagePicker.pickImage(source: source);
    if (xFileImage != null) {
      setState(() {
        userPhoto = File(xFileImage.path);
      });
    }
  }
}
