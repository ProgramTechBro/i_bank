import '../../domain/entities/time_deposit_option_entity.dart';

class TimeDepositOptionModel extends TimeDepositOptionEntity {
  const TimeDepositOptionModel({
    required super.months,
    required super.interestRate,
  });
}
