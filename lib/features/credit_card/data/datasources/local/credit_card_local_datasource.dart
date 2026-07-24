import 'package:injectable/injectable.dart';
import '../../../../../core/enums/bank_card_style.dart';
import '../../models/credit_card_account_model.dart';
import '../../models/credit_card_model.dart';
import '../../models/credit_card_transaction_model.dart';

abstract class CreditCardLocalDatasource {
  Future<CreditCardModel> getCard();

  Future<List<CreditCardTransactionModel>> getTransactions();

  Future<double> getTotal();

  Future<List<CreditCardAccountModel>> getAccounts();

  Future<void> submitPayment({
    required String accountNumber,
    required String otp,
  });
}

@LazySingleton(as: CreditCardLocalDatasource)
class CreditCardLocalDatasourceImpl implements CreditCardLocalDatasource {
  @override
  Future<CreditCardModel> getCard() async {
    return const CreditCardModel(
      holderName: 'John Smith',
      nickname: 'Amazon Platinium',
      maskedNumber: '4756  ••••  ••••  9018',
      balance: 3469.52,
      style: BankCardStyle.blue,
    );
  }

  @override
  Future<List<CreditCardTransactionModel>> getTransactions() async {
    final date = DateTime(2018, 11, 2);
    return [
      CreditCardTransactionModel(title: 'Buy Camera', date: date, amount: 1200),
      CreditCardTransactionModel(
        title: 'Buy Television',
        date: date,
        amount: 1200,
      ),
      CreditCardTransactionModel(title: 'Buy Camera', date: date, amount: 1200),
      CreditCardTransactionModel(
        title: 'Buy Television',
        date: date,
        amount: 1200,
      ),
    ];
  }

  @override
  Future<double> getTotal() async => 3100;

  @override
  Future<List<CreditCardAccountModel>> getAccounts() async {
    return const [
      CreditCardAccountModel(maskedNumber: '1900 8988 5456'),
      CreditCardAccountModel(maskedNumber: '1900 8112 5222'),
      CreditCardAccountModel(maskedNumber: '4411 0000 1234'),
      CreditCardAccountModel(maskedNumber: '1900 7345 2210'),
      CreditCardAccountModel(maskedNumber: '1900 4482 9931'),
    ];
  }

  @override
  Future<void> submitPayment({
    required String accountNumber,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
