import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/usecases/get_accounts_usecase.dart';

part 'accounts_provider.g.dart';

@riverpod
Future<List<AccountEntity>> accounts(Ref ref) async {
  final useCase = getIt<GetAccountsUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (accounts) => accounts);
}
