import 'package:flutter/material.dart';
import 'package:transfert_colis_interurbain/Screen/Notification/NotificationList.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Demande de transfert"),
    ),
    body: NotificationList(),
    );
  }
}