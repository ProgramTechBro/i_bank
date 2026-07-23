import '../../domain/entities/bill_details_entity.dart';

class BillDetailsModel extends BillDetailsEntity {
  const BillDetailsModel({
    required super.name,
    required super.address,
    required super.phoneNumber,
    required super.code,
    required super.fromDate,
    required super.toDate,
    required super.fee,
    required super.tax,
  });
}
