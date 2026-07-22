import '../../../../core/enums/bank_card_style.dart';

class UserCardEntity {
  final String holderName;
  final String nickname;
  final String maskedNumber;
  final double balance;
  final BankCardStyle style;

  const UserCardEntity({
    required this.holderName,
    required this.nickname,
    required this.maskedNumber,
    required this.balance,
    required this.style,
  });
}
