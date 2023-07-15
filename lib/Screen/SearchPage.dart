import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';
import '../App/Manager/TravelManager.dart';
import '../Domain/Model/Travel.dart';
import 'Traveller/TravelItem.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hintText: "Rechercher un voyage par...",
                  fillColor: Colors.grey,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                }),
          ),
        ),
        body: StreamBuilder(
          stream: TravelManager().getTravelsWithMotif(name),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Travel?> travelData = snapshot.data!;

              if (travelData.isEmpty && name.isEmpty) {
                return const Center(child: Text("Aucun critère de selection"));
              }

              if (travelData.isEmpty && name.isNotEmpty) {
                return Center(
                    child: Text(
                        "Aucun voyage trouvé pour la destination \"$name\" "));
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: travelData.map((travel) {
                      if (travel != null) {
                        return TravelItem(travel);
                      } else {
                        return const Text("");
                      }
                    }).toList(),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
