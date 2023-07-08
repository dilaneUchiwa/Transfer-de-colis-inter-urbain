import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transfert_colis_interurbain/App/Manager/UserManager.dart';
import 'package:transfert_colis_interurbain/Data/DataSource/Remote/FirestoreUserRepository.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import 'package:transfert_colis_interurbain/Screen/User/UserProfil.dart';

class ItemValidUser extends StatelessWidget {
  UserApp user;
  ItemValidUser(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> photo;

    if (user.userPhoto == null) {
      photo = const ExactAssetImage("assets/profile_img.png");
    } else {
      try {
        photo = NetworkImage(user.userPhoto!);
      } catch (e) {
        photo = const ExactAssetImage("assets/profile_img.png");
      }
    }
    return Card(
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              ListTile(
                  minVerticalPadding: 12,
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: photo,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${user.userName!.toUpperCase()} ${user.userSurname!.toUpperCase()}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      user.userSexe=="M"?const Icon(Icons.male,size: 30,color: Colors.black,):const Icon(Icons.female,size: 30,color: Colors.black)
                    ],
                  ),
                  subtitle: Text(user.userEmail!,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         ProjectPage(projet, false)));
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  
                  ElevatedButton(
                    onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> UserProfil(user: user, admin : true))) ,
                    child: const Text("Voir"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
