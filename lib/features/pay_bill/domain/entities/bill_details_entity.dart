class BillDetailsEntity {
  final String name;
  final String address;
  final String phoneNumber;
  final String code;
  final DateTime fromDate;
  final DateTime toDate;
  final double fee;
  final double tax;

  const BillDetailsEntity({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.code,
    required this.fromDate,
    required this.toDate,
    required this.fee,
    required this.tax,
  });

  double get total => fee + tax;
}
