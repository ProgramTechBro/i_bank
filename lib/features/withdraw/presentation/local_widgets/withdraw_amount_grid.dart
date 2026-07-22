import 'package:flutter/material.dart';
import 'withdraw_amount_chip.dart';

class WithdrawAmountGrid extends StatelessWidget {
  const WithdrawAmountGrid({
    super.key,
    required this.selectedAmount,
    required this.isOtherSelected,
    required this.onSelectAmount,
    required this.onSelectOther,
  });

  final double? selectedAmount;
  final bool isOtherSelected;
  final ValueChanged<double> onSelectAmount;
  final VoidCallback onSelectOther;

  static const List<double> _presetAmounts = [10, 50, 100, 150, 200];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AmountRow(
          children: [
            for (final amount in _presetAmounts.sublist(0, 3))
              _presetChip(amount),
          ],
        ),
        const SizedBox(height: 12),
        _AmountRow(
          children: [
            for (final amount in _presetAmounts.sublist(3, 5))
              _presetChip(amount),
            WithdrawAmountChip(
              label: 'Other',
              isSelected: isOtherSelected,
              onTap: onSelectOther,
            ),
          ],
        ),
      ],
    );
  }

  Widget _presetChip(double amount) {
    return WithdrawAmountChip(
      label: '\$${amount.toStringAsFixed(0)}',
      isSelected: selectedAmount == amount,
      onTap: () => onSelectAmount(amount),
    );
  }
}

class _AmountRow extends StatelessWidget {
  const _AmountRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}
