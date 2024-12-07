
import 'package:arch/application/model/product_details.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String availability;
  final String link;
  final String imageLink;
  final String condition;
  final String brand;
  final String productType;
  final List<ProductDetail> productDetail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.availability,
    required this.link,
    required this.imageLink,
    required this.condition,
    required this.brand,
    required this.productType,
    required this.productDetail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['productDetail'] as List ?? [];
    List<ProductDetail> detailsList =
        list.map((i) => ProductDetail.fromJson(i)).toList();

    return Product(
      id: json['id']?.toString() ?? '',  
      title: json['title'] ?? '',        
      description: json['description'] ?? '', 
      price: json['price'] is int ? (json['price'] as int).toDouble() : json['price'] ?? 0.0, 
      availability: json['availability'] ?? '',
      link: json['link'] ?? '',        
      imageLink: json['imageLink'] ?? '', 
      condition: json['condition'] ?? '',
      brand: json['brand'] ?? '',       
      productType: json['productType'] ?? '', 
      productDetail: detailsList,
    );
  }
}