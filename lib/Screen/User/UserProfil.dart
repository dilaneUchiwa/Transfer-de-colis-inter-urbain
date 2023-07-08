import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/App/Manager/UserManager.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import 'package:transfert_colis_interurbain/Utils/Converter.dart';

class UserProfil extends StatefulWidget {
  UserApp user;
  bool admin;
  UserProfil({super.key, required this.user, required this.admin});

  @override
  State<UserProfil> createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> photo;

    if (widget.user.userPhoto == null) {
      photo = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        photo = NetworkImage(widget.user.userPhoto!);
      } catch (e) {
        photo = const ExactAssetImage("assets/profile_img.png");
      }
    }
    return Scaffold(
        appBar: AppBar(title: const Text("User Profile")),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.bottomLeft,
                          //margin: const EdgeInsets.only(bottom: 10),
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: photo, fit: BoxFit.contain),
                          )),
                      const Divider()
                    ]),
              ),
              Flexible(
                  flex: 5,
                  child: SingleChildScrollView(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    title: Text('Name',
                                        style: TextStyle(fontSize: 16)),
                                    subtitle: Text(widget.user.userName!),
                                    trailing: Icon(Icons.person),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    title: Text('SurName',
                                        style: TextStyle(fontSize: 16)),
                                    subtitle: Text(widget.user.userSurname!),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    title: Text('Date de naissance',
                                        style: TextStyle(fontSize: 16)),
                                    subtitle: Text(
                                        MyConverter.convertDateTimeToString(
                                            widget.user.userDateOfBirth!)),
                                    trailing: Icon(Icons.calendar_month),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    title: Text('Sexe',
                                        style: TextStyle(fontSize: 16)),
                                    subtitle: Text(
                                      widget.user.userSexe == 'M'
                                          ? "Masculin"
                                          : "Féminin",
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    title: Text('Phone Number',
                                        style: TextStyle(fontSize: 16)),
                                    subtitle: Text(
                                      widget.user.userTelephoneNumber
                                          .toString(),
                                    ),
                                    trailing: Icon(Icons.phone),
                                  ),
                                  ListTile(
                                    onTap: () {},
                                    title: Text('Adresse Mail',
                                        style: TextStyle(fontSize: 16)),
                                    subtitle: Text(
                                      widget.user.userEmail!,
                                    ),
                                    trailing: Icon(Icons.email),
                                  ),
                                  ListTile(
                                    title: Text("ID Card Recto"),
                                    subtitle: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: widget.user.userPhotoIdCardRecto !=
                                              null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  fit: BoxFit.cover,
                                                  widget.user
                                                      .userPhotoIdCardRecto!,
                                                  height: 150,
                                                  width: 250,
                                                  alignment: Alignment.center,
                                                ),
                                              ],
                                            )
                                          : Text("Image not found "),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text("ID Card Verso"),
                                    subtitle: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child: widget.user.userPhotoIdCardVerso !=
                                              null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  fit: BoxFit.cover,
                                                  widget.user
                                                      .userPhotoIdCardVerso!,
                                                  height: 150,
                                                  width: 250,
                                                  alignment: Alignment.center,
                                                ),
                                              ],
                                            )
                                          : Text("Image not found "),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  widget.admin
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: const Text("Rejeter"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                    vertical: 8,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  )),
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              onPressed: () {
                                                UserManager()
                                                    .validateUser(widget.user);
                                              },
                                              child: const Text("Valider"),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .primaryColor,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                    vertical: 5,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  )),
                                            ),
                                            const SizedBox(width: 20),
                                          ],
                                        )
                                      : Row(),
                                  const SizedBox(height: 30)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ))
            ],
          ),
        ));
  }
}
