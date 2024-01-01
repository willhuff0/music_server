import 'dart:async';
import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_client/client/auth.dart';
import 'package:music_client/client/song.dart';
import 'package:music_client/ui/widgets/song_display.dart';
import 'package:music_client/ui/widgets/ultra_gradient.dart';
import 'package:music_shared/music_shared.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path/path.dart' as p;
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';

import 'package:music_client/ui/mobile/app.dart' if (dart.library.html) 'package:music_client/ui/web/app.dart' as app;

class UploadSongPage extends StatefulWidget {
  const UploadSongPage({super.key});

  @override
  State<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends State<UploadSongPage> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  late final StreamSubscription durationSubscription;

  late final AudioPlayer audioPlayer;

  late final GlobalKey formKey;

  var loading = false;
  String? loadingStatus;

  String? name;
  String? description;
  ImageProvider? image;

  List<Color>? colors;

  Uint8List? audioBytes;
  String? audioFileName;
  Duration? duration;

  Uint8List? imageBytes;
  String? imageFileName;

  bool explicit = false;

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    audioPlayer = AudioPlayer();
    durationSubscription = audioPlayer.durationStream.listen((newDuration) {
      if (mounted) setState(() => duration = newDuration);
      print(duration);
    });
    formKey = GlobalKey();
    super.initState();
  }

  void selectAudio(Uint8List? bytes, String? fileName) async {
    setState(() => audioFileName = fileName);
    if (bytes != null) {
      await audioPlayer.stop();
      audioBytes = bytes;
      try {
        await audioPlayer.setAudioSource(BytesAudioSource(fileName!, audioBytes!));
      } on PlayerException catch (e) {
        // iOS/macOS: maps to NSError.code
        // Android: maps to ExoPlayerException.type
        // Web: maps to MediaError.code
        print("Error code: ${e.code}");
        // iOS/macOS: maps to NSError.localizedDescription
        // Android: maps to ExoPlaybackException.getMessage()
        // Web: a generic message
        print("Error message: ${e.message}");
      } on PlayerInterruptedException catch (e) {
        // This call was interrupted since another audio source was loaded or the
        // player was stopped or disposed before this audio source could complete
        // loading.
        print("Connection aborted: ${e.message}");
      } catch (e) {
        // Fallback for all errors
        print(e);
      }
    } else {
      await audioPlayer.stop();
      audioBytes = null;
    }
  }

  void selectImage(Uint8List? bytes, String? fileName) {
    setState(() => imageFileName = fileName);
    imageBytes = bytes;
    if (bytes != null) {
      setState(() => image = MemoryImage(bytes));
      getColorsFromImage(image!).then((value) => colors = value);
    } else {
      setState(() {
        image = null;
        colors = null;
      });
    }
  }

  void refreshColors() {
    if (image != null) {
      PaletteGenerator.fromImageProvider(image!).then((value) {
        final paletteColors = value.colors.toList()..shuffle();
        setState(() => colors = paletteColors.take(4).toList());
      });
    }
  }

  void upload(BuildContext context) async {
    final formState = formKey.currentState as FormState;
    if (!formState.validate()) return;
    formState.save();

    if (audioBytes == null || audioFileName == null || imageBytes == null || imageFileName == null) return;

    try {
      setState(() {
        loading = true;
        loadingStatus = 'Registering Song';
      });
      'This track finds Abel in a constant state of distraction that he only gets relief from when in the presence of a significant other.';

      final songId = await createSong(
        fileExtension: p.extension(audioFileName!),
        numParts: 1,
        name: name!,
        description: description ?? '',
        explicit: explicit,
        duration: duration!,
        genres: [Genre.pop], // Add genres dropdown
      );
      if (songId == null) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
        return;
      }

      setState(() => loadingStatus = 'Uploading audio');

      if (!await uploadSongData(songId: songId, start: 0, data: audioBytes!)) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
        return;
      }

      if (!await uploadImageData(songId: songId, fileExtension: p.extension(imageFileName!), data: imageBytes!)) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
        return;
      }

      if (!await finishSongUpload(songId: songId)) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
        return;
      }

      if (mounted) Navigator.pop(context, true);
    } finally {
      setState(() {
        loading = false;
        loadingStatus = null;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    audioPlayer.stop().then((value) => audioPlayer.dispose());
    durationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1050.0,
      child: Stack(
        children: [
          Positioned(
            top: 24.0,
            right: 24.0,
            child: IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () async {
                final result = await showDialog<bool>(context: context, builder: (context) => const CloseConfirmAlertDialog());
                if (mounted && (result ?? false)) Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 24.0,
            left: 24.0,
            child: Text('Create Song', style: Theme.of(context).textTheme.titleLarge),
          ),
          Positioned(
            top: 86.0,
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: DynMouseScroll(
                      builder: (context, controller, physics) {
                        return ListView(
                          controller: controller,
                          physics: physics,
                          padding: const EdgeInsets.all(24.0),
                          children: [
                            Center(
                              child: SizedBox(
                                width: 450.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('About', style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 24.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      child: TextFormField(
                                        controller: nameController,
                                        enabled: !loading,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        maxLength: songNameMaxLength,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) return 'Please provide a name';
                                          if (!validateSongName(value)) return 'Name must be between $songNameMinLength and $songNameMaxLength characters';
                                          return null;
                                        },
                                        onChanged: (value) => setState(() => name = value),
                                      ),
                                    ),
                                    const SizedBox(height: 14.0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      child: TextFormField(
                                        controller: descriptionController,
                                        enabled: !loading,
                                        decoration: InputDecoration(
                                          labelText: 'Description',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          alignLabelWithHint: true,
                                        ),
                                        minLines: 3,
                                        maxLines: 6,
                                        maxLength: songDescriptionMaxLength,
                                        validator: (value) {
                                          if (value == null) return null;
                                          if (!validateSongDescription(value)) return 'Description must be at most $songDescriptionMaxLength characters';
                                          return null;
                                        },
                                        onChanged: (value) => setState(() => description = value),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14.0),
                            Center(
                              child: SizedBox(
                                width: 450.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(value: explicit, onChanged: (value) => setState(() => explicit = value ?? false)),
                                      SizedBox(width: 8.0),
                                      Text('Explicit'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 48.0),
                            Center(
                              child: SizedBox(
                                width: 450.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Audio', style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 14.0),
                                    const Text('•  Choose a lossless audio codec such as .wav or .flac'),
                                    const SizedBox(height: 8.0),
                                    const Text('•  It must be either stereo (2 channels) or mono (1 channel)'),
                                    const SizedBox(height: 8.0),
                                    const Text('•  Your audio will be normalized'),
                                    const SizedBox(height: 8.0),
                                    const Text('•  On our end, we\'ll optimize your audio for different devices:'),
                                    const SizedBox(height: 4.0),
                                    const Text('    •  Opus at 96, 52, and 36 kbps per channel'),
                                    const Text('    •  AAC with 5, 3, and 1 vbr mode'),
                                    const SizedBox(height: 24.0),
                                    Center(
                                      child: SizedBox(
                                        width: 400.0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 400.0,
                                              height: 200.0,
                                              child: FileDropZone(
                                                enabled: !loading,
                                                icon: Icons.music_video_rounded,
                                                text: 'Upload audio file (.wav, .flac, ...)',
                                                onSelect: selectAudio,
                                              ),
                                            ),
                                            if (audioFileName != null) ...[
                                              const SizedBox(height: 14.0),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(14.0),
                                                  border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.4), width: 2.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 14.0, right: 4.0, top: 4.0, bottom: 4.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(audioFileName!),
                                                      const SizedBox(width: 8.0),
                                                      IconButton(
                                                        onPressed: loading
                                                            ? null
                                                            : () {
                                                                selectAudio(null, null);
                                                              },
                                                        icon: const Icon(Icons.close_rounded),
                                                        iconSize: 14.0,
                                                        visualDensity: VisualDensity.compact,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 48.0),
                            Center(
                              child: SizedBox(
                                width: 450.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Cover Art', style: Theme.of(context).textTheme.titleMedium),
                                    const SizedBox(height: 14.0),
                                    const Text('•  Choose a lossless image codec such as .png or .tiff'),
                                    const SizedBox(height: 8.0),
                                    const Text('•  Make sure your image is square'),
                                    const SizedBox(height: 8.0),
                                    const Text('•  On our end, we\'ll optimize your image for different devices:'),
                                    const SizedBox(height: 4.0),
                                    const Text('    •  WebP with 2048x2048, 1024x1024, 512x512, 256x256,\n       and 128x128 pixels'),
                                    const SizedBox(height: 24.0),
                                    Center(
                                      child: SizedBox(
                                        width: 400.0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 400.0,
                                              height: 200.0,
                                              child: FileDropZone(
                                                enabled: !loading,
                                                icon: Icons.image_rounded,
                                                text: 'Upload image file (.png, .tiff, ...)',
                                                onSelect: selectImage,
                                              ),
                                            ),
                                            if (imageFileName != null) ...[
                                              const SizedBox(height: 14.0),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(14.0),
                                                  border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.4), width: 2.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 14.0, right: 4.0, top: 4.0, bottom: 4.0),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(imageFileName!),
                                                      const SizedBox(width: 8.0),
                                                      IconButton(
                                                        onPressed: loading
                                                            ? null
                                                            : () {
                                                                selectImage(null, null);
                                                              },
                                                        icon: const Icon(Icons.close_rounded),
                                                        iconSize: 14.0,
                                                        visualDensity: VisualDensity.compact,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 48.0),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (loadingStatus != null) ...[
                                    Text(loadingStatus!),
                                    const SizedBox(width: 24.0),
                                  ],
                                  if (loading) ...[
                                    const SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: CircularProgressIndicator(strokeWidth: 3.0),
                                    ),
                                    const SizedBox(width: 24.0),
                                  ],
                                  FilledButton(
                                    onPressed: audioBytes != null && imageBytes != null && !loading ? () => upload(context) : null,
                                    child: const Text('Submit and Upload'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const VerticalDivider(),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Preview', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(width: 14.0),
                          FilledButton.tonalIcon(
                            onPressed: () {
                              refreshColors();
                            },
                            icon: const Icon(Icons.refresh_rounded),
                            label: const Text('Refresh colors'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26.0),
                      Expanded(
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Container(
                              width: 425.0,
                              height: 900.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                border: const Border(
                                  top: BorderSide(width: 12.0, strokeAlign: BorderSide.strokeAlignOutside),
                                  bottom: BorderSide(width: 10.0, strokeAlign: BorderSide.strokeAlignOutside),
                                  left: BorderSide(width: 6.0, strokeAlign: BorderSide.strokeAlignOutside),
                                  right: BorderSide(width: 6.0, strokeAlign: BorderSide.strokeAlignOutside),
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: SongDisplay(
                                name: name ?? '',
                                ownerName: identityTokenObject!.displayName!,
                                description: description ?? '',
                                image: image,
                                colors: colors,
                                duration: duration ?? const Duration(minutes: 1),
                                audioPlayer: audioPlayer,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CloseConfirmAlertDialog extends StatefulWidget {
  const CloseConfirmAlertDialog({super.key});

  @override
  State<CloseConfirmAlertDialog> createState() => _CloseConfirmAlertDialogState();
}

class _CloseConfirmAlertDialogState extends State<CloseConfirmAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Closing will delete all progress made on your new song.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Close'),
        ),
        FilledButton.tonal(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Go back'),
        ),
      ],
    );
  }
}

class FileDropZone extends StatefulWidget {
  final bool enabled;
  final IconData icon;
  final String text;

  final void Function(Uint8List? bytes, String? fileName) onSelect;

  const FileDropZone({super.key, this.enabled = true, required this.icon, required this.text, required this.onSelect});

  @override
  State<FileDropZone> createState() => _FileDropZoneState();
}

class _FileDropZoneState extends State<FileDropZone> {
  var _dragging = false;

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      enable: !loading && widget.enabled,
      onDragDone: (detail) async {
        if (detail.files.isEmpty) return;
        try {
          setState(() => loading = true);

          Uint8List? bytes = await detail.files.first.readAsBytes();
          if (bytes.lengthInBytes > 100000000) {
            bytes = null;
          }

          if (mounted) {
            widget.onSelect(bytes, bytes == null ? null : detail.files.first.name);
          }
        } finally {
          if (mounted) setState(() => loading = false);
        }
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: _dragging ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.4), width: 2.0),
        ),
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: !loading && widget.enabled
              ? () async {
                  try {
                    setState(() => loading = true);

                    FilePickerResult? result = await FilePicker.platform.pickFiles();
                    if (result == null) return;
                    if (result.files.isEmpty) return;

                    var bytes = await app.getBytesFromPickedFile(result.files.first);
                    if (bytes != null && bytes.lengthInBytes > 100000000) {
                      bytes = null;
                    }

                    if (mounted) {
                      widget.onSelect(bytes, bytes == null ? null : result.files.first.name);
                    }
                  } finally {
                    if (mounted) setState(() => loading = false);
                  }
                }
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(widget.icon),
              const SizedBox(height: 8.0),
              Text(widget.text),
              const SizedBox(height: 4.0),
              Text('< 100 MB', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 24.0),
              SizedBox(
                height: 4.0,
                child: loading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 36.0),
                        child: LinearProgressIndicator(),
                      )
                    : null,
              ),
              const SizedBox(height: 36.0),
            ],
          ),
        ),
      ),
    );
  }
}

class BytesAudioSource extends StreamAudioSource {
  final String fileName;
  final List<int> bytes;

  BytesAudioSource(this.fileName, this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/${p.extension(fileName).substring(1)}',
    );
  }
}
