import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Packages.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Travel.dart';

// ignore: must_be_immutable
class NotificationMessageItem extends StatelessWidget {
  Transfert transfert;
  NotificationMessageItem(this.transfert, {super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Détail Notification"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2)
                  ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(transfert.package.userSender.userName!),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Package Name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(transfert.package.packageDescription),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Package Value",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${transfert.package.packageValue}"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Photo",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                    Container(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      alignment: Alignment.center,
                      child :  Image.network(
                        height: 160,
                        width : 160,
                        transfert.package.packagePhoto,
                        fit: BoxFit.contain,
                      )
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Reject"),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Accept"),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
