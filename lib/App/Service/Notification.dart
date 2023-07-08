import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<bool> envoyerNotification(String deviceToken,String titre,String message,String road) async {
  const String serverKey = 'AAAA6VHdAL8:APA91bHEFlDNSjOKzXSKMdGaX6D2rVv33Wxd_hKSwZYGMZ0q1E9-LK8lBBCp2gCvcWd3vaoGMsxPNsAvMWRxhmD_CD7N3t8Z6JuQvdnEEOipxpTWAwnsC6_3m0oq_Lck1UYi5snidabJ';
  const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  Map<String, dynamic> notification = {
    'title': titre, // Vous pouvez personnaliser le titre
    'body': message,
     "sound": "jetsons_doorbell.mp3"
  };

  Map<String, dynamic> data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'message': message,
    'road':road
  };

  Map<String, dynamic> payload = {
    'notification': notification,
    'data': data,
    'priority': 'high',
    'to': deviceToken,
  };

  try {
    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      print('Notification envoyée avec succès: ${response.body}');
      return true;
    } else {
      print('Échec de l\'envoi de la notification: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Erreur lors de l\'envoi de la notification: $e');
    return false;
  }
}