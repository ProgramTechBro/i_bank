import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_assets.dart';
import '../../../routes/app_routes.dart';
import 'local_widgets/save_online_list_tile.dart';

class SaveOnlineScreen extends StatelessWidget {
  const SaveOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Save online')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SaveOnlineListTile(
              title: 'Add',
              subtitle: 'Add new save online account',
              iconAsset: AppIcons.saveOnlineAdd,
              onTap: () => context.push(AppRoutes.saveOnlineAdd),
            ),
            const SizedBox(height: 16),
            SaveOnlineListTile(
              title: 'Management',
              subtitle: 'Manage your save online account',
              iconAsset: AppIcons.saveOnlineManagement,
              onTap: () => context.push(AppRoutes.saveOnlineManagement),
            ),
          ],
        ),
      ),
    );
  }
}
