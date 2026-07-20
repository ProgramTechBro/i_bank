import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository repository;
  const SignUpUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String name,
    required String phone,
    required String password,
  }) => repository.signUp(name: name, phone: phone, password: password);
}
