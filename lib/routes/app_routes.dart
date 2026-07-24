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
  static const String transactionReport = '/transaction-report';
  static const String accountCard = '/account-card';
  static const String payBill = '/pay-bill';
  static const String paymentHistory = '/pay-bill/history';
  static const String billReceipt = '/pay-bill/receipt';
  static const String billCheck = '/pay-bill/check';
  static const String billPay = '/pay-bill/pay';
  static const String billPaymentSuccess = '/pay-bill/success';
  static const String mobilePrepaid = '/mobile-prepaid';
  static const String mobilePrepaidConfirm = '/mobile-prepaid/confirm';
  static const String mobilePrepaidSuccess = '/mobile-prepaid/success';
  static const String saveOnline = '/save-online';
  static const String saveOnlineAdd = '/save-online/add';
  static const String saveOnlineChooseCard = '/save-online/choose-card';
  static const String saveOnlineManagement = '/save-online/management';
  static const String beneficiary = '/beneficiary';
  static const String beneficiaryAdd = '/beneficiary/add';
  static const String beneficiaryDetail = '/beneficiary/detail';
  static const String saveOnlineSuccess = '/save-online/success';
  static const String creditCard = '/credit-card';
  static const String creditCardPay = '/credit-card/pay';
  static const String creditCardSuccess = '/credit-card/success';
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
