import '../../domain/entities/transaction_report_entity.dart';
import 'balance_history_point_model.dart';
import 'transaction_model.dart';

class TransactionReportModel extends TransactionReportEntity {
  const TransactionReportModel({
    required super.cardHolderName,
    required super.cardNickname,
    required super.maskedCardNumber,
    required super.balance,
    required super.chartBalance,
    required List<BalanceHistoryPointModel> super.balanceHistory,
    required List<TransactionModel> super.transactions,
  });
}
