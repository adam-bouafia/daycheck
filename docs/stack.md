# Stack

| Area | Choice |
| --- | --- |
| Framework | Flutter 3.47.5, Dart 3 |
| State and DI | `flutter_riverpod` (`Notifier`, `Provider`, `FutureProvider`) |
| Storage | `shared_preferences` (JSON), app documents folder via `path_provider` |
| Photos | `image_picker` (camera or gallery, resized to 1600 px, quality 85) |
| PDFs | `file_picker` to pick, `open_filex` to open, `share_plus` to share or save |
| Notifications | `flutter_local_notifications` |
| Localization | `flutter_localizations`, `intl`, `gen-l10n` with ARB files |
| Tests | `flutter_test`, Riverpod overrides with in-memory fakes |
| CI | GitHub Actions: format, analyze, test, docs build |
| Docs | MkDocs with the Material theme |

## Why these packages

- **Riverpod** gives both state management and dependency injection with
  one tool. A provider can be overridden in a test without a mocking
  library or a service locator.
- **shared_preferences** is enough for a single-device demo and keeps the
  app free of a backend and an account. The repositories are the only
  code that knows about it, so swapping in an API client later changes
  the `data/` folders only.
- **gen-l10n** generates a typed method per string. A missing argument
  or a wrong type is a compile error, not a broken sentence on screen.
- **open_filex** hands a PDF to the phone's own viewer instead of
  bundling one, which keeps the app small.

## What is not used, on purpose

- No backend and no Firebase: everything stays on the device.
- No code generation for state (`riverpod_generator`, `freezed`): the
  models are small enough that hand-written `copyWith` and JSON are
  clearer.
- No mocking library: fakes implement the repository interfaces.
