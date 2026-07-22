import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../routes/app_routes.dart';
import 'home_quick_action.dart';

class HomeQuickActionsGrid extends StatelessWidget {
  const HomeQuickActionsGrid({super.key});

  static const List<HomeQuickAction> _actions = [
    HomeQuickAction(
      iconAsset: AppIcons.categoryAccountAndCard,
      label: 'Account and Card',
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryTransfer,
      label: 'Transfer',
      route: AppRoutes.transfer,
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryWithdraw,
      label: 'Withdraw',
      route: AppRoutes.withdraw,
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryMobilePrepaid,
      label: 'Mobile prepaid',
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryPayTheBill,
      label: 'Pay the bill',
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categorySaveOnline,
      label: 'Save online',
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryCreditCard,
      label: 'Credit card',
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryTransactionReport,
      label: 'Transaction report',
      route: AppRoutes.transactionReport,
    ),
    HomeQuickAction(
      iconAsset: AppIcons.categoryBeneficiary,
      label: 'Beneficiary',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) =>
          _QuickActionTile(action: _actions[index]),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action});

  final HomeQuickAction action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.route == null ? null : () => context.push(action.route!),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppColors.cardShadowNeutral,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(action.iconAsset, width: 36, height: 36),
            const SizedBox(height: 8),
            Text(
              action.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.neutral500),
            ),
          ],
        ),
      ),
    );
  }
}
