import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Domain/Model/Category.dart';
import '../../../Domain/Repositories/CategoryRepository.dart';


class FirestoreCategoryRepository implements CategoryRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('category');

  Future<Category> documentsnapshotToCategory(DocumentSnapshot documentSnapshot) async {
    final cat = Category(
      documentSnapshot.id,
      documentSnapshot.get('categoryName'),
      documentSnapshot.get('categoryTarif')
    );
    return cat;
  }

  @override
  Future<void> addCategory(Category cat) {
    return _collectionReference.add({
      'categoryName': cat.categoryName,
      'categoryTarif': cat.categoryTarif
    }).then((DocumentReference doc) => cat.categoryId = doc.id);
  }

  @override
  Future<List<Category>> getCategories() async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    List<Category> Categories = [];

    querySnapshot.docs.forEach((doc) async {
      final Category = await documentsnapshotToCategory(doc);
      Categories.add(Category);
    });

    return Categories;
  }

  @override
  Future<Category> getCategoryById(String id) async {
    final snapshot = await _collectionReference.doc(id).get();
    if (!snapshot.exists) {
      throw FirebaseException(
          message: 'Category with id $id does not exist',
          code: 'not-found',
          plugin: '');
    }
    return documentsnapshotToCategory(snapshot);
  }

  @override
  Future<void> updateCategory(Category cat) {
    return _collectionReference.doc(cat.categoryId).update({
       'categoryName': cat.categoryName,
      'categoryTarif': cat.categoryTarif
    });
  }
}
