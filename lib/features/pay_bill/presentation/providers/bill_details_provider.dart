import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/bill_category.dart';
import '../../domain/entities/bill_details_entity.dart';
import '../../domain/usecases/get_bill_details_usecase.dart';

part 'bill_details_provider.g.dart';

@riverpod
Future<BillDetailsEntity> billDetails(Ref ref, BillCategory category) async {
  final useCase = getIt<GetBillDetailsUseCase>();
  final result = await useCase(
    category: category,
    companyName: '',
    billCode: '',
  );
  return result.fold((failure) => throw failure, (details) => details);
}
