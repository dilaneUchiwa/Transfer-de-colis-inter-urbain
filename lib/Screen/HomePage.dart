import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Service/LocationService.dart';
import 'package:transfert_colis_interurbain/Config/AppConfig.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';
import 'package:transfert_colis_interurbain/Screen/Receiver/ReceiverUserHistory.dart';
import 'package:transfert_colis_interurbain/Screen/Sender/SenderList.dart';
import 'package:transfert_colis_interurbain/Screen/Traveller/TravelerList.dart';
import 'package:transfert_colis_interurbain/Screen/chat/pages/pages.dart';

import '../Service/notification_services.dart';
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
      label: "Accueil",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));

    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.truckFast),
      label: "Espace Voyage",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));
    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.send_time_extension_rounded),
      label: "Expédition",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));

    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.receipt),
      label: "Reception",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));
    _NavigationBarItems.add(const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: "Discussion",
      backgroundColor: Color.fromRGBO(31, 44, 52, 1),
    ));
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
  }
   NotificationServices notificationServices = NotificationServices();


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp>(context);
    AppConfig.UserId = user.userId;

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
