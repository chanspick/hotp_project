class Product {
  final String id;
  final String name;

  Product({required this.id, required this.name});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
