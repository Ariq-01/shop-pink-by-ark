class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final List<String> tags;
  final String imagePath; // Local or mock key
  final String colorVariant;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.tags,
    required this.imagePath,
    required this.colorVariant,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}
