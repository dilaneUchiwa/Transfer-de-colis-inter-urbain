import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/User/UserProfil.dart';

import '../../App/Service/Authentification.dart';
import '../../Domain/Model/UserApp.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool frState = true;
  bool lightThemeState = true;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> photo;
    final user = Provider.of<UserApp?>(context);

    if (user!.userPhoto == null) {
      photo = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        photo =  NetworkImage(user.userPhoto!);
      } catch (e) {
        photo = const ExactAssetImage("assets/profile_img.png");
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // entete du drawer
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              //width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(bottom: 10),
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: photo, fit: BoxFit.contain),
                        )),
                    Row(children: [
                      Text("${user.userName!} ${user.userSurname!}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                    ]),
                    Row(children: [
                      Text(user.userEmail!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12))
                    ])
                  ]),
            ),

            // Corps du drawer
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserProfil(user: user, admin: false)));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.person,
                          size: 15,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),
            user.isAdmin!
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/AdministrateurPanel");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.admin_panel_settings,
                                size: 15,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          Text(
                            "Administrateur",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          )
                        ],
                      ),
                    ),
                  )
                : const Text(""),

            InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.settings,
                          size: 15,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Paramètre",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const AboutDevelopperPage()));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.info,
                          size: 15,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "A propos",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            ),

            InkWell(
              onTap: () => AuthentificationService().signOut(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 50,
                        child: Icon(
                          Icons.logout,
                          size: 15,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    Text(
                      "Se déconnecter",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
