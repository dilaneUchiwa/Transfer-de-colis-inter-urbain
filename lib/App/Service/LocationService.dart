import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transfert_colis_interurbain/Config/AppConfig.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';

Future<void> initializeLocationService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 10), (timer) async {
    // if (service is AndroidServiceInstance) {
    //   if (await service.isForegroundService()) {
    //     /// OPTIONAL for use custom notification
    //     /// the notification id must be equals with AndroidConfiguration when you call configure() method.
    //     flutterLocalNotificationsPlugin.show(
    //       888,
    //       'COOL SERVICE',
    //       'Awesome ${DateTime.now()}',
    //       const NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           'my_foreground',
    //           'MY FOREGROUND SERVICE',
    //           icon: 'ic_bg_service_small',
    //           ongoing: true,
    //         ),
    //       ),
    //     );

    //     // if you don't using custom notification, uncomment this
    //     service.setForegroundNotificationInfo(
    //       title: "My App Service",
    //       content: "Updated at ${DateTime.now()}",
    //     );
    //   }
    // }

    /// you can see this log in logcat
   // print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    final position = await _determinePosition();

    // Ajouter les coordonnées géographiques à une base de données Realtime Database

    var databaseReference = FirebaseFirestore.instance.collection('locations');

    databaseReference.add({
      'userId': AppConfig.UserId,
      'latitude': position.latitude,
      'longitude': position.longitude,
      "timestamp": DateTime.now()
    });

    // print(
    //     'UserId : ${AppConfig.UserId} Latitude: ${position.latitude} , Longitude : ${position.longitude}');
    // // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  });

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    checkLocationPermission();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      checkLocationPermission();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    checkLocationPermission();
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<bool> checkLocationPermission() async {
  // Vérifiez si l'application est autorisée à utiliser la géolocalisation
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Demander à l'utilisateur d'autoriser l'application à utiliser la géolocalisation
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }

  // Vérifiez si l'utilisateur a autorisé l'application à utiliser la géolocalisation en arrière-plan
  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  // Vérifiez si la géolocalisation est activée sur l'appareil
  bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationEnabled) {
    // Demander à l'utilisateur d'activer la géolocalisation
    bool locationStatus = await Geolocator.openLocationSettings();
    if (!locationStatus) {
      return false;
    }
  }

  return true;
}
