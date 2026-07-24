# iBank

A pixel-perfect Flutter recreation of the **iBank – Premium Bank & Wallet App** Figma UI kit for fintech / digital banking.

This is a **UI-only** project: every screen is built end-to-end with production-grade architecture, but all data is served by local fake datasources instead of a real backend. The goal is a fully navigable, visually accurate banking app that can be wired to a real API later by swapping a single layer per feature.

## Tech stack

- **Flutter** with **Riverpod** (`flutter_riverpod` + `riverpod_annotation`, code-generated via `riverpod_generator`) for all state management
- **Clean Architecture** per feature — `domain` / `data` / `presentation`
- **`get_it` + `injectable`** for dependency injection
- **`go_router`** for declarative navigation
- **`dartz`** (`Either<Failure, T>`) for error handling
- **`freezed`** for immutable state classes
- **`flutter_svg`** for icon/illustration assets
- **Poppins** as the single app-wide font family

## Architecture

Every feature under `lib/features/<feature>/` follows the same three-layer structure:

```
<feature>/
├── domain/
│   ├── entities/        # Plain Dart models, no framework dependencies
│   └── usecases/        # One class per action, injected with @injectable
├── data/
│   ├── models/          # Entity subclasses used for (de)serialization
│   ├── datasources/
│   │   └── local/        # Fake datasource returning dummy data — the only
│   │                      # layer that will be swapped for a real API later
│   ├── repo/             # Abstract repository contract
│   └── repo_impl/        # Repository implementation (@LazySingleton)
└── presentation/
    ├── providers/         # Riverpod providers / notifiers + freezed state
    ├── local_widgets/     # Screen-specific widgets, extracted once a screen
    │                       # crosses ~200–250 lines or 4+ nesting levels
    └── *_screen.dart      # The actual pages
```

**Why this shape:** the UI, providers, and use cases never talk to dummy data directly — they only depend on the repository *interface*. When a real backend is ready, only the `data/datasources/local/*` implementation gets replaced with a remote one; nothing in `domain` or `presentation` changes.

### Shared building blocks

| Location | Purpose |
|---|---|
| `lib/config/app_colors.dart` | The single source of truth for every color used in the app |
| `lib/config/app_typography.dart` + `lib/config/theme/` | Text styles, wired into Flutter's `TextTheme` (`Theme.of(context).textTheme`) |
| `lib/config/app_assets.dart` | Every SVG icon / illustration path, grouped as `AppImages`, `AppIcons`, `AppNetworkImages` |
| `lib/core/enums/` | Cross-feature enums (e.g. `BankCardStyle`, `TransactionType`, `BillCategory`) |
| `lib/core/extensions/` | Enum-to-UI mapping extensions (icon, color, label per enum case) |
| `lib/core/shared_widgets/` | Components reused identically across ≥2 features (`AppButton`, `AppBankCard`, `AppTextField`, `AppBottomNavBar`, `AppConfirmInfoField`, `AppTouchIdDialog`, …) |
| `lib/core/di/injector.dart` | `get_it` service locator, populated by `injectable`'s generated config |
| `lib/routes/app_routes.dart` + `app_pages.dart` | Route path constants and the `GoRouter` route table |

Widgets and enums are only promoted to `core/` once a second feature needs the *exact* same behavior — each feature otherwise owns its own dummy entities, even when conceptually similar to another feature's (e.g. Withdraw, Account & Card, and Save Online each keep independent card/account entities).

### Navigation shell

`lib/features/main/presentation/main_screen.dart` hosts the persistent bottom navigation bar. It keeps `Home`, `Search`, `Message`, and `Setting` alive in an `IndexedStack`, switching between them purely by updating a Riverpod index provider — no route transition, no rebuild, no flicker. Every other screen in the app is pushed on top of this shell via `go_router`.

## Features

| Module | What it covers |
|---|---|
| **Auth** | Sign in, sign up, forgot password, change password (+ success) |
| **Home** | Dashboard with primary bank card and the quick-actions grid |
| **Account & Card** | Account list and card list tabs, reused across other features' "choose card" flows |
| **Transfer** | Beneficiary-style transfer form → OTP + Touch ID confirm → success |
| **Withdraw** | Cardless withdrawal with account picker → success |
| **Mobile Prepaid** | Beneficiary/account/amount selection → OTP + Touch ID confirm → success |
| **Pay Bill** | Bill category browsing, bill check, payment history, ticket-style receipt, OTP pay flow |
| **Save Online** | Time-deposit creation (reusing the Account & Card "choose card" UI), account management list |
| **Credit Card** | Card overview with transaction history, pay-off flow with account picker + OTP, success |
| **Transaction Report** | Grouped, chart-backed transaction history over a bank card |
| **Beneficiary** | Grouped beneficiary directory (card / same bank / other bank), add & detail flows |
| **Message** | Notification-style message list; the "Bank of America" thread opens a live two-way chat with auto-highlighted codes |
| **Settings** | Profile header, navigable settings list, and a static App Information screen |
| **Branch Locator / Search** | Branch, interest rate, and exchange rate search entry points |

Every flow above follows the same rules: values are pre-filled through the repository layer (never hardcoded in a screen), buttons stay visually primary-colored and are functionally gated via `onPressed: null`, and any state used by ≥2 widgets on a screen lives in a Riverpod notifier — `setState` is never used where Riverpod already owns the state.

## Running the project

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

The `build_runner` step regenerates `*.g.dart` (Riverpod), `*.freezed.dart` (Freezed state), and `injector.config.dart` (Injectable DI) — required after pulling changes or adding new providers/use cases.

## Project status

All core banking flows from the Figma design have been implemented pixel-for-pixel with dummy data. There is no backend integration yet — every `*_local_datasource.dart` is the intended seam for connecting a real API.
