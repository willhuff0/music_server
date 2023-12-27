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
  opus(fileType: 'opus'),
  aac(fileType: 'aac');

  final String fileType;

  const CompressedAudioFormat({required this.fileType});
}

class AudioPreset {
  final CompressedAudioFormat format;
  final CompressedAudioQuality quality;

  AudioPreset({required this.format, required this.quality});

  @override
  String toString() => '{${format.name}, ${quality.name}}';
}
