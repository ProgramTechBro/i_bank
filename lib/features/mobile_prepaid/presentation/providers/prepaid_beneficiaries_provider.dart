import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/prepaid_beneficiary_entity.dart';
import '../../domain/usecases/get_prepaid_beneficiaries_usecase.dart';

part 'prepaid_beneficiaries_provider.g.dart';

@riverpod
Future<List<PrepaidBeneficiaryEntity>> prepaidBeneficiaries(Ref ref) async {
  final useCase = getIt<GetPrepaidBeneficiariesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (beneficiaries) => beneficiaries);
}
