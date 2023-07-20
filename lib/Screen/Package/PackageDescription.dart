import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/TransfertManager.dart';
import 'package:transfert_colis_interurbain/App/Service/Notification.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Packages.dart';
import 'package:transfert_colis_interurbain/Domain/Model/Transfert.dart';
import 'package:transfert_colis_interurbain/Screen/Package/PackageElementItem.dart';
import 'package:transfert_colis_interurbain/Screen/Notification/NotificationServices.dart';
import '../../App/Manager/ContactManager.dart';
import '../../App/Manager/PackageManager.dart';
import '../../App/Service/FirebaseStorage.dart';
import '../../Domain/Model/Contact.dart';
import '../../Domain/Model/PackageItem.dart';
import '../../Domain/Model/Travel.dart';
import '../../Domain/Model/UserApp.dart';
import '../../Utils/InternetChecker.dart';
import '../Widgets/LoadingView.dart';
import '../Widgets/showSnackBar.dart';
import 'package:http/http.dart' as http;

class PackageDescription extends StatefulWidget {
  Travel travel;

  PackageDescription({Key? key, required this.travel}) : super(key: key);

  @override
  State<PackageDescription> createState() => _PackageDescriptionState();
}

class _PackageDescriptionState extends State<PackageDescription> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
  }

  NotificationServices notificationServices = NotificationServices();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Packages package = Packages.empty();
  bool isLoading = false;
  int index = 0;
  File? imageColis;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserApp?>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Package Description "),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Stack(
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Descrivez tous les éléments du colis que vous souhaitez transférer un à un ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 20),
                            Container(
                                //height: 1
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                    onSaved: (value) {
                                      package.packageDescription = value!;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer la description du colis';
                                      }
                                      return null;
                                    },
                                    minLines: 1,
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                      hintText:
                                          "Ex: My package is made up of \n two documents and one T-Shirt...",
                                      labelText: "Package Description",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      border: OutlineInputBorder(
                                        // borderSide: BorderSide(width:50),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                    ))),
                            const SizedBox(height: 10),
                            Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer la valeur du colis';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        package.packageValue =
                                            int.tryParse(value!)!;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: "Exple : 50.0000 Fcfa",
                                      // hintText: "Enter Email",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      border: OutlineInputBorder(
                                        // borderSide: BorderSide(width:50),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                    ))),
                            const SizedBox(height: 20),
                            Row(
                              children: const [
                                Text(
                                  "Selectionner une image du colis ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 20, 20, 20),
                                          child: imageColis != null
                                              ? Image.file(
                                                  fit: BoxFit.cover,
                                                  imageColis as File,
                                                  height: 150,
                                                  width: 250,
                                                  alignment: Alignment.center,
                                                )
                                              : const Text(
                                                  "Aucune image selectionnée"),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor,
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () =>
                                              pickColis(ImageSource.gallery),
                                          child: const Text(
                                              'Importé depuis la Galérie'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor,
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () =>
                                              pickColis(ImageSource.camera),
                                          child:
                                              const Text('Prendre une image'),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          "Attention en ce qui concerne la véracité des informations fournies !!!",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Text(
                                                "Confirmation".toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              content: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.18,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 40),
                                                        Text(
                                                          "Montant total : ",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 30),
                                                        Text(
                                                          "Frais Transaction : ",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 40),
                                                        Text(
                                                          "${package.packageValue}",
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        ),
                                                        const SizedBox(
                                                            height: 30),
                                                        Text(
                                                          "",
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Column(
                                                      children: [
                                                        SizedBox(height: 40),
                                                        Text(
                                                          "Fcfa ",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 30),
                                                        Text(
                                                          "Fcfa ",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  onPressed: () {
                                                    index = 0;
                                                    Navigator.pop(
                                                        context, 'Annuler');
                                                  },
                                                  child: const Text('Fermer'),
                                                ),
                                                MaterialButton(
                                                  onPressed: () async {
                                                    package.travelId =
                                                        widget.travel.travelId;
                                                    package.userSender = user!;
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    if (await InternetChecker
                                                        .checkInternetConnection()) {
                                                      await PackagesManager()
                                                          .addPackages(package);

                                                      if (await FirebaseStorageService()
                                                              .uploadPackageOneFile(
                                                                  package,
                                                                  imageColis!) ==
                                                          1) {
                                                        // send notification from one device to another

                                                        var transfer = Transfert
                                                            .withoutIdAndDateTime(
                                                                widget.travel,
                                                                null,
                                                                package,
                                                                null);
                                                        await TransfertManager()
                                                            .addTransfert(
                                                                transfer);

                                                        await ContactManager().addContact(Contact.withoutId(widget.travel.user, package.userSender, []));

                                                        await envoyerNotification(
                                                            widget.travel.user
                                                                .userToken!,
                                                            "Easy Transfer",
                                                            "Vous avez reçu une demande de transfert de colis de la part de ${user.userName}\nColis : ${package.packageDescription} \nVeuillez consulter votre l'application pour plus de détail.",
                                                            "");
                                                        setState(() {
                                                          isLoading = false;
                                                        });

                                                        // ignore: use_build_context_synchronously
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  content:
                                                                      SizedBox(
                                                                          height: MediaQuery.of(context).size.height *
                                                                              0.18,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "Une notification a été envoyé à ${widget.travel.user.userName} pour besoin de transfert de votre colis . Il vous repondra dans un delai de 30 min  !",
                                                                            ),
                                                                          )),
                                                                  actions: <
                                                                      Widget>[
                                                                    MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '/Home');
                                                                      },
                                                                      child: const Text(
                                                                          'Ok'),
                                                                    ),
                                                                  ],
                                                                ));
                                                      } else {
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        showNotificationError(
                                                            context,
                                                            "Pas de connexion internet !");
                                                      }
                                                    } else {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      // ignore: use_build_context_synchronously
                                                      showNotificationError(
                                                          context,
                                                          "Pas de connexion internet !");
                                                    }
                                                  },
                                                  child: const Text('Valider'),
                                                ),
                                              ],
                                            ));
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildLoading()
                  ],
                ),
              ),
            ],
          ),
          // pick photo for sending
        ));
  }

  pickColis(ImageSource source) async {
    XFile? xFileImage = await imagePicker.pickImage(source: source);
    if (xFileImage != null) {
      setState(() {
        imageColis = File(xFileImage.path);
      });
    }
  }

// //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/logo_background');

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting);
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

//   // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString(),
        //message.notification!.android!.channelId.toString(),
        importance: Importance.max,
        showBadge: true,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'you_can_name_it_whatever',
      'flutterfcm',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('jetsons_doorbell'),
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

//   //function to get device token on which we will send the notifications
  Future<String> getDeviceToken(String? token) async {
    token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

//   //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msj') {
      /*Navigator.push(context,
          MaterialPageRoute(builder: (context) => MessageScreen(
            id: message.data['id'] ,
          )));*/
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : SizedBox.shrink(),
    );
  }
}
