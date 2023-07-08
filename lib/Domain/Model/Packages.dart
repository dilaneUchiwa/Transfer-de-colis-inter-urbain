import '../../Domain/Model/UserApp.dart';

class Packages {
  String? _packageId;
  String? _packageDescription;
  String? _packagePhoto;
  int? _packageValue;
  UserApp? _userSender;
  String? _travelId;


  Packages.empty();
  Packages.withoutId(this._packageDescription, this._packagePhoto,
      this._packageValue, this._userSender, this._travelId);

  Packages(
      this._packageId,
      this._packageDescription,
      this._packagePhoto,
      this._packageValue,
      this._userSender,
      this._travelId,
    );

  // ignore: unnecessary_getters_setters
  UserApp get userSender => _userSender!;

  set userSender(UserApp value) {
    _userSender = value;
  }


  // ignore: unnecessary_getters_setters
  int get packageValue => _packageValue!;

  set packageValue(int value) {
    _packageValue = value;
  }

  String get packagePhoto {
    if (_packagePhoto == null) return '';
    return _packagePhoto!;
  }

  set packagePhoto(String value) {
    _packagePhoto = value;
  }

  // ignore: unnecessary_getters_setters
  String get packageDescription => _packageDescription!;

  set packageDescription(String value) {
    _packageDescription = value;
  }

  String get packageId => _packageId!;

  set packageId(String value) {
    _packageId = value;
  }

  String get travelId => _travelId!;

  set travelId(String value) {
    _travelId = value;
  }

  }
