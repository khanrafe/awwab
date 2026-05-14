# Development Standards

## Naming Conventions
- Files: `snake_case.dart`
- Classes/enums/extensions: `PascalCase`
- Variables/methods: `camelCase`
- Constants: lowerCamelCase inside `abstract final` constant classes

## Widget Conventions
- Screen widgets: `*Screen`
- Reusable composition widgets: `*Section`, `*Card`, `*Tile`, `*Button`
- Keep widgets small and focused; split large build methods.

## Layering Rules
- `features/`: feature-centric modules and presentation/state for that feature.
- `shared/`: shared feature components only when truly cross-feature.
- `services/`: external service integrations (networking, notifications, analytics).
- `data/`: repositories/data sources/entities mapping.
- `core/`: framework-wide concerns (environment, base abstractions, utilities used globally).

## Code Quality Gates
- `flutter analyze` must pass.
- `flutter test` must pass.
- No debug prints in committed code.
- No hardcoded API keys, paths, or credentials.

## Git Rules
- Never commit generated caches or build artifacts.
- Keep commits focused and atomic.
- Rebase/sync feature branches frequently with `main`.
