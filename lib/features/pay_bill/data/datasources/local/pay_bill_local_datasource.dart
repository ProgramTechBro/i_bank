import 'package:injectable/injectable.dart';
import '../../../../../core/enums/bill_category.dart';
import '../../../../../core/enums/transaction_status.dart';
import '../../models/bill_company_model.dart';
import '../../models/bill_details_model.dart';
import '../../models/payment_history_entry_model.dart';

abstract class PayBillLocalDatasource {
  Future<List<BillCompanyModel>> getCompanies();

  Future<List<PaymentHistoryEntryModel>> getPaymentHistory(
    BillCategory category,
  );

  Future<BillDetailsModel> getBillDetails({
    required BillCategory category,
    required String companyName,
    required String billCode,
  });

  Future<void> submitPayment();
}

@LazySingleton(as: PayBillLocalDatasource)
class PayBillLocalDatasourceImpl implements PayBillLocalDatasource {
  static const _months = [
    'October',
    'September',
    'August',
    'July',
    'June',
    'May',
  ];

  @override
  Future<List<BillCompanyModel>> getCompanies() async {
    return const [
      BillCompanyModel(id: '1', name: 'IESCO'),
      BillCompanyModel(id: '2', name: 'LESCO'),
      BillCompanyModel(id: '3', name: 'SNGPL'),
      BillCompanyModel(id: '4', name: 'PTCL'),
      BillCompanyModel(id: '5', name: 'NADRA'),
    ];
  }

  @override
  Future<List<PaymentHistoryEntryModel>> getPaymentHistory(
    BillCategory category,
  ) async {
    final amount = switch (category) {
      BillCategory.electric => 480.0,
      BillCategory.water => 280.0,
      BillCategory.mobile => 150.0,
      BillCategory.internet => 50.0,
    };
    final company = category == BillCategory.internet ? 'Capi Telecom' : null;

    return List.generate(_months.length, (index) {
      return PaymentHistoryEntryModel(
        month: _months[index],
        date: DateTime(2019, 10 - index, 30),
        status: index == 0
            ? TransactionStatus.unsuccessful
            : TransactionStatus.successful,
        amount: amount,
        company: company,
      );
    });
  }

  @override
  Future<BillDetailsModel> getBillDetails({
    required BillCategory category,
    required String companyName,
    required String billCode,
  }) async {
    return BillDetailsModel(
      name: 'Jackson Maine',
      address: '403 East 4th Street, Santa Ana',
      phoneNumber: '+8424599721',
      code: '#2343543',
      fromDate: DateTime(2019, 10, 1),
      toDate: DateTime(2019, 11, 1),
      fee: 50,
      tax: 10,
    );
  }

  @override
  Future<void> submitPayment() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
