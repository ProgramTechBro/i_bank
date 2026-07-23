import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/pay_bill_repository.dart';
import '../entities/bill_company_entity.dart';

@injectable
class GetBillCompaniesUseCase {
  final PayBillRepository repository;
  const GetBillCompaniesUseCase(this.repository);

  Future<Either<Failure, List<BillCompanyEntity>>> call() =>
      repository.getCompanies();
}
