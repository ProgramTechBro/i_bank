import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepository repository;
  const VerifyResetCodeUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String code}) =>
      repository.verifyResetCode(code: code);
}
