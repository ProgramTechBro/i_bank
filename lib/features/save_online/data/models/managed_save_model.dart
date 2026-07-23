import '../../domain/entities/managed_save_entity.dart';

class ManagedSaveModel extends ManagedSaveEntity {
  const ManagedSaveModel({
    required super.accountNumber,
    required super.fromDate,
    required super.toDate,
    required super.depositMonths,
    required super.interestRate,
  });
}
