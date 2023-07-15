class Message {
  String _message;
  DateTime _timestamp;
  String _userId;
  
  Message(this._message,this._timestamp,this._userId);

  DateTime get timestamp => _timestamp;

  set timestamp(DateTime value) {
    _timestamp = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }
  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

}