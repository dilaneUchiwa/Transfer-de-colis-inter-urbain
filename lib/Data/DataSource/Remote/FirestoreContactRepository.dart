import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transfert_colis_interurbain/Utils/Converter.dart';
import '../../../App/Manager/UserManager.dart';
import '../../../Domain/Model/Contact.dart';
import '../../../Domain/Model/Message.dart';
import '../../../Domain/Model/UserApp.dart';
import '../../../Domain/Repositories/ContactRepository.dart';

class FirestoreContactRepository implements ContactRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('contact');

  Future<Contact> documentsnapshotToContact(
      DocumentSnapshot documentSnapshot) async {
    //Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    UserManager userManager = UserManager();
    final user1 = documentSnapshot.get('user1Id') == null
        ? null
        : await userManager.getUserById(documentSnapshot.get('user1Id'));
    final user2 = documentSnapshot.get('user2Id') == null
        ? null
        : await userManager.getUserById(documentSnapshot.get('user2Id'));

    List<Message> messages = [];
    List<dynamic> messageData =
        (documentSnapshot.data() as Map<String, dynamic>)["messages"];

    for (var item in messageData) {
      Message message = Message(
          item['message'],
          MyConverter.convertTimestampToDateTime(item['timestamp']),
          item['userId']);
      messages.add(message);
    }

    return Contact(documentSnapshot.id, user1!, user2!, messages);
  }

  List<Message> documentsnapshotToMessage(DocumentSnapshot documentSnapshot) {
    List<Message> messages = [];
    List<dynamic> messageData =
        (documentSnapshot.data() as Map<String, dynamic>)["messages"];

    for (var item in messageData) {
      Message message = Message(
          item['message'],
          MyConverter.convertTimestampToDateTime(item['timestamp']),
          item['userId']);
      messages.add(message);
    }
    return messages;
  }

  @override
  Future<void> addContact(Contact contact) async {
    return await _collectionReference.add({
      'user1Id': contact.user1.userId,
      'user2Id': contact.user2.userId,
      'messages': contact.messages
          .map((m) => {
                'message': m.message,
                'timestamp': m.timestamp,
                'userId': m.userId
              })
          .toList()
    }).then((DocumentReference doc) {
      contact.id = doc.id;
    });
  }

  @override
  Future<void> addMessage(Contact contact, Message m) async {
    final docRef =
        FirebaseFirestore.instance.collection('contact').doc(contact.id);
    return await docRef.update({
      'messages': FieldValue.arrayUnion([
        {'message': m.message, 'timestamp': m.timestamp, 'userId': m.userId}
      ])
    });
  }

  @override
  Stream<List<Contact>> getWithMeContacts(UserApp user) {
    return _collectionReference
        //.where('user1Id', isEqualTo: user.userId)
        .snapshots()
        .asyncMap(
            (snapshot) async => Future.wait(snapshot.docs.map((doc) async {
                  return documentsnapshotToContact(doc);
                }).toList()));

    // var userQuery = _collectionReference
    //     .where('user1Id', isEqualTo: user.userId)
    //     .snapshots()
    //     .asyncMap((snapshot) => Future.wait(
    //         snapshot.docs.map(documentsnapshotToContact)));

    // var friendQuery = _collectionReference
    //     .where('user2Id', isEqualTo: user.userId)
    //     .snapshots()
    //     .asyncMap((snapshot) => Future.wait(
    //         snapshot.docs.map(documentsnapshotToContact)));

    //  return userQuery.merge(friendQuery).map((snapshots) async {
    //   List<Contact> contacts = [];

    //   for (var snapshot in snapshots) {
    //     var contact = await documentsnapshotToContact(snapshot);
    //     contacts.add(contact);
    //   }

    //   return contacts;
  }

  @override
  Stream<List<Message>> getMessageofContact(Contact contact) {
    return _collectionReference.doc(contact.id).snapshots().map((doc) {
      return documentsnapshotToMessage(doc);
    });
  }
}
