import 'package:injectable/injectable.dart';

abstract class AuthLocalDatasource {
  Future<void> signIn({required String identifier, required String password});

  Future<void> signUp({
    required String name,
    required String phone,
    required String password,
  });

  Future<void> sendResetCode({required String phone});

  Future<void> verifyResetCode({required String code});

  Future<void> changePassword({required String newPassword});
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const _simulatedDelay = Duration(seconds: 1);

  @override
  Future<void> signIn({
    required String identifier,
    required String password,
  }) async {
    await Future.delayed(_simulatedDelay);
  }

  @override
  Future<void> signUp({
    required String name,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(_simulatedDelay);
  }

  @override
  Future<void> sendResetCode({required String phone}) async {
    await Future.delayed(_simulatedDelay);
  }

  @override
  Future<void> verifyResetCode({required String code}) async {
    await Future.delayed(_simulatedDelay);
  }

  @override
  Future<void> changePassword({required String newPassword}) async {
    await Future.delayed(_simulatedDelay);
  }
}
