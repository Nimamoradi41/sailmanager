import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';



//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.5381444,size.height*0.6231527);
    path_0.cubicTo(size.width*0.7870333,size.height*0.5285714,size.width*0.9492556,size.height*0.1945813,size.width*0.9992556,size.height*0.03940877);
    path_0.lineTo(size.width*0.9992556,size.height*0.9113300);
    path_0.cubicTo(size.width*0.9992556,size.height*0.9822660,size.width*0.9724056,size.height,size.width*0.9589778,size.height);
    path_0.cubicTo(size.width*0.6765722,size.height*0.9991773,size.width*0.1000897,size.height*0.9980296,size.width*0.05342306,size.height);
    path_0.cubicTo(size.width*-0.004910278,size.height*1.002463,size.width*-0.0007436111,size.height*0.9187192,size.width*0.0006452778,size.height*0.9113300);
    path_0.cubicTo(size.width*0.002034167,size.height*0.9039409,size.width*0.2270342,size.height*0.7413793,size.width*0.5381444,size.height*0.6231527);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff3D4785).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}