import 'package:dartz/dartz.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/bill_company_entity.dart';
import '../../domain/entities/bill_details_entity.dart';
import '../../domain/entities/payment_history_entry_entity.dart';

abstract class PayBillRepository {
  Future<Either<Failure, List<BillCompanyEntity>>> getCompanies();

  Future<Either<Failure, List<PaymentHistoryEntryEntity>>> getPaymentHistory(
    BillCategory category,
  );

  Future<Either<Failure, BillDetailsEntity>> getBillDetails({
    required BillCategory category,
    required String companyName,
    required String billCode,
  });

  Future<Either<Failure, Unit>> submitPayment();
}
