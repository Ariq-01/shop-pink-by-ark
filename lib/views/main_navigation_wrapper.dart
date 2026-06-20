import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_view.dart';
import 'item_detail_view.dart';
import 'cart_view.dart';
import '../widgets/glass_container.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  late PageController _pageController;
  int _currentPage = 1; // Middle screen (Recommendations) is index 1

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    if (page >= 0 && page <= 2) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  String _getPageLabel(int index) {
    switch (index) {
      case 0:
        return 'Item Card';
      case 1:
        return 'Recommendations';
      case 2:
      default:
        return 'Cart';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Elegant animated fluid pink / lavender background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF8BBD0), // Soft pink
                  Color(0xFFF48FB1), // Warm bubblegum pink
                  Color(0xFFCE93D8), // Pastel lavender purple
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Subtly overlaid glowing ambient light source
          Positioned(
            bottom: -150,
            left: -50,
            right: -50,
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF4081).withOpacity(0.4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFFF4081),
                    blurRadius: 200,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          // Horizontal PageView for Left, Middle, and Right screen navigation
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: const [
              ItemDetailView(), // Left page (index 0)
              HomeView(),       // Middle page (index 1)
              CartView(),       // Right page (index 2)
            ],
          ),

          // Shared floating bottom glassmorphic navigation bar
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button (shown when not on the very left screen)
                Opacity(
                  opacity: _currentPage > 0 ? 1.0 : 0.3,
                  child: GestureDetector(
                    onTap: _currentPage > 0 ? () => _navigateToPage(_currentPage - 1) : null,
                    child: const GlassContainer(
                      borderRadius: 20,
                      padding: EdgeInsets.all(14),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                ),

                // Center indicator label capsule
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        // Loop through pages
                        _navigateToPage((_currentPage + 1) % 3);
                      },
                      child: GlassContainer(
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Center(
                          child: Text(
                            _getPageLabel(_currentPage),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Next Button (shown when not on the very right screen)
                Opacity(
                  opacity: _currentPage < 2 ? 1.0 : 0.3,
                  child: GestureDetector(
                    onTap: _currentPage < 2 ? () => _navigateToPage(_currentPage + 1) : null,
                    child: const GlassContainer(
                      borderRadius: 20,
                      padding: EdgeInsets.all(14),
                      child: Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
