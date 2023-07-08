import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transfert_colis_interurbain/App/Manager/TravelManager.dart';
import 'package:transfert_colis_interurbain/Utils/Converter.dart';

import '../../Data/DataSource/Remote/FirestoreTravelRepository.dart';
import '../../Domain/Model/Travel.dart';
import '../../Domain/Model/UserApp.dart';
import '../../Utils/InternetChecker.dart';
import '../Widgets/showSnackBar.dart';

class TravellerAdd extends StatefulWidget {
  TravellerAdd({Key? key}) : super(key: key);

  @override
  State<TravellerAdd> createState() => _TravellerAddState();
}

class _TravellerAddState extends State<TravellerAdd> {
  final _formkey = GlobalKey<FormState>();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final List<String> items = [
    'maroua',
    'garoua',
    'ngaoundere',
    'bertoua',
    'yaounde',
    'ebolowa',
    'douala',
    'buea',
    'bamenda',
    'bafoussam',
  ];

  Travel? travel;
  String? selectedDeparture;

  String? selectedDestination;

  String? QuarterDeparture;

  String? QuarterDestination;

  String? Agence;

  String? Hour;

  final TextEditingController textEditingController = TextEditingController();

  final _timeController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      _timeController.text = DateFormat('HH:mm').format(
        DateTime(2021, 1, 1, picked.hour, picked.minute),
      );
    }
  }

  String dateController = "";
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController = DateFormat("dd-MM-yyyy").format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // recuperation des données de l'utilisateur couramment connecté
    final user = Provider.of<UserApp?>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Add A New Travel"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Travel Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Town Departure',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),

                        items: items
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedDeparture,
                        onChanged: (value) {
                          setState(() {
                            selectedDeparture = value as String;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                labelText: "Town Departure",
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    onChanged: (value) => QuarterDeparture = value,
                    validator: (QuarterDeparture) => QuarterDeparture != null
                        ? null
                        : 'Enter Departure Quarter',
                    decoration: const InputDecoration(
                      labelText: "Quarter Departure",
                      hintText: "Exple : Yaounde",
                      // hintText: "Enter Email",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(width:50),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Select Town Destination',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),

                        items: items
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedDestination,
                        onChanged: (value) {
                          setState(() {
                            selectedDestination = value as String;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          height: 40,
                          width: 200,
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        dropdownSearchData: DropdownSearchData(
                          searchController: textEditingController,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Container(
                            height: 50,
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 4,
                              right: 8,
                              left: 8,
                            ),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,
                              controller: textEditingController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                hintText: 'Search for an item...',
                                labelText: "Town Destination",
                                hintStyle: const TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            return (item.value
                                .toString()
                                .contains(searchValue));
                          },
                        ),
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    onChanged: (value) => QuarterDestination = value,
                    validator: (QuarterDestination) =>
                        QuarterDestination != null
                            ? null
                            : 'Enter Destination Quarter',
                    decoration: const InputDecoration(
                      labelText: "Quarter Destination",
                      hintText: "Exple : Douala",
                      // hintText: "Enter Email",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(width:50),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    onChanged: (value) => Agence = value,
                    validator: (Agence) =>
                        Agence != null ? null : 'Enter Travel Agence',
                    decoration: const InputDecoration(
                      labelText: "Agence",
                      hintText: "Exple : General",
                      // hintText: "Enter Email",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        // borderSide: BorderSide(width:50),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(children: <Widget>[
                    TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        suffix: Icon(Icons.calendar_month_rounded),
                        labelText: "${dateController}",
                        suffixIcon: Icon(Icons.calendar_month_rounded),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        border: const OutlineInputBorder(
                          // borderSide: BorderSide(width:50),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (value) =>
                          dateController != "" ? null : "Enter Date of Birth",
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextFormField(
                    controller: _timeController,
                    onTap: () {
                      _selectTime(context);
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Select Departure Hour",
                      suffixIcon: Icon(Icons.timelapse_rounded),
                      //hintText: "Enter password",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      
                      // if (_formkey.currentState!.validate()) {
                      //   _formkey.currentState!.save();

                        if (await InternetChecker.checkInternetConnection()) {
                          travel = Travel.withoutIdAndDate(
                              selectedDeparture.toString(),
                              selectedDestination.toString(),
                              QuarterDeparture.toString(),
                              QuarterDestination.toString(),
                              Agence.toString(),
                              MyConverter.convertStringToDateTime(
                                  dateController),
                              _timeController.text,
                              user!);
                          await TravelManager().addTravel(travel!);
                          showNotificationSuccessWithDuration(
                              context, "Travel add !", 5);
                              Navigator.pop(context);

                        } else {
                          showNotificationError(
                              context, "Pas de connexion internet !");
                        }
                      // } else {
                      //   showNotificationError(context,
                      //       "Veuillez correctement remplir tout les champs !");
                      // }
                    },
                    child: const Text(
                      'Add Your Travel',
                    ),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
