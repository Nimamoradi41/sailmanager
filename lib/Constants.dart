import 'package:flutter/cupertino.dart';


    final Color BaseColor=const Color(0xff3D4785);
    final Color ColorLine=const Color(0xffEFEFEF);
    final Color ColorBack=const Color(0xffF1F7FE);
    final Color ColorFirst=const Color(0xff8E8E8E);
    final Color ColorSecond=const Color(0xff414141);
    final double SizeFirst=  11;
    final double SizeSecond=  13;
    final double SizeResponsive=  9;

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

Future<String>  Conv_English(String S) async{
    var dd = '';
// ۱۲۳۴۵۶۷۸۹
    List<String> Departments = <String>[];
// for (i in S) {
    for (int i=0;i<S.length;i++) {
        if (S[i] == '۱') {
            dd = dd + '1';

        } else if (S[i] == '۲') {

            dd = dd + '2';

        } else if (S[i] == '۳') {
            dd = dd + '3';

        } else if (S[i] == '۰') {
            dd = dd + '0';

        } else if (S[i] == '۴') {
            dd = dd + '4';

        } else if (S[i] == '۵') {
            dd = dd + '5';

        } else if (S[i] == '۶') {
            dd = dd + '6';

        } else if (S[i] == '۷') {
            dd = dd + '7';


        } else if (S[i] == '۸') {
            dd = dd + '8';

        } else if (S[i] == '۹') {
            dd = dd + '9';
        } else {
            dd = dd + S[i].toString();
        }


    }
    return  dd;
}