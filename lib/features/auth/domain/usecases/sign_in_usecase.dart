import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository repository;
  const SignInUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String identifier,
    required String password,
  }) => repository.signIn(identifier: identifier, password: password);
}
