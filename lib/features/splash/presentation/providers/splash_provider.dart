import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../config/app_constants.dart';
import '../../../../config/app_keys.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../routes/app_routes.dart';

part 'splash_provider.g.dart';

@riverpod
Future<String> splashTimer(Ref ref) async {
  await Future.delayed(AppConstants.splashDuration);

  final storage = getIt<LocalStorageService>();
  final hasOnboarded = await storage.getBool(AppKeys.prefOnboardingSeen);
  if (hasOnboarded) return AppRoutes.home;

  await storage.setBool(AppKeys.prefOnboardingSeen, true);
  return AppRoutes.signIn;
}
