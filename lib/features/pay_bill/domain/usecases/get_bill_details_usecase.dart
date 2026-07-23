import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/enums/bill_category.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/pay_bill_repository.dart';
import '../entities/bill_details_entity.dart';

@injectable
class GetBillDetailsUseCase {
  final PayBillRepository repository;
  const GetBillDetailsUseCase(this.repository);

  Future<Either<Failure, BillDetailsEntity>> call({
    required BillCategory category,
    required String companyName,
    required String billCode,
  }) => repository.getBillDetails(
    category: category,
    companyName: companyName,
    billCode: billCode,
  );
}
