# DayCheck

A small daycare administration demo app, built to practice Flutter with
Riverpod and an MVVM architecture from the start.

This is an original project. It is not affiliated with, based on, or copied
from any specific company's app or source code. The feature set (checking a
child in/out, and staff sharing activity notes and photos with parents) is
a generic daycare administration problem, built from scratch.

## What it does

- A roster of children, each showing whether they are not arrived, present,
  or departed today.
- Tapping a child opens their detail screen: check them in (who dropped
  them off) or out (who picked them up), and a feed of today's activity.
- Staff can add an activity note with an optional photo — "played outside",
  a drawing, a drop-off photo — without it affecting whether the child is
  marked present.
- A status is never set directly: it is always derived from the log of
  check-in/check-out events, so the log and the status can never disagree.
  Activity notes are also events, but a different kind, and are excluded
  when deriving attendance.
- A log screen lists every check-in, check-out and activity note for today,
  across all children.
- Everything is stored on the device (`shared_preferences` for the log,
  the app's own documents folder for photos). There is no backend and no
  account, the same local-first choice as my other Flutter project,
  [MetJou](https://github.com/adam-bouafia/metjou).

## Architecture

Feature-first, layered inside each feature:

```
lib/
  core/theme/            shared theme
  features/roster/
    data/                  Model: Child, DayEvent (check-in/out or an
                            activity note), the status rule, the
                            repository (SharedPreferences + photos folder)
    presentation/
      roster_viewmodel.dart     ViewModel: a Riverpod Notifier holding the
                                  roster and today's events
      roster_screen.dart        View: the roster list
      child_detail_screen.dart  View: one child's status, actions and feed
      daily_log_screen.dart     View: every event today, across children
      widgets/
        check_sheet.dart        View: the check-in/out form (its own local
                                  state - who is picked, not shared elsewhere)
        add_note_sheet.dart     View: the activity-note form (text + photo)
        child_tile.dart         View: one row in the roster
```

The repository is injected through a Riverpod provider
(`rosterRepositoryProvider`), so tests swap in an in-memory fake instead of
touching real device storage or the file system. The photos folder is
resolved once through a cached `FutureProvider` (`photosFolderProvider`),
not re-resolved on every rebuild of a photo tile.

## What's deliberately not built

Real daycare apps (this one included, as a reference point) also handle
leave/absence/extra-hours requests with an approve/cancel workflow. That is
a genuinely different pattern from this app's event log — a request has a
state that transitions (requested → approved/cancelled) rather than an
append-only history — and was left out on purpose to keep this demo
finishable and coherent around one pattern, rather than half-building two.

## Running it

```
flutter pub get
flutter run
```

## Tests

```
flutter test
```

Covers the status rule as pure logic (including that activity notes don't
affect attendance), the ViewModel's behaviour with a fake repository
(check-in, check-out, activity notes with and without a photo), and widget
tests that drive the full check-in/check-out and add-note flows end to end.

## CI

`.github/workflows/ci.yml` runs `dart format`, `flutter analyze` and
`flutter test` on every push to `main` and every pull request.
