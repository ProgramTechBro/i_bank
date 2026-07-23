import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/enums/bill_category.dart';
import '../../../core/extensions/bill_category_extension.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/bill_company_picker_dialog.dart';
import 'local_widgets/bill_dropdown_field.dart';
import 'providers/bill_check_form_provider.dart';
import 'providers/bill_companies_provider.dart';

class BillCheckScreen extends ConsumerStatefulWidget {
  const BillCheckScreen({super.key, required this.category});

  final BillCategory category;

  @override
  ConsumerState<BillCheckScreen> createState() => _BillCheckScreenState();
}

class _BillCheckScreenState extends ConsumerState<BillCheckScreen> {
  final _billCodeController = TextEditingController();

  @override
  void dispose() {
    _billCodeController.dispose();
    super.dispose();
  }

  Future<void> _pickCompany() async {
    final companies = ref.read(billCompaniesProvider).valueOrNull;
    if (companies == null) return;
    final index = await BillCompanyPickerDialog.show(
      context,
      companies: companies,
    );
    if (index == null || !mounted) return;
    ref.read(billCheckFormProvider.notifier).selectCompany(index);
  }

  void _onCheck() {
    final companies = ref.read(billCompaniesProvider).valueOrNull ?? [];
    final selectedIndex = ref.read(billCheckFormProvider);
    final companyName = selectedIndex != null
        ? companies[selectedIndex].name
        : '';

    context.push(
      AppRoutes.billPay,
      extra: {
        'category': widget.category,
        'companyName': companyName,
        'billCode': _billCodeController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final companiesAsync = ref.watch(billCompaniesProvider);
    final selectedIndex = ref.watch(billCheckFormProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pay the bill')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            companiesAsync.when(
              data: (companies) => BillDropdownField(
                value: selectedIndex != null
                    ? companies[selectedIndex].name
                    : null,
                placeholder: 'Choose company',
                onTap: _pickCompany,
              ),
              loading: () => const SizedBox(height: 44),
              error: (error, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _billCodeController,
              label: 'Type ${widget.category.tabLabel.toLowerCase()} bill code',
              hintText: 'Bill code',
              suffixIcon: Icons.confirmation_number_outlined,
            ),
            const SizedBox(height: 12),
            Text(
              'Please enter the correct bill code to check information.',
              style: textTheme.bodySmall?.copyWith(color: AppColors.neutral500),
            ),
            const SizedBox(height: 24),
            AppButton(label: 'Check', onPressed: _onCheck),
          ],
        ),
      ),
    );
  }
}
