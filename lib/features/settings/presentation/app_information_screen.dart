import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import 'local_widgets/setting_row.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  static const _entries = [
    (label: 'Date of manufacture', value: 'Dec 2019'),
    (label: 'Version', value: '9.0.2'),
    (label: 'Language', value: 'English'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final valueStyle = textTheme.titleSmall?.copyWith(
      color: AppColors.primary,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('App information')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('CaBank E-mobile Banking', style: textTheme.titleMedium),
            const SizedBox(height: 24),
            for (final entry in _entries)
              SettingRow(
                title: entry.label,
                value: entry.value,
                valueStyle: valueStyle,
              ),
          ],
        ),
      ),
    );
  }
}
