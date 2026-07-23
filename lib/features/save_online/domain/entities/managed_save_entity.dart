class ManagedSaveEntity {
  final String accountNumber;
  final DateTime fromDate;
  final DateTime toDate;
  final int depositMonths;
  final double interestRate;

  const ManagedSaveEntity({
    required this.accountNumber,
    required this.fromDate,
    required this.toDate,
    required this.depositMonths,
    required this.interestRate,
  });
}
