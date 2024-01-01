enum CompressedAudioQuality {
  low(opuskbpsPerChannel: 36, aacVBRMode: 1, outputFileName: 'low'),
  medium(opuskbpsPerChannel: 52, aacVBRMode: 3, outputFileName: 'medium'),
  high(opuskbpsPerChannel: 96, aacVBRMode: 5, outputFileName: 'high');

  final int opuskbpsPerChannel;
  final int aacVBRMode;
  final String outputFileName;

  const CompressedAudioQuality({
    required this.opuskbpsPerChannel,
    required this.aacVBRMode,
    required this.outputFileName,
  });
}

enum CompressedAudioFormat {
  opus(fileType: 'opus', mimeType: 'audio/opus'),
  aac(fileType: 'm4a', mimeType: 'audio/mp4');

  final String fileType;
  final String mimeType;

  const CompressedAudioFormat({required this.fileType, required this.mimeType});
}

class AudioPreset {
  final CompressedAudioFormat format;
  final CompressedAudioQuality quality;

  AudioPreset({required this.format, required this.quality});

  @override
  String toString() => '{${format.name}, ${quality.name}}';
}

enum Genre {
  hipHop(displayName: 'Hip Hop'),
  pop(displayName: 'Pop'),
  folk(displayName: 'Folk'),
  experimental(displayName: 'Experimental'),
  rock(displayName: 'Rock'),
  international(displayName: 'International'),
  electronic(displayName: 'Electronic'),
  instrumental(displayName: 'Instrumental');

  final String displayName;

  const Genre({required this.displayName});
}
