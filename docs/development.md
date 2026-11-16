# Development

## Run

```bash
flutter pub get
flutter run
```

The demo starts with three children and their schedules. Sign in as
staff to act, or as a parent to see one family's view.

## Test

```bash
flutter test
```

46 tests:

- the status rule and the schedule rule as pure functions;
- every ViewModel with in-memory fakes: check-in and check-out, notes
  with photos and PDFs, requests, inbox, settings;
- the pop-up switches (pop-up off, inbox entry still created) and the
  notification language following Settings;
- language fallback to English for unsupported device languages;
- widget tests for the full staff and parent flows, the calendar and the
  gallery;
- rendering in Dutch, Arabic and Hebrew, including right-to-left layout.

## Continuous integration

`.github/workflows/ci.yml` runs on every push to `main` and on every pull
request:

1. `dart format --set-exit-if-changed`
2. `flutter analyze`
3. `flutter test`
4. `mkdocs build --strict` for this documentation

## Add a language

1. Copy `lib/l10n/app_en.arb` to `lib/l10n/app_<code>.arb` and set
   `"@@locale"`.
2. Translate every value. Keep the `{placeholders}`, and give plurals
   the forms that language needs.
3. Run `flutter gen-l10n` (or `flutter pub get`).
4. Add `('<code>', '<name in that language>')` to `appLanguages` in
   `features/settings/data/app_settings.dart`.

A test checks that the language picker and the shipped translations
match, so a language cannot be half added.

## Documentation

```bash
docs/serve.sh          # preview on http://127.0.0.1:8000
docs/serve.sh build    # strict build into site/
```

The script creates its own virtual environment in `docs/.venv`.
