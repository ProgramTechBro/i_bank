import '../../../../core/enums/bank_card_style.dart';

class SaveOnlineCardEntity {
  final String holderName;
  final String nickname;
  final String maskedNumber;
  final double balance;
  final BankCardStyle style;

  const SaveOnlineCardEntity({
    required this.holderName,
    required this.nickname,
    required this.maskedNumber,
    required this.balance,
    required this.style,
  });
}
