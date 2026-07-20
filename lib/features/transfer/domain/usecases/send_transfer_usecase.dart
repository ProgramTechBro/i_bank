import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/transfer_repository.dart';

@injectable
class SendTransferUseCase {
  final TransferRepository repository;
  const SendTransferUseCase(this.repository);

  Future<Either<Failure, Unit>> call() => repository.sendTransfer();
}
