import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';

class AccountCardTabSelector extends StatelessWidget {
  const AccountCardTabSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabButton(
            label: 'Account',
            isSelected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _TabButton(
            label: 'Card',
            isSelected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.primaryTint,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: isSelected ? AppColors.white : AppColors.neutral900,
          ),
        ),
      ),
    );
  }
}
