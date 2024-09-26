import 'package:flutter/material.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/ulti/function.dart';
import 'package:provider/provider.dart';
import '../../../../generated/l10n.dart';

class GoogleUserWidget extends StatefulWidget {
  const GoogleUserWidget({super.key});

  @override
  State<GoogleUserWidget> createState() => _GoogleUserWidgetState();
}

class _GoogleUserWidgetState extends State<GoogleUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BackupProvider>(
      builder: (context, backupProvider, _) {
        return InkWell(
          onTap: backupProvider.currentUser == null
              ? () {
            backupProvider.googleSignIn();
          }
              : null,
          child: Row(
            children: [
              backupProvider.currentUser == null
                  ? Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Assets.image.drive.svg(
                    width: 50, height: 50, fit: BoxFit.cover),
              )
                  : CircleAvatar(
                radius: 36,
                backgroundImage:
                NetworkImage(backupProvider.currentUser?.photoUrl ?? ''),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      backupProvider.currentUser == null
                          ? S.of(context).backup_to_google_drive
                          : backupProvider.currentUser?.displayName ?? '',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      backupProvider.currentUser == null
                          ? S.of(context).tap_to_connect_account
                          : backupProvider.currentUser?.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              if (backupProvider.currentUser != null)
                IconButton(
                  onPressed: () {
                    showConfirmationDialog(context,
                        icon: Assets.image.logout.svg(
                            width: 40, height: 40),
                        title: S.of(context).logout,
                        content: S.of(context).logout_confirmation,
                        confirm: S.of(context).logout_confirm
                    ).then((confirm) {
                      if (confirm == true) {
                        backupProvider.googleSignOut();
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
