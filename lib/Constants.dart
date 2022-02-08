import 'package:flutter/cupertino.dart';


    final Color BaseColor=const Color(0xff3D4785);
    final Color ColorLine=const Color(0xffEFEFEF);
    final Color ColorBack=const Color(0xffF1F7FE);
    final Color ColorFirst=const Color(0xff8E8E8E);
    final Color ColorSecond=const Color(0xff414141);
    final double SizeFirst=  12;
    final double SizeSecond=  14;

String    Convert_DATE(String day,String month,String year)
{
    var temp_day="";
    var temp_mont="";
    if (day.length==1)
    {
        temp_day="0"+day;
    }else{
        temp_day=day;
    }
    if (month.length==1)
    {
        temp_mont="0"+month;
    }else{
        temp_mont=month;
    }





    return  (year+"/"+temp_mont+"/"+temp_day).toString();


}

