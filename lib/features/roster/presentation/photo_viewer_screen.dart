import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/theme/app_theme.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

/// Opens [photos] full screen at [initialIndex]: swipe between them,
/// pinch to zoom, and read when the photo was taken, by whom and its
/// caption. Every caller passes events from the same log, so the viewer
/// never shows a photo the feed doesn't know about.
Future<void> openPhotoViewer(
  BuildContext context,
  List<DayEvent> photos,
  int initialIndex,
) {
  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black,
      pageBuilder: (_, _, _) =>
          PhotoViewerScreen(photos: photos, initialIndex: initialIndex),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}

String photoHeroTag(DayEvent event) => 'photo-${event.photoName}';

class PhotoViewerScreen extends ConsumerStatefulWidget {
  const PhotoViewerScreen({
    super.key,
    required this.photos,
    required this.initialIndex,
  });

  final List<DayEvent> photos;
  final int initialIndex;

  @override
  ConsumerState<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> {
  late final PageController _pages = PageController(
    initialPage: widget.initialIndex,
  );
  late int _index = widget.initialIndex;
  bool _showDetails = true;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final folder = ref.watch(photosFolderProvider).value;
    final event = widget.photos[_index];
    final locale = Localizations.localeOf(context).toString();
    final when = DateFormat.yMMMMEEEEd(locale).add_Hm().format(event.at);

    // Always dark, like most photo viewers: a light glass panel over a
    // black backdrop is hard to read.
    return Theme(
      data: appDarkTheme,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.35),
          foregroundColor: Colors.white,
          title: Text(
            l10n.photoPosition(_index + 1, widget.photos.length),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            if (folder != null)
              IconButton(
                tooltip: l10n.sharePhoto,
                icon: const Icon(Icons.ios_share),
                onPressed: () => SharePlus.instance.share(
                  ShareParams(
                    files: [XFile('${folder.path}/${event.photoName}')],
                    text: event.note,
                  ),
                ),
              ),
          ],
        ),
        body: folder == null
            ? const SizedBox.shrink()
            : Stack(
                children: [
                  PageView.builder(
                    controller: _pages,
                    itemCount: widget.photos.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (context, i) {
                      final photo = widget.photos[i];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _showDetails = !_showDetails),
                        child: InteractiveViewer(
                          minScale: 1,
                          maxScale: 4,
                          child: Center(
                            child: Hero(
                              tag: photoHeroTag(photo),
                              child: Image.file(
                                File('${folder.path}/${photo.photoName}'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: SafeArea(
                      child: AnimatedOpacity(
                        opacity: _showDetails ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: IgnorePointer(
                          ignoring: !_showDetails,
                          child: _Details(
                            when: when,
                            by: l10n.noteBy(event.by),
                            caption: event.note,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.when, required this.by, this.caption});

  final String when;
  final String by;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final caption = this.caption;
    return GlassPanel(
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(when, style: text.labelLarge)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 18),
                const SizedBox(width: 8),
                Expanded(child: Text(by, style: text.bodySmall)),
              ],
            ),
            if (caption != null && caption.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(caption, style: text.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
