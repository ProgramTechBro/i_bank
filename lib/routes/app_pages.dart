import 'package:go_router/go_router.dart';
import '../features/auth/presentation/change_password_screen.dart';
import '../features/auth/presentation/change_password_success_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/sign_in_screen.dart';
import '../features/auth/presentation/sign_up_screen.dart';
import '../features/branch_locator/presentation/branch_screen.dart';
import '../features/branch_locator/presentation/exchange_rate_screen.dart';
import '../features/branch_locator/presentation/interest_rate_screen.dart';
import '../features/credit_card/presentation/credit_card_pay_screen.dart';
import '../features/credit_card/presentation/credit_card_screen.dart';
import '../features/credit_card/presentation/credit_card_success_screen.dart';
import '../features/beneficiary/domain/entities/beneficiary_entity.dart';
import '../features/beneficiary/presentation/add_beneficiary_screen.dart';
import '../features/beneficiary/presentation/beneficiary_detail_screen.dart';
import '../features/beneficiary/presentation/beneficiary_screen.dart';
import '../features/branch_locator/presentation/search_screen.dart';
import '../features/exchange/presentation/exchange_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/mobile_prepaid/domain/entities/prepaid_recharge_entity.dart';
import '../features/mobile_prepaid/presentation/mobile_prepaid_confirm_screen.dart';
import '../features/mobile_prepaid/presentation/mobile_prepaid_screen.dart';
import '../features/mobile_prepaid/presentation/mobile_prepaid_success_screen.dart';
import '../features/pay_bill/domain/entities/payment_history_entry_entity.dart';
import '../features/pay_bill/presentation/bill_check_screen.dart';
import '../features/pay_bill/presentation/bill_pay_screen.dart';
import '../features/pay_bill/presentation/bill_payment_success_screen.dart';
import '../features/pay_bill/presentation/bill_receipt_screen.dart';
import '../features/pay_bill/presentation/pay_bill_screen.dart';
import '../features/pay_bill/presentation/payment_history_screen.dart';
import '../features/save_online/presentation/account_management_screen.dart';
import '../features/save_online/presentation/choose_card_screen.dart';
import '../features/save_online/presentation/save_online_add_screen.dart';
import '../features/save_online/presentation/save_online_screen.dart';
import '../features/save_online/presentation/save_online_success_screen.dart';
import '../features/settings/presentation/language_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/transfer/domain/entities/transfer_entity.dart';
import '../features/transfer/presentation/transfer_confirm_screen.dart';
import '../features/account_card/presentation/account_card_screen.dart';
import '../features/transaction_report/presentation/transaction_report_screen.dart';
import '../features/transfer/presentation/transfer_screen.dart';
import '../features/transfer/presentation/transfer_success_screen.dart';
import '../features/withdraw/presentation/withdraw_screen.dart';
import '../features/withdraw/presentation/withdraw_success_screen.dart';
import '../core/enums/bill_category.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.branch,
        builder: (context, state) => const BranchScreen(),
      ),
      GoRoute(
        path: AppRoutes.interestRate,
        builder: (context, state) => const InterestRateScreen(),
      ),
      GoRoute(
        path: AppRoutes.exchangeRate,
        builder: (context, state) => const ExchangeRateScreen(),
      ),
      GoRoute(
        path: AppRoutes.language,
        builder: (context, state) => const LanguageScreen(),
      ),
      GoRoute(
        path: AppRoutes.exchange,
        builder: (context, state) => const ExchangeScreen(),
      ),
      GoRoute(
        path: AppRoutes.transfer,
        builder: (context, state) => const TransferScreen(),
      ),
      GoRoute(
        path: AppRoutes.transferConfirm,
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return TransferConfirmScreen(
            transfer: extra['transfer'] as TransferEntity,
            fromMasked: extra['fromMasked'] as String,
            toName: extra['toName'] as String,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.transferSuccess,
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return TransferSuccessScreen(
            amount: extra['amount'] as double,
            toName: extra['toName'] as String,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.accountCard,
        builder: (context, state) => const AccountCardScreen(),
      ),
      GoRoute(
        path: AppRoutes.transactionReport,
        builder: (context, state) => const TransactionReportScreen(),
      ),
      GoRoute(
        path: AppRoutes.withdraw,
        builder: (context, state) => const WithdrawScreen(),
      ),
      GoRoute(
        path: AppRoutes.withdrawSuccess,
        builder: (context, state) => const WithdrawSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.payBill,
        builder: (context, state) => const PayBillScreen(),
      ),
      GoRoute(
        path: AppRoutes.paymentHistory,
        builder: (context, state) => PaymentHistoryScreen(
          initialCategory: state.extra! as BillCategory,
        ),
      ),
      GoRoute(
        path: AppRoutes.billReceipt,
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return BillReceiptScreen(
            category: extra['category'] as BillCategory,
            entry: extra['entry'] as PaymentHistoryEntryEntity,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.billCheck,
        builder: (context, state) =>
            BillCheckScreen(category: state.extra! as BillCategory),
      ),
      GoRoute(
        path: AppRoutes.billPay,
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return BillPayScreen(
            category: extra['category'] as BillCategory,
            companyName: extra['companyName'] as String,
            billCode: extra['billCode'] as String,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.billPaymentSuccess,
        builder: (context, state) =>
            BillPaymentSuccessScreen(category: state.extra! as BillCategory),
      ),
      GoRoute(
        path: AppRoutes.mobilePrepaid,
        builder: (context, state) => const MobilePrepaidScreen(),
      ),
      GoRoute(
        path: AppRoutes.mobilePrepaidConfirm,
        builder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return MobilePrepaidConfirmScreen(
            recharge: extra['recharge'] as PrepaidRechargeEntity,
            fromMasked: extra['fromMasked'] as String,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.mobilePrepaidSuccess,
        builder: (context, state) => const MobilePrepaidSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.saveOnline,
        builder: (context, state) => const SaveOnlineScreen(),
      ),
      GoRoute(
        path: AppRoutes.saveOnlineAdd,
        builder: (context, state) => const SaveOnlineAddScreen(),
      ),
      GoRoute(
        path: AppRoutes.saveOnlineChooseCard,
        builder: (context, state) => const ChooseCardScreen(),
      ),
      GoRoute(
        path: AppRoutes.saveOnlineManagement,
        builder: (context, state) => const AccountManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.saveOnlineSuccess,
        builder: (context, state) => const SaveOnlineSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.beneficiary,
        builder: (context, state) => const BeneficiaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.beneficiaryAdd,
        builder: (context, state) => const AddBeneficiaryScreen(),
      ),
      GoRoute(
        path: AppRoutes.beneficiaryDetail,
        builder: (context, state) => BeneficiaryDetailScreen(
          beneficiary: state.extra! as BeneficiaryEntity,
        ),
      ),
      GoRoute(
        path: AppRoutes.creditCard,
        builder: (context, state) => const CreditCardScreen(),
      ),
      GoRoute(
        path: AppRoutes.creditCardPay,
        builder: (context, state) => const CreditCardPayScreen(),
      ),
      GoRoute(
        path: AppRoutes.creditCardSuccess,
        builder: (context, state) => const CreditCardSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.changePasswordSuccess,
        builder: (context, state) => const ChangePasswordSuccessScreen(),
      ),
    ],
  );
}
