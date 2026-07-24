import '../../domain/entities/credit_card_entity.dart';

class CreditCardModel extends CreditCardEntity {
  const CreditCardModel({
    required super.holderName,
    required super.nickname,
    required super.maskedNumber,
    required super.balance,
    required super.style,
  });
}
