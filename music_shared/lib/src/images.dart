enum ImageSize {
  /// 128x128
  thumb(128, 128, resolution: '128x128'),

  /// 256x256
  small(256, 256, resolution: '256x256'),

  /// 512x512
  medium(512, 512, resolution: '512x512'),

  /// 1024x1024
  large(1024, 1024, resolution: '1024x1024'),

  /// 2048x2048
  display(2048, 2048, resolution: '2048x2048');

  final int sizeX;
  final int sizeY;

  // Must be WidthxHeight for transcoding
  final String resolution;

  const ImageSize(this.sizeX, this.sizeY, {required this.resolution});
}
