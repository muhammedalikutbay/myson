import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/view/main/viewmodel/main_viewmodel.dart';
import 'package:myson/view/catalog/view/catalog_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainViewModel(),
      child: const _MainViewContent(),
    );
  }
}

class _MainViewContent extends StatelessWidget {
  const _MainViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: [
          const CatalogView(),
          const _PlaceholderView(title: 'Discover'),
          const _PlaceholderView(title: 'Support'),
          const _PlaceholderView(title: 'Bag'),
        ],
      ),
      bottomNavigationBar: _AppBottomNavigationBar(
        selectedIndex: viewModel.currentIndex,
        onItemSelected: viewModel.setIndex,
      ),
    );
  }
}

class _AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const _AppBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withAlpha((0.8 * 255).round()),
        border: const Border(
          top: BorderSide(color: AppColors.separator, width: 0.5),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemSelected,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: AppColors.neutralGray,
        selectedLabelStyle: AppTypography.footnote.copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: AppTypography.footnote,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_outlined),
            activeIcon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            activeIcon: Icon(Icons.help),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Bag',
          ),
        ],
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final String title;
  const _PlaceholderView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: AppTypography.headline),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '$title Coming Soon',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.neutralGray),
        ),
      ),
    );
  }
}
