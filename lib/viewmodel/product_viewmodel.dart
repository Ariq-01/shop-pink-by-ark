import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductViewModel extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Ethereal Aura Sound Shells',
      category: 'AI PICKED',
      price: 320.0,
      description: 'Based on your appreciation for "Sunday Morning" soundscapes, the P1 features an adaptive acoustic chamber that mimics natural acoustics...',
      tags: ['Bio-Carbon Frame', '48h Battery', 'Spatial Audio'],
      imagePath: 'headphones',
      colorVariant: 'Nebula Violet',
    ),
    Product(
      id: '2',
      name: 'Ethereal Chronograph',
      category: 'Smartwatch',
      price: 499.0,
      description: 'A premium titanium smartwatch designed to track your circadian rhythm, style, and vitals with medical-grade sensory arrays.',
      tags: ['Titanium Case', 'Sleep Sync', 'ECG Sensor'],
      imagePath: 'watch',
      colorVariant: 'Bright Pink / Titanium',
    ),
    Product(
      id: '3',
      name: 'Ethereal Essence',
      category: 'Luxury Scent',
      price: 876.0,
      description: 'A glass-sculpted sensory experience. Sweet blossom notes blended with bioluminescent ambient aesthetics for the ultimate mood enhancer.',
      tags: ['Glass Sculpture', 'Natural Scent', 'Ambient Light'],
      imagePath: 'perfume',
      colorVariant: 'Sweet Blossom',
    ),
  ];

  late Product _selectedProduct;
  final List<CartItem> _cart = [];

  ProductViewModel() {
    _selectedProduct = _products[0];
    // Populate cart with default items as seen in image for rich first experience:
    // "Ethereal Chronograph" and "Ethereal Aura Sound Shells"
    _cart.add(CartItem(product: _products[1], quantity: 1)); // Ethereal Chronograph
    _cart.add(CartItem(product: _products[0], quantity: 1)); // Ethereal Aura Sound Shells
  }

  List<Product> get products => _products;
  Product get selectedProduct => _selectedProduct;
  List<CartItem> get cart => _cart;

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal => _cart.fold(0.0, (sum, item) => sum + item.totalPrice);

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void addToCart(Product product) {
    final index = _cart.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity++;
    } else {
      _cart.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    final index = _cart.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _cart[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    final index = _cart.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (_cart[index].quantity > 1) {
        _cart[index].quantity--;
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }
}
