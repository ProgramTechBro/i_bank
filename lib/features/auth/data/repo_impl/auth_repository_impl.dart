import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../repo/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource localDatasource;
  const AuthRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, Unit>> signIn({
    required String identifier,
    required String password,
  }) => _run(
    () => localDatasource.signIn(identifier: identifier, password: password),
  );

  @override
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String phone,
    required String password,
  }) => _run(
    () => localDatasource.signUp(
      name: name,
      phone: phone,
      password: password,
    ),
  );

  @override
  Future<Either<Failure, Unit>> sendResetCode({required String phone}) =>
      _run(() => localDatasource.sendResetCode(phone: phone));

  @override
  Future<Either<Failure, Unit>> verifyResetCode({required String code}) =>
      _run(() => localDatasource.verifyResetCode(code: code));

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String newPassword,
  }) => _run(
    () => localDatasource.changePassword(newPassword: newPassword),
  );

  Future<Either<Failure, Unit>> _run(Future<void> Function() action) async {
    try {
      await action();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
