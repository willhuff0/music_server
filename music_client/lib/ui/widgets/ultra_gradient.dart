import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:music_client/theme.dart';
import 'package:palette_generator/palette_generator.dart';

Future<List<Color>> getColorsFromImage(ImageProvider image) async {
  final palette = await PaletteGenerator.fromImageProvider(image);
  return palette.colors.sorted((a, b) => a.computeLuminance().compareTo(b.computeLuminance())).take(4).toList();
}

class AnimatedUltraGradient extends StatefulWidget {
  final Duration duration;
  final Duration maxStoppedDuration;
  final double opacity;
  final double pointSize;
  final List<Color>? colors;
  final Widget? child;
  final bool expand;

  const AnimatedUltraGradient({
    super.key,
    this.duration = const Duration(seconds: 20),
    this.maxStoppedDuration = const Duration(milliseconds: 2000),
    this.opacity = 0.75,
    this.pointSize = 1000.0,
    this.colors,
    this.child,
    this.expand = true,
  });

  @override
  State<AnimatedUltraGradient> createState() => _AnimatedUltraGradientState();
}

class _AnimatedUltraGradientState extends State<AnimatedUltraGradient> with TickerProviderStateMixin {
  FragmentShader? shader;
  late final AnimationController animationController;

  List<Color>? pointColors;
  late List<double> pointSizes;

  List<(double x, double y)>? pointPositionsA;
  List<(double x, double y)>? pointPositionsB;

  @override
  void didUpdateWidget(covariant AnimatedUltraGradient oldWidget) {
    if (widget.pointSize != oldWidget.pointSize || !listEquals(widget.colors, oldWidget.colors)) update();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    loadShader();
    animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animate();
    });

    super.initState();
  }

  void loadShader() async {
    try {
      final program = await FragmentProgram.fromAsset('shaders/ultragradient.frag');
      if (!mounted) return;
      setState(() => shader = program.fragmentShader());
    } catch (e) {
      print(e);
    }
  }

  void animate() async {
    while (mounted) {
      await animationController.animateTo(1.0, duration: widget.duration, curve: Curves.easeInOut);
      pointPositionsA = List.from(pointPositionsB!);
      pointPositionsB = getNextPointPositions();
      animationController.reset();
      await Future.delayed(Duration(milliseconds: _random.nextInt(widget.maxStoppedDuration.inMilliseconds)));
    }
  }

  List<(double x, double y)> getNextPointPositions() => poissonDiskSample(
        count: 4,
        radius: 0.3,
        sizeX: 1.0,
        sizeY: 1.0,
      );

  void update() {
    pointColors = widget.colors ??
        [
          darkTheme.colorScheme.inversePrimary,
          darkTheme.colorScheme.errorContainer,
          darkTheme.colorScheme.tertiaryContainer,
          darkTheme.colorScheme.surfaceVariant,
          //Colors.deepOrangeAccent,
        ];

    pointSizes = List.generate(4, (index) => widget.pointSize);
  }

  @override
  void dispose() {
    shader?.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return widget.child ?? Container();
    }

    final child = AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        if (pointPositionsA == null || pointPositionsB == null) {
          pointPositionsA = getNextPointPositions();
          pointPositionsB = getNextPointPositions();
        }

        update();

        final pointPositions = lerpPositions(pointPositionsA!, pointPositionsB!, animationController.value);

        return CustomPaint(
          painter: UltraGradientPainter(
            shader: shader!,
            numPoints: pointPositions.length,
            outputIntensity: widget.opacity,
            pointPositions: pointPositions,
            pointColors: pointColors!,
            pointSizes: pointSizes,
          ),
          child: widget.child,
        );
      },
    );

    return widget.expand ? SizedBox.expand(child: child) : child;
  }
}

final listEquals = const ListEquality().equals;

class UltraGradientPainter extends CustomPainter {
  final FragmentShader shader;

  final int numPoints;
  final double outputIntensity;
  final List<(double x, double y)> pointPositions;
  final List<double> pointSizes;
  final List<Color> pointColors;

  UltraGradientPainter({
    required this.shader,
    required this.numPoints,
    required this.outputIntensity,
    required this.pointPositions,
    required this.pointSizes,
    required this.pointColors,
    super.repaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, outputIntensity);

    var i = 1;
    for (var k = 0; k < numPoints; k++) {
      shader.setFloat(i, pointPositions[k].$1 * size.width);
      shader.setFloat(i + 1, pointPositions[k].$2 * size.height);
      i += 2;
    }
    for (var k = 0; k < numPoints; k++) {
      shader.setFloat(i, pointSizes[k]);
      i++;
    }
    for (var k = 0; k < numPoints; k++) {
      shader.setFloat(i, pointColors[k].red.toDouble() / 255.0);
      shader.setFloat(i + 1, pointColors[k].green.toDouble() / 255.0);
      shader.setFloat(i + 2, pointColors[k].blue.toDouble() / 255.0);
      shader.setFloat(i + 3, pointColors[k].opacity);
      i += 4;
    }

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(UltraGradientPainter oldDelegate) => true; // shader != oldDelegate.shader || !listEquals(pointPositions, oldDelegate.pointPositions) || !listEquals(pointSizes, oldDelegate.pointSizes) || !listEquals(pointColors, oldDelegate.pointColors);
}

final _random = Random();

/// Simple Poisson Disk Sampling. Generates random points until count valid points are found. Fails after 100 unsuccessful samples.
List<(double x, double y)> poissonDiskSample({required int count, required double radius, required double sizeX, required double sizeY}) {
  final points = [(_random.nextDouble() * sizeX, _random.nextDouble() * sizeY)];

  var i = 1;
  for (var k = 0; k < 100; k++) {
    final sample = (_random.nextDouble() * sizeX, _random.nextDouble() * sizeY);

    var valid = true;
    for (final point in points) {
      final difference = (sample.$1 - point.$1, sample.$2 - point.$2);
      final distance = sqrt(difference.$1 * difference.$1 + difference.$2 * difference.$2);

      if (distance < radius) {
        valid = false;
        break;
      }
    }
    if (valid) {
      points.add(sample);
      i++;
      if (i >= count) break;
    }
  }

  // If no more points can be generated, force random sample
  if (points.length < count) points.addAll(List.generate(count - points.length, (index) => (_random.nextDouble() * sizeX, _random.nextDouble() * sizeY)));

  return points;
}

List<(double x, double y)> lerpPositions(List<(double x, double y)> a, List<(double x, double y)> b, double c) {
  return a.mapIndexed((index, element) => (lerpDouble(element.$1, b[index].$1, c)!, lerpDouble(element.$2, b[index].$2, c)!)).toList();
}
