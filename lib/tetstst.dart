import 'dart:ui' as ui;

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(WIDTH, (WIDTH*0.5666666666666667).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.4611111,size.height*0.3750529);
    path_0.cubicTo(size.width*0.2122222,size.height*0.4691706,size.width*0.05000000,size.height*0.8015245,0,size.height*0.9559363);
    path_0.lineTo(0,size.height*0.08828824);
    path_0.cubicTo(0,size.height*0.01769985,size.width*0.02685186,size.height*0.00005291863,size.width*0.04027778,size.height*0.00005300245);
    path_0.cubicTo(size.width*0.3226861,size.height*0.0008699951,size.width*0.8991667,size.height*0.002013784,size.width*0.9458333,size.height*0.00005300245);
    path_0.cubicTo(size.width*1.004167,size.height*-0.002397980,size.width,size.height*0.08093529,size.width*0.9986111,size.height*0.08828824);
    path_0.cubicTo(size.width*0.9972222,size.height*0.09564118,size.width*0.7722222,size.height*0.2574059,size.width*0.4611111,size.height*0.3750529);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff3D4785).withOpacity(1.0);
    canvas.drawShadow(path_0,Colors.black,16, true);
    canvas.drawPath(path_0,paint_0_fill);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}