import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/home_dashboard_entity.dart';
import '../../domain/usecases/get_home_dashboard_usecase.dart';

part 'home_dashboard_provider.g.dart';

@riverpod
Future<HomeDashboardEntity> homeDashboard(Ref ref) async {
  final useCase = getIt<GetHomeDashboardUseCase>();
  final result = await useCase();
  return result.fold((failure) => throw failure, (dashboard) => dashboard);
}
