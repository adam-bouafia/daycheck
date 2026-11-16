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
  across all children (staff only — see below).
- Everything is stored on the device (`shared_preferences` for the log,
  the app's own documents folder for photos). There is no backend and no
  account, the same local-first choice as my other Flutter project,
  [MetJou](https://github.com/adam-bouafia/metjou).

## Two roles, not one

Real daycare apps in this domain (this one included, as a reference point)
ship as two separate apps: one for staff, one for parents. DayCheck models
that distinction with a lightweight sign-in instead of building two apps:

- **Staff** see every child, can check any child in or out (recording who
  dropped off or picked up), and can add activity notes with photos.
- **Parent** picks their own name and sees only their own child or
  children, read-only: no check-in/out, no add-note, no cross-family
  daily log.

The sign-in (`features/session/`) is a deliberate demo stand-in for real
authentication — no password, nothing persisted, just enough to gate what
the roster and child detail screen show and allow, the way a real login
would. "Admin" (billing, staff scheduling, org settings) is a different
concern again and isn't modelled here.

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
      roster_screen.dart        View: the roster list, filtered by role
      child_detail_screen.dart  View: one child's status, actions and feed
      daily_log_screen.dart     View: every event today, across children
      widgets/
        check_sheet.dart        View: the check-in/out form (its own local
                                  state - who is picked, not shared elsewhere)
        add_note_sheet.dart     View: the activity-note form (text + photo)
        child_tile.dart         View: one row in the roster
  features/session/
    data/role.dart             Model: Role (staff or parent)
    presentation/
      session_viewmodel.dart   ViewModel: who is signed in, and as whom
      sign_in_screen.dart      View: pick a role (demo stand-in for login)
```

The repository is injected through a Riverpod provider
(`rosterRepositoryProvider`), so tests swap in an in-memory fake instead of
touching real device storage or the file system. The photos folder is
resolved once through a cached `FutureProvider` (`photosFolderProvider`),
not re-resolved on every rebuild of a photo tile.

## Why these choices (checked against real user feedback)

Public Play Store reviews for a comparable daycare app (read for research,
not copied from) repeat a handful of complaints across several years.
Several of them are symptoms of architecture, not one-off bugs, and
DayCheck's design avoids that exact class of problem by construction:

| Repeated complaint | Why it happens | How DayCheck avoids it |
| --- | --- | --- |
| "Stuck on last week," app needs a manual refresh or clearing local data to show new activity | The View doesn't automatically react to new data; something stale is cached and nothing tells the UI to re-read it | Every View uses `ref.watch` on the ViewModel's state. There's no refresh button anywhere, because there's nothing to refresh — the state changes, the View rebuilds, same frame |
| "I see in the log that a photo was added, but it doesn't show under Media" | Two separate stores (an activity log and a media index) that are supposed to agree, and don't | There's only one store: a photo is a field on the same `DayEvent` that's already in the log. If the event exists, the photo is right there with it — not a second thing that can drift out of sync |
| Same icon for chat and messages; no way to tell when a gallery photo was taken without opening the timeline | Content is split across separate surfaces (a chat screen, a media gallery, a timeline) that don't share context | One per-child feed: status, check-ins, check-outs and notes-with-photos are all the same list, same timestamps, nothing split out |
| Language locked to the phone's locale, missing translations, broken templated strings ("changed a one # diaper") | String interpolation done by hand instead of through a real localization system | Not yet relevant to DayCheck (English only so far), but this is exactly the discipline already in my other Flutter project — [MetJou](https://github.com/adam-bouafia/metjou) ships 5 languages through Flutter's `gen-l10n`, with typed arguments, not string concatenation |
| No push notifications, reported for years | Out of scope for a local-only demo | Would carry over the same approach MetJou already uses (`flutter_local_notifications`) if this grew a background component |

What this table does *not* claim: that DayCheck is a finished product, or
that these are the only reasons a real app has reliability problems
(network conditions, server-side bugs and platform fragmentation matter
too, and the Android-specifically-buggier-than-iOS/web complaints in those
reviews point at exactly that). The point is narrower: a few of the most
repeated complaints map cleanly onto decisions this demo happened to get
right, and that's worth knowing before assuming every bug is "fix it in
QA" rather than "fix the shape of the state."

One review also specifically praised one-click absence reporting — which
lines up with the leave/absence/extra-hours request workflow below, left
out of this demo on purpose rather than by oversight.

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
