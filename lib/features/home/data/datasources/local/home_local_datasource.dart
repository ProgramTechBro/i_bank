import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/home_dashboard_model.dart';

abstract class HomeLocalDatasource {
  Future<HomeDashboardModel> getDashboard();
}

@LazySingleton(as: HomeLocalDatasource)
class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  @override
  Future<HomeDashboardModel> getDashboard() async {
    return const HomeDashboardModel(
      userName: 'Push Puttichai',
      avatarUrl: AppNetworkImages.currentUserAvatar,
      cardHolderName: 'John Smith',
      cardNickname: 'Amazon Platinium',
      maskedCardNumber: '4756  ••••  ••••  9018',
      balance: 3469.52,
    );
  }
}
