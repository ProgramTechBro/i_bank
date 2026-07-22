import 'balance_history_point_entity.dart';
import 'transaction_entity.dart';

class TransactionReportEntity {
  final String cardHolderName;
  final String cardNickname;
  final String maskedCardNumber;
  final double balance;
  final double chartBalance;
  final List<BalanceHistoryPointEntity> balanceHistory;
  final List<TransactionEntity> transactions;

  const TransactionReportEntity({
    required this.cardHolderName,
    required this.cardNickname,
    required this.maskedCardNumber,
    required this.balance,
    required this.chartBalance,
    required this.balanceHistory,
    required this.transactions,
  });
}
