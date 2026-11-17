import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/presentation/photo_viewer_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Every photo attached to the children's notes, newest first. A view
/// over the same event log as the activity feed: there is no separate
/// photo store that could fall out of sync with it.
class PhotoGalleryScreen extends ConsumerWidget {
  const PhotoGalleryScreen({
    super.key,
    required this.children,
    this.actions = const [],
  });

  /// One child from the staff detail screen; all of a parent's children
  /// on the parent's Photos tab.
  final List<Child> children;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final folder = ref.watch(photosFolderProvider).value;
    final roster = ref.watch(rosterViewModelProvider);
    final events = [
      for (final c in children)
        ...roster.allEventsOf(c.id).where((e) => e.photoName != null),
    ]..sort((a, b) => b.at.compareTo(a.at));
    final title = children.length == 1
        ? '${l10n.photosTitle} · ${children.single.name}'
        : l10n.photosTitle;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(title), actions: actions),
      body: GlassBackground(
        child: SafeArea(
          child: events.isEmpty || folder == null
              ? Center(child: Text(l10n.noPhotosYet))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final date = MaterialLocalizations.of(context)
                        .formatMediumDate(event.at);
                    final caption = event.note;
                    return GestureDetector(
                      onTap: () => openPhotoViewer(context, events, index),
                      child: GlassPanel(
                        radius: 14,
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                                child: Hero(
                                  tag: photoHeroTag(event),
                                  child: Image.file(
                                    File('${folder.path}/${event.photoName}'),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    // Decode a thumbnail, not the full photo:
                                    // a grid of full-size decodes is what
                                    // runs an old phone out of memory.
                                    cacheWidth: 480,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    date,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                  if (caption != null && caption.isNotEmpty)
                                    Text(
                                      caption,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
