# DayCheck

A daycare administration app in Flutter, built with Riverpod and an MVVM
architecture from the start. Staff check children in and out and share
the day with parents; parents follow along, get notified, and send leave
or extra-hours requests.

Full documentation (architecture, features, design, stack):
`docs/`, built with MkDocs. Preview it with `docs/serve.sh`.

## What it does

- **Roster**: every child with today's status (not arrived, present,
  departed), derived from the log of check-in/check-out events, never
  stored separately.
- **Check in / check out**: records who dropped the child off or picked
  them up, and when.
- **Activity notes**: staff post what a child did, with an optional photo
  (the note is its caption) and an optional PDF (a form, a menu, a
  newsletter). Parents open the PDF in their own viewer or share it.
- **Photo viewer**: tap any photo, in the feed or the gallery, for a
  full-screen view. Swipe between photos, pinch to zoom, and read when it
  was taken, by whom, and its description.
- **Photo gallery** per child, built from the same event log as the feed,
  so a photo in the log is always in the gallery too.
- **Notifications inside the app**: a bell with an unread count opens a
  list of every activity and request update, kept on the device, so
  nothing is lost when a pop-up is swiped away. Parents only see entries
  about their own children.
- **Pop-ups you control**: Settings has separate switches for activity
  and request pop-ups; the in-app list gets every entry either way.
- **Requests**: a parent asks for leave or extra hours on a date; staff
  approve or cancel. Every decision lands in the parent's notifications.
- **Schedule calendar** per child: a month view with the days they attend
  and the hours for the selected day.
- **Login with test accounts** (2 staff, 5 parents; listed on the login
  screen). The session survives an app restart; only the username is
  stored.
- **Two separate apps in one**: staff get the daycare home (attendance
  count, every child, check in/out, post notes, photos and PDFs, the day's
  log, approve requests). Parents get the family home (where their child
  is right now, today's feed, photos, their requests). Not one screen
  with parts hidden.
- **Nine languages**: Dutch, English, French, Polish, German, Turkish,
  Italian, Hebrew and Arabic, switchable in the app. Hebrew and Arabic
  lay the whole app out right to left.
- **Light, dark or system theme**, glassmorphism in both.
- **Older phones**: runs on Android 7.0 (API 24) and up, the lowest
  Flutter supports. A "Reduce effects" switch replaces the blurred glass
  with solid panels, and photos decode at thumbnail size in lists.
- **Local first**: everything is stored on the device. No backend and no
  account, the same choice as my other Flutter app,
  [MetJou](https://github.com/adam-bouafia/metjou).

## Architecture

Feature-first, with MVVM inside each feature: `data/` is the Model,
`*_viewmodel.dart` is the ViewModel (a Riverpod `Notifier`), and screens
and widgets are the View (`ConsumerWidget`).

```text
lib/
  main.dart              MaterialApp: theme, locale and effects from Settings
  core/
    theme/               Catppuccin Latte (light) and Mocha (dark)
    widgets/glass.dart   GlassPanel, GlassBackground, GlassEffects
    localization/        context.l10n, strings for code with no context
    notifications/       local pop-up notifications
  l10n/                  app_<lang>.arb for nine languages + generated code
  features/
    roster/              children, events, schedules, photos, PDFs
      data/              Child, DayEvent, Schedule, status rule, repository
      presentation/      roster, child detail, daily log, calendar,
                         gallery, photo viewer, and their ViewModel
    requests/            leave and extra-hours requests
    inbox/               the in-app notification list
    settings/            language, theme, pop-ups, reduce effects
    session/             test accounts, login, the saved session
    home/                staff home and parent home (bottom tabs), the
                         gate that picks one after login
```

Every repository is injected through a Riverpod provider, so tests swap
in in-memory fakes and never touch device storage or the file system.

## Why these choices

Public Play Store reviews of daycare apps repeat the same complaints for
years. Several of them come from the shape of the app, not from one bug:

| Complaint | DayCheck's answer |
| --- | --- |
| The app shows old data until you refresh or clear its data | Every screen watches its ViewModel; when state changes the screen rebuilds. There is no refresh button because nothing can go stale |
| A photo is in the log but missing from Media | One store: the photo is a field on the event in the log, and the gallery is a filtered view of that same log |
| You can't see when a gallery photo was taken | The photo viewer shows date, time, author and caption on every photo |
| Notifications only exist as pop-ups, or are noisy | An in-app notification list with unread count and mark-all-read, plus separate pop-up switches per kind |
| Documents can't be opened in the app | PDFs attach to an activity note and open or share from the feed |
| Missing or broken translations ("changed a one # diaper") | Nine languages through Flutter's `gen-l10n`, with real plural rules per language (Polish, Arabic and Hebrew have more than two forms) |
| Slow on older phones | Android 7.0 and up, a reduce-effects mode, and thumbnail-size image decoding |

Push notifications between two phones need a server, which this
single-device demo doesn't have. The local notification shows the
mechanism; the in-app list is the part that would stay the same with a
backend behind it.

## Not built

**Chat** between staff and parents is its own problem (delivery, read
receipts, presence). **Admin** (billing, staff rosters, organisation
settings) is a third role, not modelled here.

## Running it

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

49 tests: login (wrong password, saved session), the status and schedule rules as pure logic, every ViewModel
with fake repositories (check-in/out, notes with photos and PDFs,
requests, inbox, settings), the pop-up switches, language fallback,
widget tests that log in as staff and as a parent and drive each home, and rendering in Dutch,
Arabic and Hebrew (including right-to-left layout).

## CI

`.github/workflows/ci.yml` runs `dart format`, `flutter analyze` and
`flutter test`, and builds the documentation with `mkdocs build --strict`,
on every push to `main` and every pull request.
