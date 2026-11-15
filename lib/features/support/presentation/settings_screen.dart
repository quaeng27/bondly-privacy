import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/bootstrap.dart';
import '../../../core/config/legal_urls.dart';
import '../../../core/design/sync_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/support/store_review_prompt_service.dart';
import 'feedback_sheet.dart';
import 'help_center_sheet.dart';

/// Support hub — help center, feedback, and quick links.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.bootstrap});

  final AppBootstrap bootstrap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final review = bootstrap.storeReviewPromptService;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(SyncSpacing.lg),
        children: [
          Text(
            'Support',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: SyncColors.textSecondary,
            ),
          ),
          const SizedBox(height: SyncSpacing.sm),
          _SettingsTile(
            icon: Icons.menu_book_rounded,
            title: 'Help Center & FAQ',
            subtitle: 'Widgets, pairing, notifications, vault',
            onTap: () => HelpCenterSheet.show(context),
          ),
          _SettingsTile(
            icon: Icons.bug_report_rounded,
            title: 'Report a bug',
            subtitle: 'Send feedback with device diagnostics',
            onTap: () => FeedbackSheet.show(context, bootstrap: bootstrap),
          ),
          const SizedBox(height: SyncSpacing.lg),
          Text(
            l10n.accountRecoverySection,
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: SyncColors.textSecondary,
            ),
          ),
          const SizedBox(height: SyncSpacing.sm),
          _SettingsTile(
            icon: Icons.shield_moon_rounded,
            title: l10n.accountRecoveryTitle,
            subtitle: l10n.accountRecoverySettingsSubtitle,
            onTap: () => context.push('/settings/account-recovery'),
          ),
          const SizedBox(height: SyncSpacing.lg),
          Text(
            'About',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: SyncColors.textSecondary,
            ),
          ),
          const SizedBox(height: SyncSpacing.sm),
          _SettingsTile(
            icon: Icons.star_rate_rounded,
            title: 'Enjoying Bondly?',
            subtitle:
                'Review prompts appear after streaks, touches, and countdown wins (${review.promptsThisYear}/${StoreReviewPromptService.maxPromptsPerYear} this year)',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'We only ask during your best Bondly moments — never during paywalls or errors.',
                  ),
                ),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: LegalUrls.privacyContactEmail,
            onTap: () async {
              final uri = Uri.parse(LegalUrls.privacyPolicy);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LegalUrls.privacyPolicy)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: SyncSpacing.sm),
      child: ListTile(
        leading: Icon(icon, color: SyncColors.neonCyan),
        title: Text(
          title,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: SyncColors.textSecondary,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
