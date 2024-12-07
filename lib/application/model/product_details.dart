class ProductDetail {
  final String name;
  final String value;

  ProductDetail({required this.name, required this.value});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      name: json['name'],
      value: json['value'],
    );
  }
}