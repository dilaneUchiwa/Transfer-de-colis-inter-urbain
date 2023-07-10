import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/Screen/Receiver/ReceiverUserHistory.dart';
import 'package:transfert_colis_interurbain/Screen/Sender/SenderList.dart';
import 'package:transfert_colis_interurbain/Screen/Traveller/TravelerList.dart';
import 'package:transfert_colis_interurbain/Screen/chat/pages/pages.dart';

import '../App/Manager/UserManager.dart';
import '../Data/DataSource/Remote/FirestoreUserRepository.dart';
import 'Traveller/TravelUserHistory.dart';
import 'Widgets/BadgeNotification.dart';
import 'Widgets/SearchWidget.dart';
import 'Widgets/drawerWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> _NavigationBarItems = [];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  

  @override
  void initState() {
    super.initState();
    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "home",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));

    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.truckFast),
      label: "Travel",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));
        _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.send_time_extension_rounded),
      label: "Send",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));

    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.receipt),
      label: "Receive",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));
    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "Chat",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
            actions: const [BadgeNotification(), SizedBox(width: 20)],
            title: const SearchWidget()),
        drawer: const DrawerWidget(),
        body: PageView(
            onPageChanged: ((value) {
              setState(() {
                _currentIndex = value;
              });
            }),
            controller: _pageController,
            children: const [
              TravelList(),
              TravelUserHistory(),
              SenderList(),
              ReceiverUserHistory(),
              HomePageChat()
            ]),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: _NavigationBarItems,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (value) {
            setState(() {
              //Navigator.pop(context);
              _pageController.jumpToPage(value);
              _currentIndex = value;
            });
          },
        ));
  }
}
