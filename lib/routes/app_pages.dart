import 'package:go_router/go_router.dart';
import '../features/auth/presentation/change_password_screen.dart';
import '../features/auth/presentation/change_password_success_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/sign_in_screen.dart';
import '../features/auth/presentation/sign_up_screen.dart';
import '../features/branch_locator/presentation/branch_screen.dart';
import '../features/branch_locator/presentation/exchange_rate_screen.dart';
import '../features/branch_locator/presentation/interest_rate_screen.dart';
import '../features/branch_locator/presentation/search_screen.dart';
import '../features/exchange/presentation/exchange_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/settings/presentation/language_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/transfer/domain/entities/transfer_entity.dart';
import '../features/transfer/presentation/transfer_confirm_screen.dart';
import '../features/transfer/presentation/transfer_screen.dart';
import '../features/transfer/presentation/transfer_success_screen.dart';
import '../features/withdraw/presentation/withdraw_screen.dart';
import '../features/withdraw/presentation/withdraw_success_screen.dart';
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
        path: AppRoutes.withdraw,
        builder: (context, state) => const WithdrawScreen(),
      ),
      GoRoute(
        path: AppRoutes.withdrawSuccess,
        builder: (context, state) => const WithdrawSuccessScreen(),
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
