import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/main_navigation_wrapper.dart';
import 'viewmodel/product_viewmodel.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    // Injecting the MVVM ProductViewModel so it is shared across all navigable views
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: const MainNavigationWrapper(),
    );
  }
}
