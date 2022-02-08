import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(WIDTH, (WIDTH*0.5361111111111111).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class Art3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.6934417,size.height*0.5621762);
    path_0.cubicTo(size.width*0.8531889,size.height*0.4316062,size.width*0.9643750,size.height*0.1951642,size.width,size.height*0.09326425);
    path_0.lineTo(size.width,size.height*1.031088);
    path_0.lineTo(size.width*-0.01388889,size.height*1.031088);
    path_0.cubicTo(size.width*-0.005451528,size.height*1.006907,size.width*0.02070431,size.height*0.9471503,size.width*0.05782861,size.height*0.9015544);
    path_0.cubicTo(size.width*0.1042342,size.height*0.8445596,size.width*0.2125136,size.height*0.8056995,size.width*0.3165750,size.height*0.7694301);
    path_0.cubicTo(size.width*0.4206361,size.height*0.7331606,size.width*0.4937583,size.height*0.7253886,size.width*0.6934417,size.height*0.5621762);
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