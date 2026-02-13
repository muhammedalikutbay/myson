import 'package:flutter/material.dart';
import 'package:myson/core/constants/app_design_tokens.dart';

class AppTabNavigation extends StatefulWidget {
  final List<String> items;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const AppTabNavigation({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<AppTabNavigation> createState() => _AppTabNavigationState();
}

class _AppTabNavigationState extends State<AppTabNavigation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.items.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
  }

  @override
  void didUpdateWidget(AppTabNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground.withAlpha((0.5 * 255).round()),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            onTap: widget.onTabSelected,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: const Color(0xFF1D1D1F), // Darker Apple-style black
              borderRadius: BorderRadius.circular(21),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: const Color(
              0xFF424245,
            ), // Apple secondary text
            labelStyle: AppTypography.headline.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: AppTypography.headline.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: widget.items
                .map(
                  (item) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(item),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
