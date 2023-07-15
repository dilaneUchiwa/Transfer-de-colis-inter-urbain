import 'package:transfert_colis_interurbain/Domain/Model/Message.dart';
import 'package:transfert_colis_interurbain/Domain/Model/UserApp.dart';

import '../Model/Contact.dart';


abstract class ContactRepository {
  Future<void> addContact(Contact contact);
  Future<void> addMessage(Contact contact,Message message);
  Stream<List<Contact>> getWithMeContacts(UserApp user);
  Stream<List<Message>> getMessageofContact(Contact contact);
}
