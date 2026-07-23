import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/bill_company_entity.dart';
import '../../domain/entities/bill_details_entity.dart';
import '../../domain/entities/payment_history_entry_entity.dart';
import '../datasources/local/pay_bill_local_datasource.dart';
import '../repo/pay_bill_repository.dart';

@LazySingleton(as: PayBillRepository)
class PayBillRepositoryImpl implements PayBillRepository {
  final PayBillLocalDatasource localDatasource;
  const PayBillRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<BillCompanyEntity>>> getCompanies() async {
    try {
      final companies = await localDatasource.getCompanies();
      return Right(companies);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PaymentHistoryEntryEntity>>> getPaymentHistory(
    BillCategory category,
  ) async {
    try {
      final history = await localDatasource.getPaymentHistory(category);
      return Right(history);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, BillDetailsEntity>> getBillDetails({
    required BillCategory category,
    required String companyName,
    required String billCode,
  }) async {
    try {
      final details = await localDatasource.getBillDetails(
        category: category,
        companyName: companyName,
        billCode: billCode,
      );
      return Right(details);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitPayment() async {
    try {
      await localDatasource.submitPayment();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
