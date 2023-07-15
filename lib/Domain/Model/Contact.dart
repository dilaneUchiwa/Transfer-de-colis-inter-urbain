import '../../Domain/Model/Message.dart';
import '../../Domain/Model/UserApp.dart';

class Contact{
  String? _id;
  UserApp _user1;
  UserApp _user2;
  List<Message>? _messages;
  
  Contact(this._id,this._user1,this._user2,this._messages);

 Contact.withoutId(this._user1,this._user2,this._messages);

  List<Message> get messages => _messages!;

  set messages(List<Message> value) {
    _messages = value;
  }

  UserApp get user2 => _user2;

  set user2(UserApp value) {
    _user2 = value;
  }

  UserApp get user1 => _user1;

  set user1(UserApp value) {
    _user1 = value;
  }

  String get id => _id!;

  set id(String value) {
    _id = value;
  }
}