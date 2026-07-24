import 'package:flutter/material.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../enums/message_icon_type.dart';

extension MessageIconTypeX on MessageIconType {
  Color get backgroundColor {
    switch (this) {
      case MessageIconType.bankOfAmerica:
        return AppColors.primary;
      case MessageIconType.account:
        return AppColors.semanticError;
      case MessageIconType.alert:
        return AppColors.semanticInfo;
      case MessageIconType.paypal:
        return AppColors.semanticWarning;
      case MessageIconType.withdraw:
        return AppColors.semanticSuccess;
    }
  }

  String get iconAsset {
    switch (this) {
      case MessageIconType.bankOfAmerica:
        return AppIcons.messageBankOfAmerica;
      case MessageIconType.account:
        return AppIcons.messageAccount;
      case MessageIconType.alert:
        return AppIcons.messageAlert;
      case MessageIconType.paypal:
        return AppIcons.messagePaypal;
      case MessageIconType.withdraw:
        return AppIcons.messageWithdraw;
    }
  }
}
