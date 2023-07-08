import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
            backgroundColor: MaterialStateProperty.all(Colors.white60),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)))),
        child: Container(
          height: 35,
          width: double.infinity,
          child: Row(
            children: const [
              SizedBox(
                  width: 50,
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
              Text(
                "Rechercher ... ",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/search');
        });
  }
}
