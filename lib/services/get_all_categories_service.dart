// lib/services/get_all_categories_service.dart

import 'package:store_app/helper/api.dart';

class GetAllCategoriesService {
  Future<List<dynamic>> getAllCategories() async {
    try {
      List<dynamic> data = await Api().get(
        url: 'https://fakestoreapi.com/products/categories',
        token: null, // إذا كان لديك توكن، قم بتمريره هنا
      );
      return data;
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
