enum ImageSize {
  /// 128x128
  thumb(128, 128, resolution: '128x128'),

  /// 512x512
  small(512, 512, resolution: '512x512'),

  /// 1024x1024
  medium(1024, 1024, resolution: '1024x1024'),

  /// 2048x2048
  large(2048, 2048, resolution: '2048x2048'),

  /// 4096x4096
  display(4096, 4096, resolution: '4096x4096');

  final int sizeX;
  final int sizeY;

  // Must be WidthxHeight for transcoding
  final String resolution;

  const ImageSize(this.sizeX, this.sizeY, {required this.resolution});
}
