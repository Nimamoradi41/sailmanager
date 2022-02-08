import 'dart:ui' as ui;

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(WIDTH, (WIDTH*0.5194444444444445).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class Art1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.3040389,size.height*0.4732620);
    path_0.cubicTo(size.width*0.1456033,size.height*0.6080214,size.width*0.03533167,size.height*0.8520481,0,size.height*0.9572193);
    path_0.lineTo(0,size.height*-0.01069519);
    path_0.lineTo(size.width*1.005556,size.height*-0.01069519);
    path_0.cubicTo(size.width*0.9971889,size.height*0.01426027,size.width*0.9712472,size.height*0.07593583,size.width*0.9344278,size.height*0.1229947);
    path_0.cubicTo(size.width*0.8884028,size.height*0.1818182,size.width*0.7810139,size.height*0.2219251,size.width*0.6778083,size.height*0.2593583);
    path_0.cubicTo(size.width*0.5746028,size.height*0.2967914,size.width*0.5020806,size.height*0.3048128,size.width*0.3040389,size.height*0.4732620);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff3D4785).withOpacity(1.0);

    canvas.drawPath(path_0,paint_0_fill);
    // canvas.drawShadow(path_0, Colors.black, 16, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}