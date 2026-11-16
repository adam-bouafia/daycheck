# DayCheck

A small daycare check-in/check-out demo app, built to practice Flutter with
Riverpod and an MVVM architecture from the start.

This is an original project. It is not affiliated with, based on, or copied
from any specific company's app or source code. The feature (a parent or
staff member checking a child in or out, and a log of today's check-ins and
check-outs) is a generic daycare administration problem, built from scratch.

## What it does

- A roster of children, each showing whether they are not arrived, present,
  or departed today.
- Tapping a child opens a sheet to check them in (who dropped them off) or
  out (who picked them up).
- A status is never set directly: it is always derived from the log of
  check-in/check-out events, so the log and the status can never disagree.
- A log screen lists every check-in and check-out for today.
- Everything is stored on the device (`shared_preferences`). There is no
  backend and no account, the same local-first choice as my other Flutter
  project, [MetJou](https://github.com/adam-bouafia/metjou).

## Architecture

Feature-first, layered inside each feature:

```
lib/
  core/theme/            shared theme
  features/roster/
    data/                  Model: Child, CheckEvent, the status rule, the
                            repository (SharedPreferences)
    presentation/
      roster_viewmodel.dart   ViewModel: a Riverpod Notifier holding the
                                roster and today's events
      roster_screen.dart      View: the roster list
      daily_log_screen.dart   View: today's events
      widgets/
        check_sheet.dart      View: the check-in/out form (its own local
                                state - who is picked, not shared elsewhere)
        child_tile.dart        View: one row in the roster
```

The repository is injected through a Riverpod provider
(`rosterRepositoryProvider`), so tests swap in an in-memory fake instead of
touching real device storage.

## Running it

```
flutter pub get
flutter run
```

## Tests

```
flutter test
```

Covers the status rule as pure logic, the ViewModel's behaviour with a fake
repository, and one widget test that drives the full check-in/check-out
flow and checks it shows up in the log.

## CI

`.github/workflows/ci.yml` runs `dart format`, `flutter analyze` and
`flutter test` on every push to `main` and every pull request.
