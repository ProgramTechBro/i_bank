import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    (
      label: 'Home',
      selectedIcon: AppIcons.navHomeSelected,
      unselectedIcon: AppIcons.navHomeUnselected,
    ),
    (
      label: 'Search',
      selectedIcon: AppIcons.navSearchSelected,
      unselectedIcon: AppIcons.navSearchUnselected,
    ),
    (
      label: 'Message',
      selectedIcon: AppIcons.navMessageSelected,
      unselectedIcon: AppIcons.navMessageUnselected,
    ),
    (
      label: 'Settings',
      selectedIcon: AppIcons.navSettingsSelected,
      unselectedIcon: AppIcons.navSettingsUnselected,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: AppColors.tabBarShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final isSelected = index == selectedIndex;
          return _NavItem(
            label: item.label,
            iconAsset: isSelected ? item.selectedIcon : item.unselectedIcon,
            isSelected: isSelected,
            onTap: () => onTap(index),
          );
        }),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.iconAsset,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconAsset,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.neutral500,
                BlendMode.srcIn,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
