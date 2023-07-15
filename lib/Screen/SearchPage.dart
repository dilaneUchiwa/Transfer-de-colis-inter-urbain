import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Data/DataSource/Remote/FirestoreUserRepository.dart';


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
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextField(

              decoration : const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Rechercher un voyage par...",
                fillColor: Colors.grey,
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border : InputBorder.none,

              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              }
          ),
        ),
      ),
      body: Text("data")   );
  }
}