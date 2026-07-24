import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/credit_card_account_entity.dart';
import '../../domain/entities/credit_card_overview_entity.dart';
import '../datasources/local/credit_card_local_datasource.dart';
import '../repo/credit_card_repository.dart';

@LazySingleton(as: CreditCardRepository)
class CreditCardRepositoryImpl implements CreditCardRepository {
  final CreditCardLocalDatasource localDatasource;
  const CreditCardRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, CreditCardOverviewEntity>> getOverview() async {
    try {
      final card = await localDatasource.getCard();
      final transactions = await localDatasource.getTransactions();
      final total = await localDatasource.getTotal();
      return Right(
        CreditCardOverviewEntity(
          card: card,
          transactions: transactions,
          total: total,
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CreditCardAccountEntity>>> getAccounts() async {
    try {
      final accounts = await localDatasource.getAccounts();
      return Right(accounts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitPayment({
    required String accountNumber,
    required String otp,
  }) async {
    try {
      await localDatasource.submitPayment(accountNumber: accountNumber, otp: otp);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
