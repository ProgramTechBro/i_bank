import 'package:flutter/material.dart';
import '../enums/transaction_type.dart';

extension TransactionTypeExtension on TransactionType {
  String get beneficiaryGroupLabel {
    switch (this) {
      case TransactionType.cardNumber:
        return 'Transfer via card number';
      case TransactionType.sameBank:
        return 'Transfer to the same bank';
      case TransactionType.otherBank:
        return 'Transfer to another bank';
    }
  }

  String get shortLabel {
    switch (this) {
      case TransactionType.cardNumber:
        return 'Transfer via\ncard number';
      case TransactionType.sameBank:
        return 'Transfer to\nthe same bank';
      case TransactionType.otherBank:
        return 'Transfer to\nanother bank';
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.cardNumber:
        return Icons.credit_card;
      case TransactionType.sameBank:
        return Icons.person_outline;
      case TransactionType.otherBank:
        return Icons.account_balance_outlined;
    }
  }
}
