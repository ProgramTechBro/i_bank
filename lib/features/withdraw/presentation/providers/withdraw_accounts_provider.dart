import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/withdraw_account_entity.dart';
import '../../domain/usecases/get_withdraw_accounts_usecase.dart';

part 'withdraw_accounts_provider.g.dart';

@riverpod
Future<List<WithdrawAccountEntity>> withdrawAccounts(Ref ref) async {
  final useCase = getIt<GetWithdrawAccountsUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (accounts) => accounts);
}
