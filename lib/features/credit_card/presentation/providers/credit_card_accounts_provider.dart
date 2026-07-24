import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/credit_card_account_entity.dart';
import '../../domain/usecases/get_credit_card_accounts_usecase.dart';

part 'credit_card_accounts_provider.g.dart';

@riverpod
Future<List<CreditCardAccountEntity>> creditCardAccounts(Ref ref) async {
  final useCase = getIt<GetCreditCardAccountsUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (accounts) => accounts);
}
