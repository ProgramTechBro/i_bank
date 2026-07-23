import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/enums/bill_category.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/bill_category_tile.dart';

class PayBillScreen extends StatelessWidget {
  const PayBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay the bill')),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: BillCategory.values.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final category = BillCategory.values[index];
          return BillCategoryTile(
            category: category,
            onTap: () => context.push(
              AppRoutes.paymentHistory,
              extra: category,
            ),
          );
        },
      ),
    );
  }
}
