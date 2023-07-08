import 'package:flutter/material.dart';
import '../../Domain/Model/UserApp.dart';

class Travel {
  String? _travelId;
  String _travelDeparture;
  String _travelDestination;
  String _quarterDeparture;
  String _quarterDestination;
  String _agence;
  DateTime _travelDate;
  String _travelMoment;
  UserApp _user;
  DateTime? _timestamp;

  
  Travel(
      this._travelId,
      this._travelDeparture,
      this._travelDestination,
      this._quarterDeparture,
      this._quarterDestination,
      this._agence,
      this._travelDate,
      this._travelMoment,
      this._user,
      this._timestamp);

  Travel.withoutIdAndDate(
      this._travelDeparture,
      this._travelDestination,
      this._quarterDeparture,
      this._quarterDestination,
      this._agence,
      this._travelDate,
      this._travelMoment,
      this._user);

  UserApp get user => _user;

  set user(UserApp value) {
    _user = value;
  }

  String get travelMoment => _travelMoment;

  set travelMoment(String value) {
    _travelMoment = value;
  }

  DateTime get travelDate => _travelDate;

  set travelDate(DateTime value) {
    _travelDate = value;
  }

  String get travelDestination => _travelDestination;

  set travelDestination(String value) {
    _travelDestination = value;
  }

  String get travelDeparture => _travelDeparture;

  set travelDeparture(String value) {
    _travelDeparture = value;
  }

  String get quarterDestination => _quarterDestination;

  set quarterDestination(String value) {
    _quarterDestination = value;
  }

  String get quarterDeparture => _quarterDeparture;

  set quarterDeparture(String value) {
    _quarterDeparture = value;
  }

  String get agence => _agence;

  set agence(String value) {
    _agence = value;
  }

  String get travelId => _travelId!;

  set travelId(String value) {
    _travelId = value;
  }

  DateTime get timestamp => _timestamp!;

  set timestamp(DateTime value) {
    _timestamp = value;
  }
}
