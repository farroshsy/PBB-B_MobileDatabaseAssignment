import 'package:flutter/material.dart';

/// Chart displaying performance metrics
class PerformanceChart extends StatelessWidget {
  /// Creates a performance chart
  const PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: _ChartPainter(),
        child: const Center(
          child: Text(
            'Performance Chart',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

/// Custom painter for chart visualization
class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // This is a placeholder chart painter
    // In a real implementation, this would use actual data
    
    final paint = Paint()
      ..color = Colors.blue.withAlpha(128)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.2, size.height * 0.6);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.2);
    
    canvas.drawPath(path, paint);
    
    // Draw filled area
    final fillPaint = Paint()
      ..color = Colors.blue.withAlpha(26)
      ..style = PaintingStyle.fill;
    
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    
    canvas.drawPath(fillPath, fillPaint);
    
    // Draw axes
    final axesPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    
    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, size.height),
      axesPaint,
    );
    
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axesPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
