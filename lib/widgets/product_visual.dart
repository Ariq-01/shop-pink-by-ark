import 'package:flutter/material.dart';

class ProductVisual extends StatelessWidget {
  final String imageKey;
  final double size;

  const ProductVisual({
    super.key,
    required this.imageKey,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink.withOpacity(0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.25),
            blurRadius: size / 2,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: size * 0.85,
          height: size * 0.85,
          child: CustomPaint(
            painter: _getProductPainter(imageKey),
          ),
        ),
      ),
    );
  }

  CustomPainter _getProductPainter(String key) {
    switch (key) {
      case 'watch':
        return WatchPainter();
      case 'perfume':
        return PerfumePainter();
      case 'headphones':
      default:
        return HeadphonesPainter();
    }
  }
}

class HeadphonesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;

    final paintBand = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..shader = RadialGradient(
        colors: [
          Colors.pinkAccent.shade100,
          const Color(0xFFFF4081),
          const Color(0xFFC2185B),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Headband arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, // PI (start at left)
      3.14159, // PI (sweep to right)
      false,
      paintBand,
    );

    // Left ear cup
    final leftCupRect = Rect.fromLTWH(
      center.dx - radius - (size.width * 0.12),
      center.dy - (size.height * 0.1),
      size.width * 0.22,
      size.height * 0.38,
    );
    final leftCupPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF80AB), Color(0xFFFF4081), Color(0xFFE91E63)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(leftCupRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(leftCupRect, const Radius.circular(30)),
      leftCupPaint,
    );

    // Left cushion inner
    final leftCushionRect = Rect.fromLTWH(
      center.dx - radius + (size.width * 0.04),
      center.dy - (size.height * 0.05),
      size.width * 0.05,
      size.height * 0.28,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(leftCushionRect, const Radius.circular(15)),
      Paint()..color = const Color(0xFFFFD54F).withOpacity(0.9),
    );

    // Right ear cup
    final rightCupRect = Rect.fromLTWH(
      center.dx + radius - (size.width * 0.1),
      center.dy - (size.height * 0.1),
      size.width * 0.22,
      size.height * 0.38,
    );
    final rightCupPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF80AB), Color(0xFFFF4081), Color(0xFFE91E63)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rightCupRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rightCupRect, const Radius.circular(30)),
      rightCupPaint,
    );

    // Right cushion inner
    final rightCushionRect = Rect.fromLTWH(
      center.dx + radius - (size.width * 0.09),
      center.dy - (size.height * 0.05),
      size.width * 0.05,
      size.height * 0.28,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rightCushionRect, const Radius.circular(15)),
      Paint()..color = const Color(0xFFFFD54F).withOpacity(0.9),
    );

    // Glass glossy highlight
    final glossPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromLTWH(
        center.dx - radius - (size.width * 0.08),
        center.dy - (size.height * 0.06),
        size.width * 0.05,
        size.height * 0.15,
      ),
      glossPaint,
    );
    canvas.drawOval(
      Rect.fromLTWH(
        center.dx + radius - (size.width * 0.06),
        center.dy - (size.height * 0.06),
        size.width * 0.05,
        size.height * 0.15,
      ),
      glossPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final dialRadius = size.width * 0.28;

    // Smartwatch strap
    final strapPath = Path()
      ..moveTo(center.dx - (size.width * 0.12), 0)
      ..lineTo(center.dx + (size.width * 0.12), 0)
      ..lineTo(center.dx + (size.width * 0.12), size.height)
      ..lineTo(center.dx - (size.width * 0.12), size.height)
      ..close();

    final strapPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE91E63), Color(0xFFFF4081), Color(0xFFC2185B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(strapPath, strapPaint);

    // Watch Bezel / Outer Circle
    final outerBezelRect = Rect.fromCircle(center: center, radius: dialRadius);
    final bezelPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFF80AB), Color(0xFFFF4081), Color(0xFF880E4F)],
      ).createShader(outerBezelRect);

    canvas.drawCircle(center, dialRadius, bezelPaint);

    // Gloss Inner Dial (Glassmorphic)
    final innerDialPaint = Paint()
      ..color = const Color(0x66FFFFFF)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, dialRadius * 0.85, innerDialPaint);

    // Glowing Neon Indicators
    final glowPaint = Paint()
      ..color = const Color(0xFFFF1744)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, dialRadius * 0.7, glowPaint);

    // Hour/minute hands (Futuristic digital)
    final handPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    canvas.drawLine(center, Offset(center.dx + (dialRadius * 0.4), center.dy - (dialRadius * 0.2)), handPaint);
    canvas.drawLine(center, Offset(center.dx, center.dy + (dialRadius * 0.35)), handPaint);

    // Subtle glass gloss
    final glossPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: dialRadius * 0.8),
      -1.0,
      1.5,
      true,
      glossPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PerfumePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Bottle cap (crown/flower shaped like perfume in image)
    final capRect = Rect.fromLTWH(
      center.dx - (size.width * 0.15),
      center.dy - (size.height * 0.42),
      size.width * 0.3,
      size.height * 0.22,
    );
    final capPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF80AB), Color(0xFFFF4081)],
      ).createShader(capRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(capRect, const Radius.circular(20)),
      capPaint,
    );

    // Gold neck connector
    final neckRect = Rect.fromLTWH(
      center.dx - (size.width * 0.06),
      center.dy - (size.height * 0.24),
      size.width * 0.12,
      size.height * 0.08,
    );
    canvas.drawRect(
      neckRect,
      Paint()..color = const Color(0xFFFFD54F).withOpacity(0.9),
    );

    // Bottle Main Glass Body
    final bodyRect = Rect.fromLTWH(
      center.dx - (size.width * 0.3),
      center.dy - (size.height * 0.18),
      size.width * 0.6,
      size.height * 0.52,
    );
    final bodyPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Color(0xFFFF80AB), Color(0xFFFF4081), Color(0xFFC2185B)],
        radius: 0.8,
      ).createShader(bodyRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(35)),
      bodyPaint,
    );

    // Inside liquid level line
    final liquidRect = Rect.fromLTWH(
      center.dx - (size.width * 0.25),
      center.dy - (size.height * 0.06),
      size.width * 0.5,
      size.height * 0.36,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(liquidRect, const Radius.circular(25)),
      Paint()..color = const Color(0x77FFFFFF),
    );

    // Glass highlights / reflections
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromLTWH(
        center.dx - (size.width * 0.24),
        center.dy - (size.height * 0.12),
        size.width * 0.08,
        size.height * 0.22,
      ),
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
