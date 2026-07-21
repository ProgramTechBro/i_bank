import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/branch_entity.dart';
import '../../domain/usecases/get_branches_usecase.dart';

part 'branches_provider.g.dart';

@riverpod
Future<List<BranchEntity>> branches(Ref ref) async {
  final useCase = getIt<GetBranchesUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (branches) => branches);
}

@riverpod
class BranchSearchQuery extends _$BranchSearchQuery {
  @override
  String build() => 'Bank';

  void update(String value) => state = value;
}

@riverpod
List<BranchEntity> filteredBranches(Ref ref) {
  final query = ref.watch(branchSearchQueryProvider).trim().toLowerCase();
  final branchesAsync = ref.watch(branchesProvider);

  return branchesAsync.maybeWhen(
    data: (branches) => query.isEmpty
        ? branches
        : branches
              .where((branch) => branch.name.toLowerCase().contains(query))
              .toList(),
    orElse: () => const [],
  );
}
