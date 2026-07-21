import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import 'local_widgets/branch_list_item.dart';
import 'local_widgets/branch_search_field.dart';
import 'providers/branches_provider.dart';

class BranchScreen extends ConsumerStatefulWidget {
  const BranchScreen({super.key});

  @override
  ConsumerState<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends ConsumerState<BranchScreen> {
  late final _searchController = TextEditingController(
    text: ref.read(branchSearchQueryProvider),
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    ref.read(branchSearchQueryProvider.notifier).update(value);
  }

  @override
  Widget build(BuildContext context) {
    final filteredBranches = ref.watch(filteredBranchesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Branch')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppImages.branchMap, fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.55,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: AppColors.cardShadowNeutral,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: BranchSearchField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                    ),
                  ),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: filteredBranches.length,
                      separatorBuilder: (_, _) =>
                          const Divider(color: AppColors.neutral200, height: 1),
                      itemBuilder: (context, index) =>
                          BranchListItem(branch: filteredBranches[index]),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
