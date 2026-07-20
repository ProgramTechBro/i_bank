import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../config/app_constants.dart';

part 'splash_provider.g.dart';

@riverpod
Future<void> splashTimer(Ref ref) async {
  await Future.delayed(AppConstants.splashDuration);
}
