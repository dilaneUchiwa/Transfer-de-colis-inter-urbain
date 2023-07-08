 
// ignore: file_names
import 'package:flutter/foundation.dart';
import '../../Domain/Model/Packages.dart';


class Belongs{
  String? _belongsId;
  Category _category;
  Packages _packages;


  Belongs(this._belongsId, this._category, this._packages);

  Belongs.withoutId(this._category, this._packages);

  // ignore: unnecessary_getters_setters
  Packages get packages => _packages;

  set packages(Packages value) {
    _packages = value;
  }

  // ignore: unnecessary_getters_setters
  Category get category => _category;

  set category(Category value) {
    _category = value;
  }

  String get belongsId => _belongsId!;

  set belongsId(String value) {
    _belongsId = value;
  }




}