import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/usecases/get_beneficiaries_usecase.dart';

part 'beneficiaries_provider.g.dart';

@riverpod
Future<List<BeneficiaryEntity>> beneficiaries(Ref ref) async {
  final useCase = getIt<GetBeneficiariesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (beneficiaries) => beneficiaries);
}
