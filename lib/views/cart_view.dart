import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/product_viewmodel.dart';
import '../widgets/glass_container.dart';
import '../widgets/product_visual.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<ProductViewModel>(),
      builder: (context, _) {
        final viewModel = context.read<ProductViewModel>();
        final cartItems = viewModel.cart;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // "ACTIVE ORDER"
                  Text(
                    'ACTIVE ORDER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.5),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Header with title and total items count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Cart',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        '${viewModel.cartCount} items',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Cart Item list
                  Expanded(
                    child: cartItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.white.withOpacity(0.3)),
                                const SizedBox(height: 16),
                                Text(
                                  'Your cart is empty',
                                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: cartItems.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return GlassContainer(
                                padding: const EdgeInsets.all(16),
                                borderRadius: 20,
                                child: Row(
                                  children: [
                                    // Visual representation of product
                                    ProductVisual(
                                      imageKey: item.product.imagePath,
                                      size: 70,
                                    ),
                                    const SizedBox(width: 16),

                                    // Details of product
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.product.name,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.product.colorVariant,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white.withOpacity(0.5),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 12),

                                          // Quantity modifiers inside a sleek pill glass
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GlassContainer(
                                                borderRadius: 12,
                                                backgroundColor: Colors.white.withOpacity(0.06),
                                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons.remove, size: 14, color: Colors.white70),
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                      onPressed: () => viewModel.decrementQuantity(item.product.id),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                                      child: Text(
                                                        '${item.quantity}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(Icons.add, size: 14, color: Colors.white70),
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                      onPressed: () => viewModel.incrementQuantity(item.product.id),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Price
                                              Text(
                                                '\$${item.totalPrice.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),

                  // Bottom Total & Checkout Button
                  if (cartItems.isNotEmpty)
                    Column(
                      children: [
                        // Sub-total description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                '\$${viewModel.cartTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Checkout Button
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.pinkAccent,
                                content: Text('Order Submitted Successfully! Thank you!'),
                              ),
                            );
                          },
                          child: GlassContainer(
                            borderRadius: 30,
                            backgroundColor: const Color(0x33FF4081),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: const Center(
                              child: Text(
                                'Buy all',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 60), // Navigation spacer
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
