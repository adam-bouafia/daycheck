import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/schedule.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

String _formatMinutes(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';

/// One child's weekly schedule as a month calendar: a dot on days they
/// normally attend, and the hours for whichever day is selected. Reads
/// the same [Schedule] data the roster loads, not a separate store.
class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key, required this.child});

  final Child child;

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _visibleMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );
  DateTime _selected = DateTime.now();

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final scheme = Theme.of(context).colorScheme;
    final schedule = ref
        .watch(rosterViewModelProvider)
        .scheduleOf(widget.child.id);

    final firstOfMonth = DateTime(_visibleMonth.year, _visibleMonth.month, 1);
    final daysInMonth = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    // Monday-first grid: how many blanks before day 1.
    final leadingBlanks = firstOfMonth.weekday - 1;

    final scheduledToday = schedule?.isScheduledOn(_selected) ?? false;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${l10n.scheduleTitle} · ${widget.child.name}'),
      ),
      body: GlassBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GlassPanel(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: () => _changeMonth(-1),
                          ),
                          Text(
                            DateFormat.yMMMM(locale).format(_visibleMonth),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () => _changeMonth(1),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          for (var i = 1; i <= 7; i++)
                            Expanded(
                              child: Center(
                                child: Text(
                                  // 1 Jan 2024 was a Monday - just a known
                                  // anchor to format weekday names from.
                                  DateFormat.E(locale)
                                      .format(DateTime(2024, 1, i)),
                                  style: TextStyle(
                                    color: scheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                            ),
                        itemCount: leadingBlanks + daysInMonth,
                        itemBuilder: (context, index) {
                          if (index < leadingBlanks) {
                            return const SizedBox.shrink();
                          }
                          final day = DateTime(
                            _visibleMonth.year,
                            _visibleMonth.month,
                            index - leadingBlanks + 1,
                          );
                          final isSelected =
                              day.year == _selected.year &&
                              day.month == _selected.month &&
                              day.day == _selected.day;
                          final isScheduled =
                              schedule?.isScheduledOn(day) ?? false;
                          return InkWell(
                            onTap: () => setState(() => _selected = day),
                            customBorder: const CircleBorder(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: isSelected
                                      ? scheme.primary
                                      : Colors.transparent,
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      color: isSelected
                                          ? scheme.onPrimary
                                          : scheme.onSurface,
                                    ),
                                  ),
                                ),
                                if (isScheduled)
                                  Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? scheme.primary
                                          : scheme.tertiary,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                scheduledToday
                    ? l10n.scheduledHours(
                        _formatMinutes(schedule!.startMinutes),
                        _formatMinutes(schedule.endMinutes),
                      )
                    : l10n.notScheduledToday,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
