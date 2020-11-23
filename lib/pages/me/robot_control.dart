import 'dart:math';

import 'package:flutter/material.dart';

class RobotControlWidget extends StatefulWidget {
  final double zoneR;
  final double handleR;
  final Function(double, double) onRobotControlListener;

  RobotControlWidget({this.zoneR = 60.0, this.handleR = 30.0, this.onRobotControlListener});

  _RobotControlWidgetState createState() => _RobotControlWidgetState();
}

class _RobotControlWidgetState extends State<RobotControlWidget> {
  double zoneR;
  double handleR;
  double centerX = 0.0;
  double centerY = 0.0;

  @override
  void initState() {
    zoneR = widget.zoneR;
    handleR = widget.handleR;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (d) => reset(),
      onPanUpdate: (d) => parse(d.localPosition),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: CustomPaint(
          painter: _RobotControlView(
              zoneR: zoneR,
              handleR: handleR,
              centerX: centerX,
              centerY: centerY),
        ),
      ),
    );
  }

  reset() {
    centerY = 0;
    centerX = 0;
    setState(() {});
  }

  double get maxR => zoneR + handleR;

  parse(Offset offset) {
    centerX = offset.dx - maxR;
    centerY = offset.dy - maxR;
    var rad = atan2(centerX, centerY);
    // if (centerX < 0) {
    //   rad += 2 * pi;
    // }

    var thta = rad - pi / 2;
    var len = sqrt(centerX*centerX + centerY*centerY);

    if (len > zoneR) {
      centerX = zoneR * cos(thta);
      centerY = -zoneR * sin(thta);
    }

    if (widget.onRobotControlListener != null){
      widget.onRobotControlListener(rad, len/zoneR);
    }
    setState(() {});
  }
}

class _RobotControlView extends CustomPainter {
  var _paint = Paint();
  var zoneR;
  var handleR;
  var centerX;
  var centerY;
  _RobotControlView({this.zoneR, this.handleR, this.centerY, this.centerX}) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  double get maxR => zoneR + handleR;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(maxR, maxR);
    _paint.color = _paint.color.withAlpha(100);
    canvas.drawCircle(Offset(0, 0), zoneR, _paint);
    _paint.color = _paint.color.withAlpha(200);
    canvas.drawCircle(Offset(centerX, centerY), handleR, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
