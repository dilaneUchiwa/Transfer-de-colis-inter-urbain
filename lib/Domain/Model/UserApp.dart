import 'package:firebase_auth/firebase_auth.dart';

class UserApp {
  String? _userId;
  String? _userName;
  String? _userSurname;
  DateTime? _userDateOfBirth;
  String? _userSexe;
  String? _userPhotoIdCardRecto;
  String? _userPhotoIdCardVerso;
  String? _userPhoto;
  int? _userTelephoneNumber;
  String? _userEmail;
  String? _userPassword;
  String? _userToken;
  DateTime? _createdAt;
  DateTime? _modifiedAt;
  bool? _isValid;
  bool? _isAdmin;
  User? user;

  UserApp.empty();
  UserApp(
      this._userId,
      this._userName,
      this._userSurname,
      this._userDateOfBirth,
      this._userSexe,
      this._userPhotoIdCardRecto,
      this._userPhotoIdCardVerso,
      this._userPhoto,
      this._userTelephoneNumber,
      this._userEmail,
      this._userPassword,
      this._userToken,
      this._createdAt,
      this._modifiedAt,
      this._isValid,
      this._isAdmin);

  UserApp.withoutIdAndDate(
      this._userName,
      this._userSurname,
      this._userDateOfBirth,
      this._userSexe,
      this._userPhotoIdCardRecto,
      this._userPhotoIdCardVerso,
      this._userPhoto,
      this._userTelephoneNumber,
      this._userEmail,
      this._userPassword,
      this._userToken);

  String? get userPassword => _userPassword;

  set userPassword(String? value) {
    _userPassword = value;
  }

  bool? get isValid => _isValid;

  set isValid(bool? value) {
    _isValid = value;
  }

  bool? get isAdmin => _isAdmin;

  set isAdmin(bool? value) {
    _isAdmin = value;
  }

  String? get userEmail => _userEmail;

  set userEmail(String? value) {
    _userEmail = value;
  }

  int? get userTelephoneNumber => _userTelephoneNumber;

  set userTelephoneNumber(int? value) {
    _userTelephoneNumber = value;
  }

  String? get userPhoto => _userPhoto;

  set userPhoto(String? value) {
    _userPhoto = value;
  }

  String? get userPhotoIdCardRecto => _userPhotoIdCardRecto;

  set userPhotoIdCardRecto(String? value) {
    _userPhotoIdCardRecto = value;
  }

  String? get userSexe => _userSexe;

  set userSexe(String? value) {
    _userSexe = value;
  }

  DateTime? get userDateOfBirth => _userDateOfBirth;

  set userDateOfBirth(DateTime? value) {
    _userDateOfBirth = value;
  }

  String? get userSurname => _userSurname;

  set userSurname(String? value) {
    _userSurname = value;
  }

  String? get userName => _userName;

  set userName(String? value) {
    _userName = value;
  }

  String? get userId => _userId!;

  set userId(String? value) {
    _userId = value;
  }

  String? get userToken => _userToken!;

  set userToken(String? value) {
    _userToken = value;
  }

  DateTime get createdAT => _createdAt!;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  DateTime get modifiedAt => _modifiedAt!;

  set ModifiedAt(DateTime value) {
    _modifiedAt = value;
  }

  // Verify if all value are provide
  bool isFullProvide() {
    return userDateOfBirth != null &&
        userEmail != null &&
        userName != null &&
        userPassword != null &&
        userSexe != null &&
        userSurname != null &&
        userTelephoneNumber != null;
  }

  String? get userPhotoIdCardVerso => _userPhotoIdCardVerso;

  set userPhotoIdCardVerso(String? value) {
    _userPhotoIdCardVerso = value;
  }
}
