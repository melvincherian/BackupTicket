
import 'package:flutter/material.dart';

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFD7DCEA)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = Path();
    final shadowPath = Path();

    const double cornerRadius = 20.0;
    const double curveRadius = 18.0; // Single curve radius
    const double curveDepth = 20.0; // Curve depth

    // Create the ticket shape with single curves on each side
    // Top left corner
    path.moveTo(cornerRadius, 0);

    // Top edge
    path.lineTo(size.width - cornerRadius, 0);
    path.arcToPoint(
      Offset(size.width, cornerRadius),
      radius: const Radius.circular(cornerRadius),
    );

    // Right edge with single curve in the middle
    path.lineTo(size.width, size.height * 0.5 - curveRadius);
    path.arcToPoint(
      Offset(size.width - curveDepth, size.height * 0.5),
      radius: const Radius.circular(curveRadius),
      clockwise: false,
    );
    path.arcToPoint(
      Offset(size.width, size.height * 0.5 + curveRadius),
      radius: const Radius.circular(curveRadius),
      clockwise: false,
    );

    // Continue right edge to bottom
    path.lineTo(size.width, size.height - cornerRadius);
    path.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: const Radius.circular(cornerRadius),
    );

    // Bottom edge
    path.lineTo(cornerRadius, size.height);
    path.arcToPoint(
      Offset(0, size.height - cornerRadius),
      radius: const Radius.circular(cornerRadius),
    );

    // Left edge with single curve in the middle
    path.lineTo(0, size.height * 0.5 + curveRadius);
    path.arcToPoint(
      Offset(curveDepth, size.height * 0.5),
      radius: const Radius.circular(curveRadius),
      clockwise: false,
    );
    path.arcToPoint(
      Offset(0, size.height * 0.5 - curveRadius),
      radius: const Radius.circular(curveRadius),
      clockwise: false,
    );

    // Continue left edge to top
    path.lineTo(0, cornerRadius);
    path.arcToPoint(
      Offset(cornerRadius, 0),
      radius: const Radius.circular(cornerRadius),
    );

    path.close();

    // Create shadow path (slightly offset)
    shadowPath.addPath(path, const Offset(0, 2));

    // Draw shadow
    canvas.drawPath(shadowPath, shadowPaint);

    // Draw main ticket shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter for dotted line
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}