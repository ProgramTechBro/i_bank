import '../../domain/entities/user_card_entity.dart';

class UserCardModel extends UserCardEntity {
  const UserCardModel({
    required super.holderName,
    required super.nickname,
    required super.maskedNumber,
    required super.balance,
    required super.style,
  });
}
