import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/extensions/bill_category_extension.dart';
import '../../domain/entities/bill_details_entity.dart';

class BillTicketCard extends StatelessWidget {
  const BillTicketCard({
    super.key,
    required this.category,
    required this.details,
  });

  final BillCategory category;
  final BillDetailsEntity details;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadowPrimary,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('All the Bills', style: textTheme.titleSmall),
                const SizedBox(height: 16),
                _InfoRow(label: 'Name', value: details.name),
                const SizedBox(height: 12),
                _InfoRow(label: 'Address', value: details.address),
                const SizedBox(height: 12),
                _InfoRow(label: 'Phone number', value: details.phoneNumber),
                const SizedBox(height: 12),
                _InfoRow(label: 'Code', value: details.code),
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'From',
                  value: dateFormat.format(details.fromDate),
                ),
                const SizedBox(height: 12),
                _InfoRow(label: 'To', value: dateFormat.format(details.toDate)),
                const SizedBox(height: 16),
                _FeeRow(label: category.feeLabel, value: details.fee),
                const SizedBox(height: 12),
                const Divider(color: AppColors.neutral200, height: 1),
                const SizedBox(height: 12),
                _FeeRow(label: 'Tax', value: details.tax),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _TicketSeam(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TOTAL', style: textTheme.titleSmall),
                Text(
                  '\$${details.total.toStringAsFixed(0)}',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.semanticError,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(color: AppColors.neutral500),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: textTheme.labelSmall?.copyWith(color: AppColors.neutral900),
          ),
        ),
      ],
    );
  }
}

class _FeeRow extends StatelessWidget {
  const _FeeRow({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.neutral500),
        ),
        Text(
          '\$${value.toStringAsFixed(0)}',
          style: textTheme.titleSmall?.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}

class _TicketSeam extends StatelessWidget {
  const _TicketSeam();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16,
            right: 16,
            child: CustomPaint(
              size: const Size(double.infinity, 1),
              painter: const _DashedLinePainter(color: AppColors.neutral300),
            ),
          ),
          const Positioned(left: -8, child: _NotchCircle()),
          const Positioned(right: -8, child: _NotchCircle()),
        ],
      ),
    );
  }
}

class _NotchCircle extends StatelessWidget {
  const _NotchCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter({required this.color});

  final Color color;

  static const double _dashWidth = 5;
  static const double _dashGap = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + _dashWidth, 0), paint);
      x += _dashWidth + _dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
