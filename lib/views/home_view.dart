import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/product_viewmodel.dart';
import '../widgets/glass_container.dart';
import '../widgets/product_visual.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: context.read<ProductViewModel>(),
      builder: (context, _) {
        final viewModel = context.read<ProductViewModel>();
        final product = viewModel.selectedProduct;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Header Title
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                        Text(
                          'For You',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Capsule tab filter row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterCapsule('✦ Brand New', true),
                      _buildFilterCapsule('♡ Favorites', false),
                      _buildFilterCapsule('✓ Filters', false),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // AI Picked Card Section
                  GlassContainer(
                    padding: const EdgeInsets.all(20),
                    borderRadius: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row with AI Picked label & Action icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.bolt, color: Colors.yellowAccent, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  product.category.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white70,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                _buildCircularIcon(Icons.favorite_border),
                                const SizedBox(width: 10),
                                _buildCircularIcon(Icons.ios_share),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Subtitle/Description text
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // List of modular product tags inside capsules
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: product.tags.map((tag) {
                            return GlassContainer(
                              borderRadius: 12,
                              backgroundColor: Colors.white.withOpacity(0.08),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.grain,
                                    size: 12,
                                    color: Colors.pink.shade200,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    tag,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Custom Central visual of the AI Picked / active product
                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Dynamically switch product to show modular items when clicked!
                        final nextIndex = (viewModel.products.indexOf(product) + 1) % viewModel.products.length;
                        viewModel.selectProduct(viewModel.products[nextIndex]);
                      },
                      child: ProductVisual(
                        imageKey: product.imagePath,
                        size: 200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60), // Space for navigation bar
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterCapsule(String label, bool isActive) {
    return GlassContainer(
      borderRadius: 20,
      backgroundColor: isActive ? const Color(0x4DFF4081) : const Color(0x13FFFFFF),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCircularIcon(IconData icon) {
    return GlassContainer(
      borderRadius: 15,
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
