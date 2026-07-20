import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signIn({
    required String identifier,
    required String password,
  });

  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String phone,
    required String password,
  });

  Future<Either<Failure, Unit>> sendResetCode({required String phone});

  Future<Either<Failure, Unit>> verifyResetCode({required String code});

  Future<Either<Failure, Unit>> changePassword({required String newPassword});
}
