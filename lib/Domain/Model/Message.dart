class Message {
  String _message;
  DateTime _timestamp;

  Message(this._message,this._timestamp);

  DateTime get timestamp => _timestamp;

  set timestamp(DateTime value) {
    _timestamp = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }


}