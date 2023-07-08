class PackageItem {
  String? _packageName;
  int? _packageValue;

  PackageItem.empty();
  PackageItem(this._packageName, this._packageValue);

  int? get packageValue => _packageValue;
  set packageValue(int? value) {
    _packageValue = value;
  }
  
  String? get packageName => _packageName;
  set packageName(String? value) {
    _packageName = value;
  }
}
