import '../../domain/entities/home_dashboard_entity.dart';

class HomeDashboardModel extends HomeDashboardEntity {
  const HomeDashboardModel({
    required super.userName,
    required super.avatarUrl,
    required super.cardHolderName,
    required super.cardNickname,
    required super.maskedCardNumber,
    required super.balance,
  });
}
