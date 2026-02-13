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
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.separator, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            onTap: widget.onTabSelected,
            indicatorColor: Colors.black,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: AppColors.secondaryLabel,
            labelStyle: AppTypography.headline.copyWith(fontSize: 14),
            unselectedLabelStyle: AppTypography.headline.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: widget.items
                .map(
                  (item) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(item),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
