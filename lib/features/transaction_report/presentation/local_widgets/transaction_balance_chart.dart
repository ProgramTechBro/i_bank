import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/balance_history_point_entity.dart';

class TransactionBalanceChart extends StatelessWidget {
  const TransactionBalanceChart({
    super.key,
    required this.balance,
    required this.history,
    this.highlightedIndex,
  });

  final double balance;
  final List<BalanceHistoryPointEntity> history;
  final int? highlightedIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final maxValue = history
        .map((point) => point.value)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: AppColors.cardShadowPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance',
            style: textTheme.labelSmall?.copyWith(color: AppColors.neutral900),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance.toStringAsFixed(0),
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 32,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'USD',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.neutral500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: BarChart(
              BarChartData(
                maxY: maxValue * 1.05,
                alignment: BarChartAlignment.spaceAround,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                barTouchData: BarTouchData(enabled: false),
                barGroups: [
                  for (var i = 0; i < history.length; i++)
                    _buildGroup(i, history[i].value),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var i = 0; i < history.length; i++)
                Expanded(
                  child: Text(
                    history[i].month,
                    textAlign: TextAlign.center,
                    style: textTheme.labelSmall?.copyWith(
                      color: i == highlightedIndex
                          ? AppColors.primary
                          : AppColors.neutral300,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildGroup(int x, double value) {
    final redHeight = value * 0.55;
    final pinkHeight = value * 0.35;

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 14,
          borderRadius: BorderRadius.circular(10),
          rodStackItems: [
            BarChartRodStackItem(0, redHeight, AppColors.semanticError),
            BarChartRodStackItem(
              redHeight,
              redHeight + pinkHeight,
              AppColors.chartPink,
            ),
            BarChartRodStackItem(
              redHeight + pinkHeight,
              value,
              AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}
