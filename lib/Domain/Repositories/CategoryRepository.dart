import '/Domain/Model/Category.dart';

abstract class CategoryRepository {
  Future<void> addCategory(Category cat);
  Future<List<Category>> getCategories();
  Future<Category> getCategoryById(String id);
  Future<void> updateCategory(Category cat);
}
