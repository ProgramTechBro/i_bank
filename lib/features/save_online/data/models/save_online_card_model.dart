import '../../domain/entities/save_online_card_entity.dart';

class SaveOnlineCardModel extends SaveOnlineCardEntity {
  const SaveOnlineCardModel({
    required super.holderName,
    required super.nickname,
    required super.maskedNumber,
    required super.balance,
    required super.style,
  });
}
