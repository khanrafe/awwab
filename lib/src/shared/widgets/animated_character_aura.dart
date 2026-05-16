import 'dart:math' as math;

import 'package:awwab/src/theme/app_motion.dart';
import 'package:flutter/material.dart';

class AnimatedCharacterAura extends StatefulWidget {
  const AnimatedCharacterAura({
    super.key,
    required this.progress,
    this.size = 220,
    this.glowColor = const Color(0xFF8C73FF),
    this.characterAssetPath = 'assets/images/awwab_character.png',
    this.ringAssetPath = 'assets/images/awwab_aura_ring.png',
    this.showFrontParticles = true,
    this.enableRingRotation = false,
  });

  final double progress;
  final double size;
  final Color glowColor;
  final String characterAssetPath;
  final String ringAssetPath;
  final bool showFrontParticles;
  final bool enableRingRotation;

  @override
  State<AnimatedCharacterAura> createState() => _AnimatedCharacterAuraState();
}

class _AnimatedCharacterAuraState extends State<AnimatedCharacterAura>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _pulseController;
  late final AnimationController _fadeController;
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat(reverse: true);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppMotion.slowMs),
    )..forward();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 42000),
    );

    if (widget.enableRingRotation) {
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedCharacterAura oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enableRingRotation == widget.enableRingRotation) {
      return;
    }
    if (widget.enableRingRotation) {
      _rotationController.repeat();
    } else {
      _rotationController.stop();
      _rotationController.value = 0;
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double clampedProgress = widget.progress.clamp(0, 1);
    final double pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final int imageCacheSize = (widget.size * pixelRatio * 1.45).round();

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: Listenable.merge(<Listenable>[
          _floatController,
          _pulseController,
          _fadeController,
          _rotationController,
        ]),
        builder: (context, child) {
          final double floatOffset =
              math.sin(_floatController.value * math.pi * 2) * 4.2;
          final double ringBobOffset =
              math.sin((_floatController.value * math.pi * 2) + 0.7) * 2;
          final double pulseScale = 0.985 + (_pulseController.value * 0.018);
          final double glowOpacity = 0.17 + (_pulseController.value * 0.16);
          final double frontSparkleOpacity =
              0.38 + (_pulseController.value * 0.32);

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
                      _BackgroundGlowLayer(
                        size: widget.size,
                        glowColor: widget.glowColor,
                        glowOpacity: glowOpacity,
                      ),
                      Transform.translate(
                        offset: Offset(0, ringBobOffset),
                        child: _AuraRingLayer(
                          size: widget.size,
                          progress: clampedProgress,
                          ringAssetPath: widget.ringAssetPath,
                          cacheSize: imageCacheSize,
                          rotationTurns: widget.enableRingRotation
                              ? (_rotationController.value * 0.03)
                              : 0,
                        ),
                      ),
                      _CharacterLayer(
                        size: widget.size,
                        characterAssetPath: widget.characterAssetPath,
                        cacheSize: imageCacheSize,
                      ),
                      if (widget.showFrontParticles)
                        _FrontParticlesLayer(
                          size: widget.size,
                          opacity: frontSparkleOpacity,
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

class _BackgroundGlowLayer extends StatelessWidget {
  const _BackgroundGlowLayer({
    required this.size,
    required this.glowColor,
    required this.glowOpacity,
  });

  final double size;
  final Color glowColor;
  final double glowOpacity;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Container(
      width: size * 0.94,
      height: size * 0.94,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            glowColor.withValues(alpha: 0.05),
            glowColor.withValues(alpha: 0.24),
            glowColor.withValues(alpha: 0.02),
          ],
          stops: const <double>[0.18, 0.62, 1],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: glowColor.withValues(alpha: glowOpacity),
            blurRadius: size * 0.18,
            spreadRadius: size * 0.026,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    ),
  );
}

class _AuraRingLayer extends StatelessWidget {
  const _AuraRingLayer({
    required this.size,
    required this.progress,
    required this.ringAssetPath,
    required this.cacheSize,
    required this.rotationTurns,
  });

  final double size;
  final double progress;
  final String ringAssetPath;
  final int cacheSize;
  final double rotationTurns;

  @override
  Widget build(BuildContext context) {
    final double ringSize = size * 1.01;

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: 0.34,
            child: Image.asset(
              ringAssetPath,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              cacheWidth: cacheSize,
            ),
          ),
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (rect) => SweepGradient(
              startAngle: -math.pi / 2,
              endAngle: (math.pi * 2) - (math.pi / 2),
              colors: <Color>[
                Colors.white,
                Colors.white,
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0),
              ],
              stops: <double>[0, progress, progress, 1],
              transform: GradientRotation(rotationTurns * math.pi * 2),
            ).createShader(rect),
            child: Transform.rotate(
              angle: rotationTurns * math.pi * 2,
              child: Image.asset(
                ringAssetPath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                cacheWidth: cacheSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterLayer extends StatelessWidget {
  const _CharacterLayer({
    required this.size,
    required this.characterAssetPath,
    required this.cacheSize,
  });

  final double size;
  final String characterAssetPath;
  final int cacheSize;

  @override
  Widget build(BuildContext context) => Align(
    alignment: const Alignment(0, 0.18),
    child: SizedBox(
      width: size * 0.72,
      height: size * 0.92,
      child: Image.asset(
        characterAssetPath,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        cacheWidth: cacheSize,
      ),
    ),
  );
}

class _FrontParticlesLayer extends StatelessWidget {
  const _FrontParticlesLayer({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: Opacity(
      opacity: opacity,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: size * 0.18,
              top: size * 0.32,
              child: _sparkle(size * 0.05),
            ),
            Positioned(
              right: size * 0.20,
              top: size * 0.28,
              child: _sparkle(size * 0.04),
            ),
            Positioned(
              right: size * 0.27,
              bottom: size * 0.24,
              child: _sparkle(size * 0.045),
            ),
            Positioned(
              left: size * 0.30,
              bottom: size * 0.18,
              child: _sparkle(size * 0.038),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _sparkle(double iconSize) =>
      Icon(Icons.auto_awesome, size: iconSize, color: const Color(0xFFE4D8FF));
}
