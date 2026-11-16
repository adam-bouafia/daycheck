# Features

## Login

The app opens on a login screen. These test accounts are built in and
listed on the login screen, where a tap fills them in:

| Username | Password | Who | Child |
| --- | --- | --- | --- |
| sara | sara123 | Sara Bakker, staff | all |
| tim | tim123 | Tim Visser, staff | all |
| sanne | sanne123 | Sanne de Vries, parent | Mila |
| tom | tom123 | Tom de Vries, parent | Mila |
| lotte | lotte123 | Lotte Jansen, parent | Noah |
| amina | amina123 | Amina El Amrani, parent | Yusuf |
| karim | karim123 | Karim El Amrani, parent | Yusuf |

The session survives an app restart (only the username is stored).
Settings shows who is signed in and has Sign out. A real app would check
the password on a server and never ship it in the app.

## Two homes

Staff and parents do not share one screen with parts hidden. After login
each gets their own home with its own tabs:

| Staff (daycare) | Parent (family) |
| --- | --- |
| **Children**: attendance count (present, not arrived, picked up) and every child; tap to check in or out and post notes, photos and PDFs | **Today**: where their child is right now (dropped off at 08:12 by ...), today's hours, and everything staff shared today |
| **Log**: every check-in, check-out and note today | **Photos**: all photos of their children |
| **Requests**: approve or cancel, with a badge for pending ones | **Requests**: ask for leave or extra hours |
| **Notifications** | **Notifications**, only about their own children |

Notes are signed with the staff member who posted them, so parents see
"Note by Sara Bakker".

| | Staff | Parent |
| --- | --- | --- |
| Children shown | Every child | Only their own |
| Check in / check out | Yes | No |
| Add activity notes, photos, PDFs | Yes | No |
| Daily log across all children | Yes | No |
| Requests | Approve or cancel | Submit for their child |
| Notifications | All | Only about their own children |


## Roster and status

The roster lists every child with today's status: not arrived, present or
departed. The status is never stored. It is derived each time from the
log of check-in and check-out events, so the status and the log cannot
disagree.

## Check in and check out

Staff pick who dropped the child off or picked them up from the child's
guardians. The event records the person and the time, and the status
updates on the same frame.

## Activity notes, photos and PDFs

Staff post what a child did today. A note can carry:

- a **photo**, taken with the camera or picked from the gallery; the note
  text becomes its caption;
- a **PDF**, such as a form, a menu or a newsletter.

Parents see the note in their child's feed. A PDF opens in the phone's
own viewer, or can be shared or saved through the share sheet.

## Photo viewer

Tapping a photo, in the feed or in the gallery, opens it full screen:

- swipe left and right through all of that child's photos;
- pinch to zoom;
- the panel at the bottom shows the date and time it was taken, who
  posted it, and its description;
- tap the photo to hide the panel, or share the photo with its caption.

## Photo gallery

Every photo attached to a child's notes, newest first, with date and
caption under each one. The gallery is a filtered view of the same event
log as the feed, not a second store, so a photo in the log is always in
the gallery.

## Notifications

Every activity note and every request update creates an entry in the
in-app notification list:

- the bell in the roster shows the unread count;
- the list keeps every entry on the device, so swiping away a pop-up
  loses nothing;
- mark one or all as read;
- parents only see entries about their own children.

The same event can also show a pop-up on the phone. Settings has separate
switches for activity pop-ups and request pop-ups. Turning a pop-up off
never removes the entry from the list.

## Requests

A parent asks for **leave** (the child will be absent) or **extra hours**
on a date, with an optional note. Staff see every request and approve or
cancel it. The parent gets a notification for each decision.

A request has a status that changes over time (pending, then approved or
cancelled), so it is stored and updated in place. That is a deliberate
contrast with the event log, which only ever grows.

## Schedule calendar

A month view per child, with a dot on the days the child normally
attends and the hours for the selected day.

## Settings

- **Language**: follow the device, or pick one of nine languages. Each is
  shown in its own language so a parent can find theirs.
- **Appearance**: system, light or dark.
- **Reduce effects**: solid panels instead of blurred glass, for older
  phones.
- **Pop-ups**: separate switches for activity and request pop-ups.
- **Sign out**.

## Languages

Dutch, English, French, Polish, German, Turkish, Italian, Hebrew and
Arabic. Every string goes through Flutter's `gen-l10n` with typed
arguments and the plural rules of each language: Polish has separate
forms for 2-4 and 5+, Arabic has six forms, Hebrew has a dual. Hebrew
and Arabic flip the whole layout to right to left.

Notifications raised from a ViewModel, where there is no `BuildContext`,
use the language chosen in Settings too.

## Older phones

- Runs on Android 7.0 (API 24) and up, the lowest version Flutter
  supports. Every plugin in the app accepts that version.
- **Reduce effects** removes the backdrop blur, which is the most
  expensive thing the app draws, and draws the background shapes with
  cheap radial gradients instead of a full-screen blur.
- The setting also switches on by itself when the phone's high-contrast
  accessibility option is on.
- Photos in the feed and the gallery are decoded at the size they are
  shown, not at full camera resolution, which keeps memory low on phones
  with little RAM.

## Not built

- **Chat** between staff and parents is its own problem: delivery, read
  receipts, presence.
- **Admin**: billing, staff rosters and organisation settings are a third
  role.
- **Push between devices** needs a server. The pop-up shows the mechanism
  on one device; the in-app list is the part that would stay the same
  with a backend.
