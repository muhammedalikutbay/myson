import 'package:flutter/material.dart';
import 'package:myson/core/components/app_tab_navigation.dart';

class CategoryTabs extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the selected index based on the category string
    final selectedIndex = categories.indexOf(selectedCategory);

    return AppTabNavigation(
      items: categories,
      selectedIndex: selectedIndex != -1 ? selectedIndex : 0,
      onTabSelected: (index) => onCategorySelected(categories[index]),
    );
  }
}
