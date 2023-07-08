class Category{
  String? _categoryId;
  String _categoryName;
  int? _categoryTarif;

  Category(this._categoryId, this._categoryName, this._categoryTarif);

  Category.withoutId(this._categoryName, this._categoryTarif);

  // ignore: unnecessary_getters_setters
  int get categoryTarif => _categoryTarif!;

  set categoryTarif(int value) {
    _categoryTarif = value;
  }

  // ignore: unnecessary_getters_setters
  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
  }

  String get categoryId => _categoryId!;

  set categoryId(String value) {
    _categoryId = value;
  }
}