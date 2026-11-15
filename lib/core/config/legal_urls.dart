/// Public legal document URLs (GitHub Pages).
abstract final class LegalUrls {
  /// Override at build time: `--dart-define=PRIVACY_POLICY_URL=https://...`
  static const privacyPolicy = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    /// After GitHub Pages deploy: `https://<user>.github.io/bondly-privacy/`
    defaultValue: 'https://quaeng27.github.io/bondly-privacy/',
  );

  static const privacyContactEmail = 'xfatihgunduz@gmail.com';
}