import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/product_viewmodel.dart';
import '../widgets/glass_container.dart';
import '../widgets/product_visual.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<ProductViewModel>(),
      builder: (context, _) {
        final viewModel = context.read<ProductViewModel>();
        final product = viewModel.selectedProduct;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Large high-tech blurred text background
               Positioned(
                top: 80,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Item',
                      style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.08),
                        height: 0.9,
                        letterSpacing: -2,
                      ),
                    ),
                    Text(
                      'Card',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.04),
                        height: 0.9,
                        letterSpacing: -2,
                      ),
                    ),
                  ],
                ),
              ),

              // Main content
               SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Product Title
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.colorVariant,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      const Spacer(),

                      // Central 3D Interactive product
                      Center(
                        child: ProductVisual(
                          imageKey: product.imagePath,
                          size: 260,
                        ),
                      ),
                      const Spacer(),

                      // Product description snippet
                      GlassContainer(
                        padding: const EdgeInsets.all(16),
                        borderRadius: 16,
                        child: Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.85),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Buy Now Glassmorphic capsule button
                      GestureDetector(
                        onTap: () {
                          viewModel.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: const Color(0xFFE91E63),
                              content: Text(
                                '${product.name} added to your cart!',
                                style: const TextStyle(color: Colors.white),
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: GlassContainer(
                          borderRadius: 30,
                          backgroundColor: const Color(0x33FF4081),
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                          child: Center(
                            child: Text(
                              'Buy for \$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40), // Spacing for bottom navigator
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
