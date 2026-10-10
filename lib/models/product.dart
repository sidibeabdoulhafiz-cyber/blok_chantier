class Product {
  final int id;
  final String name;
  final String category;
  final String unit;
  final int price;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      unit: json['unit'] as String,
      price: json['price'] as int,
    );
  }
}