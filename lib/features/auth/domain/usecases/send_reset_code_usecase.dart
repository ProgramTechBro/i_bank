import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class SendResetCodeUseCase {
  final AuthRepository repository;
  const SendResetCodeUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String phone}) =>
      repository.sendResetCode(phone: phone);
}
