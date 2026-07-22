import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/home';
  static const String search = '/search';
  static const String branch = '/search/branch';
  static const String interestRate = '/search/interest-rate';
  static const String exchangeRate = '/search/exchange-rate';
  static const String language = '/language';
  static const String exchange = '/exchange';
  static const String transfer = '/transfer';
  static const String transferConfirm = '/transfer/confirm';
  static const String transferSuccess = '/transfer/success';
  static const String withdraw = '/withdraw';
  static const String withdrawSuccess = '/withdraw/success';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String changePasswordSuccess = '/change-password/success';

  static const List<String> _tabRoutes = [home, search];

  static void goToTab(BuildContext context, int index) {
    if (index >= _tabRoutes.length) return;
    context.go(_tabRoutes[index]);
  }
}
