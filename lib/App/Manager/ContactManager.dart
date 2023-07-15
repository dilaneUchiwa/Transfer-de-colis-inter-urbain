import 'dart:math';

import '../../Data/DataSource/Remote/FirestoreContactRepository.dart';
import '../../Domain/Model/Contact.dart';
import '../../Domain/Model/Message.dart';
import '../../Domain/Model/UserApp.dart';

class ContactManager {
  final FirestoreContactRepository _firestoreContactRepository =
      FirestoreContactRepository();

  Future<void> addContact(Contact contact) async {
    return _firestoreContactRepository.addContact(contact);
  }

  Future<void> addMessage(Contact contact, Message message) async {
    return _firestoreContactRepository.addMessage(contact, message);
  }

  Stream<List<Contact>> getWithMeContacts(UserApp user) {
    return _firestoreContactRepository.getWithMeContacts(user);
  }

  Stream<List<Message>> getMessageofContact(Contact contact) {
    return _firestoreContactRepository.getMessageofContact(contact);
  }
}
