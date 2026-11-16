# User feedback

Before building, I read public Play Store and App Store reviews of
daycare apps in the Netherlands. The same complaints come back over
several years. Several of them are not one-off bugs: they come from how
the app's state is structured. This page maps each one to what DayCheck
does.

| Complaint in reviews | Likely cause | DayCheck |
| --- | --- | --- |
| The app shows last week until you refresh or clear its data | Screens read a cache that nothing invalidates | Every screen watches its ViewModel with `ref.watch`. When state changes, the screen rebuilds. There is no refresh button because nothing can go stale. |
| A photo is in the log but missing from Media | Two stores (log and media index) that should agree | One store. A photo is a field on the event; the gallery is a filtered view of the log. |
| You can't tell when a gallery photo was taken | The gallery and the timeline are separate surfaces | The photo viewer shows date, time, author and description on every photo, and the gallery shows date and caption under each tile. |
| Notifications only as pop-ups; nothing to look back at | Notifications are not stored in the app | An in-app list with unread count, mark as read, and per-child filtering for parents. |
| Too many pop-ups | One switch for everything, or none | Separate pop-up switches for activities and requests. The in-app list always gets the entry. |
| Documents can't be opened | No attachment support | PDFs attach to an activity note and open in the phone's viewer or share from the feed. |
| Language follows the phone only; missing or broken translations ("changed a one # diaper") | Strings built by hand | Nine languages, chosen in the app, through `gen-l10n` with the plural rules of each language. |
| One-click absence reporting is praised | | Leave and extra-hours requests with approve or cancel, and a notification for each decision. |
| Slow or broken on older Android phones | Heavy effects, large images | Android 7.0 and up, a reduce-effects mode, and thumbnail-size decoding. |

## What this does not claim

Real apps also fail for reasons a single-device demo does not have:
networks, servers, and the range of Android devices. The point is
narrower: several of the most repeated complaints map onto decisions
that can be made right from the start, in the shape of the state, rather
than fixed one bug at a time.

Push notifications between two phones need a server. DayCheck shows the
local mechanism and keeps every notification in the in-app list, which
is the part that would stay the same with a backend.
