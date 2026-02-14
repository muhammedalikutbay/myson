import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myson/core/constants/app_design_tokens.dart';
import 'package:myson/core/init/locator.dart';
import 'package:myson/core/state/cart_service.dart';
import 'package:myson/view/main/viewmodel/main_viewmodel.dart';
import 'package:myson/view/catalog/view/catalog_view.dart';
import 'package:myson/view/discovery/view/discovery_view.dart';
import 'package:myson/view/search/view/search_view.dart';
import 'package:myson/view/bag/view/bag_view.dart';
import 'package:myson/view/profile/view/profile_view.dart';

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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await viewModel.handleWillPop();
        if (shouldExit && context.mounted) {
          // If we are at the root of a tab, we let the app exit or handle root level pop
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: IndexedStack(
            index: viewModel.currentIndex,
            children: [
              _TabNavigator(
                navigatorKey: viewModel.navigatorKeys[0]!,
                rootPath: const DiscoveryView(),
              ),
              _TabNavigator(
                navigatorKey: viewModel.navigatorKeys[1]!,
                rootPath: const SearchView(),
              ),
              _TabNavigator(
                navigatorKey: viewModel.navigatorKeys[2]!,
                rootPath: const CatalogView(),
              ),
              _TabNavigator(
                navigatorKey: viewModel.navigatorKeys[3]!,
                rootPath: const BagView(),
              ),
              _TabNavigator(
                navigatorKey: viewModel.navigatorKeys[4]!,
                rootPath: const ProfileView(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _AppBottomNavigationBar(
          selectedIndex: viewModel.currentIndex,
          onItemSelected: viewModel.setIndex,
        ),
      ),
    );
  }
}

class _TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget rootPath;

  const _TabNavigator({required this.navigatorKey, required this.rootPath});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => rootPath);
      },
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
    final cartService = locator<CartService>();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background.withAlpha((0.7 * 255).round()),
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
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_number_outlined),
                activeIcon: Icon(Icons.confirmation_number),
                label: 'Deals',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Search',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: ValueListenableBuilder<int>(
                  valueListenable: cartService.cartCount,
                  builder: (context, count, child) {
                    return _BagIconWithBadge(count: count, isSelected: false);
                  },
                ),
                activeIcon: ValueListenableBuilder<int>(
                  valueListenable: cartService.cartCount,
                  builder: (context, count, child) {
                    return _BagIconWithBadge(count: count, isSelected: true);
                  },
                ),
                label: 'Bag',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BagIconWithBadge extends StatelessWidget {
  final int count;
  final bool isSelected;

  const _BagIconWithBadge({required this.count, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          isSelected ? Icons.shopping_bag : Icons.shopping_bag_outlined,
          color: isSelected ? Colors.black : AppColors.neutralGray,
        ),
        if (count > 0)
          Positioned(
            right: -6,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
