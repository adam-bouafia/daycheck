import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/// [startWithCamera] opens the camera as soon as the sheet appears, for
/// the "Take photo" button: staff are usually holding the phone up
/// already, and the caption can be typed after.
Future<void> openAddNoteSheet(
  BuildContext context,
  String childId, {
  bool startWithCamera = false,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) =>
        _AddNoteSheet(childId: childId, startWithCamera: startWithCamera),
  );
}

class _AddNoteSheet extends ConsumerStatefulWidget {
  const _AddNoteSheet({required this.childId, this.startWithCamera = false});

  final String childId;
  final bool startWithCamera;

  @override
  ConsumerState<_AddNoteSheet> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends ConsumerState<_AddNoteSheet> {
  final _note = TextEditingController();
  String? _photoPath;
  String? _attachmentPath;

  @override
  void initState() {
    super.initState();
    if (widget.startWithCamera) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _pickPhoto(ImageSource.camera),
      );
    }
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (picked != null) setState(() => _photoPath = picked.path);
  }

  Future<void> _pickAttachment() async {
    final picked = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    final path = picked.isEmpty ? null : picked.single.path;
    if (path != null) setState(() => _attachmentPath = path);
  }

  Future<void> _save() async {
    final text = _note.text.trim();
    // A photo can go out on its own; a note needs words or a file.
    if (text.isEmpty && _photoPath == null && _attachmentPath == null) return;
    await ref
        .read(rosterViewModelProvider.notifier)
        .addActivityNote(
          widget.childId,
          text,
          by: ref.read(sessionViewModelProvider).displayName,
          photoSourcePath: _photoPath,
          attachmentSourcePath: _attachmentPath,
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.addActivityNoteTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: l10n.whatDidTheyDo,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _pickPhoto(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: Text(l10n.takePhoto),
                ),
                OutlinedButton.icon(
                  onPressed: () => _pickPhoto(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(l10n.choosePhoto),
                ),
                OutlinedButton.icon(
                  onPressed: _pickAttachment,
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: Text(
                    _attachmentPath == null ? l10n.addPdf : l10n.pdfAdded,
                  ),
                ),
              ],
            ),
            if (_photoPath != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(_photoPath!),
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheWidth: 600,
                ),
              ),
            ],
            if (_attachmentPath != null) ...[
              const SizedBox(height: 8),
              Text('${l10n.pdfAdded}: ${_attachmentPath!.split('/').last}'),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: _save, child: Text(l10n.save)),
            ),
          ],
        ),
      ),
    );
  }
}
