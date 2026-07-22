import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_card_tab_provider.g.dart';

@riverpod
class AccountCardTabIndex extends _$AccountCardTabIndex {
  @override
  int build() => 0;

  void select(int index) => state = index;
}
