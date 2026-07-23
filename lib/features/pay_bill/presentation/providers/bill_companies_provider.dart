import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/bill_company_entity.dart';
import '../../domain/usecases/get_bill_companies_usecase.dart';

part 'bill_companies_provider.g.dart';

@riverpod
Future<List<BillCompanyEntity>> billCompanies(Ref ref) async {
  final useCase = getIt<GetBillCompaniesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (companies) => companies);
}
