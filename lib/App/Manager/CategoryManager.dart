
import '../../Data/DataSource/Remote/FirestoreCategoryRepository.dart';
import '../../Domain/Model/Category.dart';

class CategoryManager{
  final FirestoreCategoryRepository _firestoreCategoryRepository=FirestoreCategoryRepository();

  CategoryManager();

  Future<void> addCategory(Category cat) async{
    return await _firestoreCategoryRepository.addCategory(cat);
  }
  Future<void> updateCategory(Category cat) async{
    return await _firestoreCategoryRepository.updateCategory(cat);
  }
  Future<List<Category>> getCategorys() async{
    return await _firestoreCategoryRepository.getCategories();
  }
  Future<Category> getCategoryById(String id) async{
    return await _firestoreCategoryRepository.getCategoryById(id);
  }
}