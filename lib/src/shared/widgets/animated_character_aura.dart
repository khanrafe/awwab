import 'dart:math' as math;

import 'package:awwab/src/theme/app_motion.dart';
import 'package:flutter/material.dart';

class AnimatedCharacterAura extends StatefulWidget {
  const AnimatedCharacterAura({
    super.key,
    required this.progress,
    this.size = 220,
    this.glowColor = const Color(0xFF8C73FF),
    this.ringColors = const <Color>[
      Color(0xFFA97CFF),
      Color(0xFFBCD9FF),
      Color(0xFF8E6DFF),
      Color(0xFFA97CFF),
    ],
    this.heroAssetPath = 'assets/images/awwab_character_main.jpg',
  });

  final double progress;
  final double size;
  final Color glowColor;
  final List<Color> ringColors;
  final String heroAssetPath;

  @override
  State<AnimatedCharacterAura> createState() => _AnimatedCharacterAuraState();
}

class _AnimatedCharacterAuraState extends State<AnimatedCharacterAura>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _pulseController;
  late final AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat(reverse: true);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppMotion.slowMs),
    )..forward();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double clampedProgress = widget.progress.clamp(0, 1);

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge(<Listenable>[
          _floatController,
          _pulseController,
          _fadeController,
        ]),
        builder: (context, child) {
          final double floatOffset =
              math.sin(_floatController.value * math.pi * 2) * 4;
          final double pulseScale = 0.985 + (_pulseController.value * 0.02);
          final double glowOpacity = 0.24 + (_pulseController.value * 0.14);

          return Opacity(
            opacity: Curves.easeOut.transform(_fadeController.value),
            child: Transform.translate(
              offset: Offset(0, floatOffset),
              child: Transform.scale(
                scale: pulseScale,
                child: SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: widget.size * 0.96,
                        height: widget.size * 0.96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: widget.glowColor.withValues(
                                alpha: glowOpacity,
                              ),
                              blurRadius: widget.size * 0.11,
                              spreadRadius: widget.size * 0.004,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                      CustomPaint(
                        size: Size(widget.size * 0.94, widget.size * 0.94),
                        painter: _AuraRingPainter(
                          progress: clampedProgress,
                          ringColors: widget.ringColors,
                        ),
                      ),
                      Container(
                        width: widget.size * 0.78,
                        height: widget.size * 0.78,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: <Color>[
                              const Color(0xFF2A2C76).withValues(alpha: 0.22),
                              const Color(0xFF171A52).withValues(alpha: 0.80),
                            ],
                          ),
                        ),
                      ),
                      ClipOval(
                        child: SizedBox(
                          width: widget.size * 0.82,
                          height: widget.size * 0.82,
                          child: Image.asset(
                            widget.heroAssetPath,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            color: const Color(
                              0xFFEDF0FF,
                            ).withValues(alpha: 0.92),
                            colorBlendMode: BlendMode.screen,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.person_rounded,
                                  color: Color(0xFF171C62),
                                  size: 120,
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: widget.size * 0.09,
                        child: Icon(
                          Icons.auto_awesome,
                          color: const Color(
                            0xFFD4C7FF,
                          ).withValues(alpha: 0.92),
                          size: widget.size * 0.10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AuraRingPainter extends CustomPainter {
  const _AuraRingPainter({required this.progress, required this.ringColors});

  final double progress;
  final List<Color> ringColors;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (size.width / 2) - 10;

    final Paint trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..color = const Color(0xFFE7EAF8)
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
    final SweepGradient gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: (math.pi * 2) - (math.pi / 2),
      colors: ringColors,
    );

    final Paint progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round
      ..shader = gradient.createShader(arcRect);

    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      (math.pi * 2) * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AuraRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.ringColors != ringColors;
}
