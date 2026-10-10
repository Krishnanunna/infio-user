# InFio — User App

A Flutter app for **InFio**, a hyperlocal service marketplace. Customers browse
service categories, search local businesses, request quotes, compare the quotes
they receive, and book a job.

The UI is built from the Stitch design export kept in [design_reference/](design_reference/):
15 folders, one per screen, each holding a `screen.png` mockup and the `code.html`
Stitch generated for it. The 16th folder is the design system — the shared
glassmorphism look is specified in
[design_reference/hyperlocal_glass_modern/DESIGN.md](design_reference/hyperlocal_glass_modern/DESIGN.md),
whose tokens are mirrored 1:1 in [lib/theme/](lib/theme/).

> **Scope:** this is a UI + navigation prototype. All content is local mock data in
> [lib/data/mock_data.dart](lib/data/mock_data.dart) — there is no backend, and
> login/OTP simulate success without authenticating anything.

## Prerequisites

| Tool | Version |
| --- | --- |
| Flutter SDK | 3.38.7 stable (or newer) |
| Dart SDK | 3.10.7 — the pubspec requires `^3.10.7`, so this is the floor |

Dart ships with Flutter, so installing Flutter is enough. Follow the
[official install guide](https://docs.flutter.dev/get-started/install) for your OS,
then confirm your toolchain:

```bash
flutter --version
flutter doctor
```

`flutter doctor` must show a green check for whichever platform you intend to run
on. Common extras it will ask for:

- **Android** — Android Studio, an SDK platform, and `flutter doctor --android-licenses`
- **iOS / macOS** — Xcode plus `sudo xcodebuild -runFirstLaunch` and CocoaPods (`sudo gem install cocoapods`)
- **Web** — Chrome
- **Linux / Windows desktop** — the native toolchain for that OS

## Setup

```bash
git clone https://github.com/Krishnanunna/infio-user.git
cd infio-user
flutter pub get
```

`flutter pub get` is the only setup step — there is no codegen, no `.env`, and no
API keys to configure. Fonts are fetched at runtime by
[`google_fonts`](https://pub.dev/packages/google_fonts), so the first launch needs
network access; after that they are cached.

## Running the app

List the devices Flutter can see, then run on one:

```bash
flutter devices
flutter run                      # default device
flutter run -d chrome            # web
flutter run -d macos             # macOS desktop
flutter run -d <device-id>       # a specific simulator / emulator / phone
```

All six platforms are scaffolded: `android`, `ios`, `web`, `macos`, `linux`,
`windows`. The layout is phone-first — on wide targets (web and desktop)
[`ResponsivePhoneFrame`](lib/widgets/responsive_phone_frame.dart) wraps the app in a
centered phone-sized frame, so it is meant to look like a phone, not stretch.

While `flutter run` is attached: `r` hot-reloads, `R` hot-restarts, `q` quits.

### Tests and static analysis

```bash
flutter test
flutter analyze
```

Linting is [`flutter_lints`](https://pub.dev/packages/flutter_lints), configured in
[analysis_options.yaml](analysis_options.yaml).

### Release builds

```bash
flutter build apk --release        # Android
flutter build ipa --release        # iOS
flutter build web --release        # web
flutter build macos --release      # macOS
```

## Navigation map

Routing is [`go_router`](https://pub.dev/packages/go_router), declared in
[lib/router/app_router.dart](lib/router/app_router.dart). The four bottom-nav tabs
live under a `StatefulShellRoute.indexedStack`, so each tab keeps its own state.

| Route | Screen |
| --- | --- |
| `/splash` | [splash_screen.dart](lib/screens/splash/splash_screen.dart) |
| `/onboarding` | [landing_screen.dart](lib/screens/onboarding/landing_screen.dart) |
| `/login` | [login_screen.dart](lib/screens/auth/login_screen.dart) |
| `/otp` | [otp_screen.dart](lib/screens/auth/otp_screen.dart) |
| `/home` | **Tab 1** — [home_screen.dart](lib/screens/home/home_screen.dart) |
| `/categories` | **Tab 2** — reuses [search_results_screen.dart](lib/screens/search/search_results_screen.dart) |
| `/orders` | **Tab 3** — [quotes_hub_screen.dart](lib/screens/quotes/quotes_hub_screen.dart) |
| `/profile` | **Tab 4** — [profile_screen.dart](lib/screens/profile/profile_screen.dart) |
| `/search` | [search_results_screen.dart](lib/screens/search/search_results_screen.dart) |
| `/business/:id` | [business_profile_screen.dart](lib/screens/business/business_profile_screen.dart) |
| `/booking/step1` → `step2` → `step3` | Get-a-quote flow, [lib/screens/booking/](lib/screens/booking/) |
| `/quotes/:requestId/available` | [available_quotes_screen.dart](lib/screens/quotes/available_quotes_screen.dart) |
| `/quotes/:requestId/compare` | [quote_comparison_screen.dart](lib/screens/quotes/quote_comparison_screen.dart) |

The happy path runs end to end: splash → onboarding → login → OTP → home →
search → business profile → booking (3 steps) → available quotes → comparison.

## Project layout

```
lib/
├── main.dart            app entry — MaterialApp.router
├── router/              go_router config and the tab shell
├── screens/             one folder per feature area
├── widgets/             shared UI: GlassContainer, GlassAppBar,
│                        AppBottomNavBar, GradientButton, AppLogo, …
├── theme/               colors, text styles, spacing, ThemeData
├── models/              Business, Quote, QuoteRequest, ServiceCategory
└── data/mock_data.dart  all sample content
```

## Gotchas worth knowing before you change things

- **Don't reintroduce a variable icon font.** Icons use Flutter's built-in `Icons`
  class (`_outlined` variants) on purpose. The release-build icon tree-shaker drops
  or corrupts glyphs from `material_symbols_icons`' *variable* font files even when
  every icon is referenced directly, and the usual literal-`Icon(...)` warmup
  workaround does not help. If such a package ever comes back, expect blank icons in
  release and profile builds unless you also pass `--no-tree-shake-icons`.
- **Guard 3-button `Expanded` rows.** A `Row` of several
  `Expanded(child: …Button.icon(…))` collapses into unreadable circular buttons with
  character-wrapped labels at phone width. The existing ones (search results'
  Call/WhatsApp/View, quote comparison's Reject/Call/Accept) set explicit
  `minimumSize`/padding plus `softWrap: false` and `overflow: ellipsis` on the label
  — copy that pattern for any new one.
- **Known cosmetic gap on web:** the login screen's Telugu and Hindi language chips
  render as tofu boxes, because CanvasKit will not fall back to system fonts for
  scripts Inter doesn't cover and no Devanagari/Telugu font asset is bundled. Native
  builds do fall back to platform fonts, so this is expected to affect web only.
