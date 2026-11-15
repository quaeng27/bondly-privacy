# Bondly privacy policy (GitHub Pages)

## URL after publish

`https://<github-username>.github.io/<repo-name>/`  
(this workflow publishes the contents of `docs/privacy/` as the site root)

If the repo is **`bondly-privacy`**, the policy is:

`https://<github-username>.github.io/bondly-privacy/`

Set the same URL in:

- App Store Connect → Privacy Policy URL  
- Google Play Console → Privacy policy  
- `LegalUrls.privacyPolicy` in `lib/core/config/legal_urls.dart` (or `--dart-define=PRIVACY_POLICY_URL=...`)

## One-time GitHub setup

1. Create a **public** repo (e.g. `bondly-privacy`) on GitHub.
2. Push this folder’s parent project (or only `docs/privacy` in a minimal repo).
3. **Settings → Pages → Build and deployment → GitHub Actions** (not “Deploy from branch”).
4. Push to `main` — workflow `privacy-pages.yml` deploys `docs/privacy/index.html`.

## Contact

Privacy contact: `xfatihgunduz@gmail.com` (also shown in-app under Settings → Privacy Policy).