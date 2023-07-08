import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import '../../Config/Theme/Theme.dart';
import '../../Domain/Model/Transfert.dart';
import '../../Domain/Model/UserApp.dart';
import 'ReceiverUserItem.dart';


class ReceiverUserHistory extends StatelessWidget {
  const ReceiverUserHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text("Colis recus".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Themes.textcolor,
                                fontWeight: FontWeight.bold))),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/ReceiverAdd");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text("Recevoir un colis"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Divider(color: Theme.of(context).primaryColor),
                const SizedBox(height: 2),
              ],
            ),
          ),
          Flexible(
            flex: 12,
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: TransfertManager().getUserReceiverTansferts(user!.userId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Transfert> transfertData = snapshot.data!;
                    return SingleChildScrollView(
                      child: Column(
                        children: transfertData.map((transfert) {
                          return ReceiverUserItem(transfert);
                        }).toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
