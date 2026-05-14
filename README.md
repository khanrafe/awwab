# Awwab

Production-ready Flutter foundation for long-term development with local-first data (Hive), scalable architecture, and future backend readiness.

## Stack
- Flutter (stable)
- State management: Riverpod
- Navigation: GoRouter
- Local storage: Hive
- Typography: Google Fonts
- Animation: flutter_animate
- Charts: fl_chart

## Flutter Requirements
- Flutter: `3.41.9` (stable) or newer stable in same major line
- Dart: `3.11.5` or compatible with the Flutter SDK above

Check your setup:
```bash
flutter --version
dart --version
```

## Setup
```bash
git clone https://github.com/khanrafe/awwab.git
cd awwab
flutter pub get
flutter analyze
flutter test
flutter run
```

## Project Structure
```text
lib/
  main.dart
  src/
    app.dart
    constants/
    core/
      environment/
    data/
    features/
      home/
        presentation/
    presentation/
    routes/
    services/
    shared/
    storage/
    theme/
    utils/
    widgets/
```

## Architecture Rules
- Keep UI in `features/*/presentation` and shared reusable widgets in `src/widgets`.
- Keep business logic/state in feature modules, avoid placing feature logic in global layers.
- Keep platform-agnostic contracts in `data`/`services`; wire implementations with dependency injection via Riverpod.
- Avoid hardcoded colors/spacing/typography; use centralized theme tokens.
- Use `snake_case` file names, `PascalCase` types, and suffix screens/widgets clearly (`*Screen`, `*Card`, `*Tile`).

## Git & Branch Workflow
- `main` stays releasable.
- Create feature branches: `feature/<short-name>`.
- Use fix branches: `fix/<short-name>`.
- Run before every PR:
```bash
flutter analyze
flutter test
```

Recommended commit style:
- `feat: add onboarding shell`
- `fix: handle null router redirect`
- `chore: update dependencies`

## Cross-Laptop Compatibility Notes
- Do not commit local SDK paths, signing files, or `.env` secrets.
- Keep `pubspec.lock` committed for app reproducibility.
- On a new MacBook, install Xcode + Android Studio CLIs, then run `flutter doctor` and resolve prompts.

## Manual Steps for Future Release Builds
- Configure Android signing (`.jks`/keystore) locally, not in Git.
- Configure iOS signing/capabilities in Xcode with your Apple team.
- Add environment-specific secrets via CI/CD or local env files excluded by `.gitignore`.
