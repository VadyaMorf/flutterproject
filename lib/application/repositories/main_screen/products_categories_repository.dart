import 'package:arch/application/model/product.dart';
import 'package:arch/application/repositories/main_screen/abstract_products_repository.dart';
import 'package:dio/dio.dart';

class ProductsCategoriesRepository implements AbstractProductsRepository {
  String baseUrl = 'http://10.0.2.2:5132/Products/tonometr';

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List<dynamic> products = data['tonometrs'] ?? [];

        List<Product> responseItems = products.map((item) {
          return Product.fromJson(item);
        }).toList();

        responseItems.sort((a, b) {
          if (a.availability == "out of stock" &&
              b.availability != "out of stock") {
            return 1;
          } else if (a.availability != "out of stock" &&
              b.availability == "out of stock") {
            return -1;
          }
          return 0;
        });

        return responseItems;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

  Future<List<Map<String, String>>> getCategoryList() async {
    return [
      {'name': 'Напівавтоматичні', 'image': 'assets/images/glukometr.png'},
      {'name': 'Автоматичні', 'image': 'assets/images/lanceti.png'},
      {'name': "На зап'ястя", 'image': 'assets/images/testpolosi.png'},
      {'name': 'Механичні', 'image': 'assets/images/insulin.png'},
      {'name': 'Светоскопи, фонедоскопи', 'image': 'assets/images/shpritz.png'},
    ];
  }
}
