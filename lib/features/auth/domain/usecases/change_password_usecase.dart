import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepository repository;
  const ChangePasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String newPassword}) =>
      repository.changePassword(newPassword: newPassword);
}
