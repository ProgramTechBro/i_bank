import 'package:injectable/injectable.dart';
import '../../../../../core/enums/transaction_category.dart';
import '../../../../../core/enums/transaction_direction.dart';
import '../../../../../core/enums/transaction_status.dart';
import '../../models/balance_history_point_model.dart';
import '../../models/transaction_model.dart';
import '../../models/transaction_report_model.dart';

abstract class TransactionReportLocalDatasource {
  Future<TransactionReportModel> getTransactionReport();
}

@LazySingleton(as: TransactionReportLocalDatasource)
class TransactionReportLocalDatasourceImpl
    implements TransactionReportLocalDatasource {
  @override
  Future<TransactionReportModel> getTransactionReport() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    return TransactionReportModel(
      cardHolderName: 'John Smith',
      cardNickname: 'Amazon Platinium',
      maskedCardNumber: '4756  ••••  ••••  9018',
      balance: 3469.52,
      chartBalance: 1000,
      balanceHistory: const [
        BalanceHistoryPointModel(month: 'Jan', value: 7),
        BalanceHistoryPointModel(month: 'Feb', value: 9),
        BalanceHistoryPointModel(month: 'Mar', value: 6),
        BalanceHistoryPointModel(month: 'Apr', value: 10),
        BalanceHistoryPointModel(month: 'May', value: 8),
        BalanceHistoryPointModel(month: 'Jun', value: 9),
      ],
      transactions: [
        TransactionModel(
          title: 'Water Bill',
          amount: 280,
          date: now,
          direction: TransactionDirection.reduction,
          category: TransactionCategory.water,
          status: TransactionStatus.unsuccessful,
        ),
        TransactionModel(
          title: 'Income: Salary Oct',
          amount: 1200,
          date: yesterday,
          direction: TransactionDirection.increase,
          category: TransactionCategory.salary,
        ),
        TransactionModel(
          title: 'Electric Bill',
          amount: 480,
          date: yesterday,
          direction: TransactionDirection.reduction,
          category: TransactionCategory.electricity,
          status: TransactionStatus.successful,
        ),
        TransactionModel(
          title: 'Income : Jane transfers',
          amount: 500,
          date: yesterday,
          direction: TransactionDirection.increase,
          category: TransactionCategory.transfer,
        ),
        TransactionModel(
          title: 'Internet Bill',
          amount: 100,
          date: yesterday,
          direction: TransactionDirection.reduction,
          category: TransactionCategory.internet,
          status: TransactionStatus.successful,
        ),
      ],
    );
  }
}
