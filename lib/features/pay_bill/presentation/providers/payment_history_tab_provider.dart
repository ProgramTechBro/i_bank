import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/enums/bill_category.dart';

part 'payment_history_tab_provider.g.dart';

@riverpod
class PaymentHistoryTab extends _$PaymentHistoryTab {
  @override
  BillCategory build(BillCategory initialCategory) => initialCategory;

  void select(BillCategory category) => state = category;
}
