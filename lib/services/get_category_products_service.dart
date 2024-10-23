// lib/services/get_category_products_service.dart

import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class GetCategoryProductsService {
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryName}) async {
    try {
      List<dynamic> data = await Api().get(
        url: 'https://fakestoreapi.com/products/category/$categoryName',
        token: null, // إذا كان لديك توكن، قم بتمريره هنا
      );

      List<ProductModel> productsList =
          data.map((item) => ProductModel.fromJson(item)).toList();
      return productsList;
    } catch (e) {
      throw Exception('Failed to load products for category $categoryName: $e');
    }
  }
}
