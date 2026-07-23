import '../../config/app_assets.dart';
import '../enums/bill_category.dart';

extension BillCategoryExtension on BillCategory {
  String get title {
    switch (this) {
      case BillCategory.electric:
        return 'Electric bill';
      case BillCategory.water:
        return 'Water bill';
      case BillCategory.mobile:
        return 'Mobile bill';
      case BillCategory.internet:
        return 'Internet bill';
    }
  }

  String get subtitle {
    switch (this) {
      case BillCategory.electric:
        return 'Pay electric bill this month';
      case BillCategory.water:
        return 'Pay water bill this month';
      case BillCategory.mobile:
        return 'Pay mobile bill this month';
      case BillCategory.internet:
        return 'Pay internet bill this month';
    }
  }

  String get tabLabel {
    switch (this) {
      case BillCategory.electric:
        return 'Electric';
      case BillCategory.water:
        return 'Water';
      case BillCategory.mobile:
        return 'Mobile';
      case BillCategory.internet:
        return 'Internet';
    }
  }

  String get feeLabel {
    switch (this) {
      case BillCategory.electric:
        return 'Electric fee';
      case BillCategory.water:
        return 'Water fee';
      case BillCategory.mobile:
        return 'Mobile fee';
      case BillCategory.internet:
        return 'Internet fee';
    }
  }

  String get illustrationAsset {
    switch (this) {
      case BillCategory.electric:
        return AppImages.payBillElectric;
      case BillCategory.water:
        return AppImages.payBillWater;
      case BillCategory.mobile:
        return AppImages.payBillMobile;
      case BillCategory.internet:
        return AppImages.payBillInternet;
    }
  }
}
