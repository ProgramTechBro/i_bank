import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bill_check_form_provider.g.dart';

@riverpod
class BillCheckForm extends _$BillCheckForm {
  @override
  int? build() => null;

  void selectCompany(int index) => state = index;
}
