class Payment{
  String? _paymentId;
  String _paymentOperator;
  int _paymentPrice;
  bool _status;
  String _account;
  DateTime? _timestamp;

  Payment(this._paymentId, this._paymentOperator,
      this._paymentPrice,this._status,this._account,this._timestamp);

  Payment.withoutIdAndDate(this._paymentOperator,
      this._paymentPrice,this._status,this._account);

  int get paymentPrice => _paymentPrice;

  set paymentPrice(int value) {
    _paymentPrice = value;
  }

  String get paymentOperator => _paymentOperator;

  set paymentOperateur(String value) {
    _paymentOperator = value;
  }

  String get paymentId => _paymentId!;

  set paymentId(String value) {
    _paymentId = value;
  }
  bool get status => _status;

  set status(bool value) {
    _status = value;
  }
   String get account => _account;

  set account(String value) {
    _account = value;
  }
   DateTime get timestamp => _timestamp!;

  set timestamp(DateTime value) {
    _timestamp = value;
  }
}