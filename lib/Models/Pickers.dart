
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// import 'package:persian_datetimepickers/persian_datetimepickers.dart';
// import 'package:shamsi_date/extensions.dart';


// import 'package:shamsi_date/extensions.dart';



import '../Constants.dart';






Future  dataaaa(BuildContext context,Function function)async{
  Jalali? picked = await showPersianDatePicker(
    context: context,
    initialDate: Jalali.now(),
    firstDate: Jalali(1385, 8),
    lastDate: Jalali(1450, 9),
  );



  if(picked!=null)
  {
    var Data=Convert_DATE(picked.day.toString(), picked.month.toString(), picked.year.toString());
    var Data_En= Convert_DATE(picked.toGregorian().day.toString(),picked.toGregorian().month.toString(),picked.toGregorian().year.toString());
    function(Data,Data_En);
  }


}

class Pickers   {
  static String _format = 'yyyy-mm-dd';
   static void showDatePicker_To(BuildContext context,Function function) {
    final bool showTitleActions = false;
        dataaaa(context,function);



//     DatePicker.showDatePicker(context,
//         minYear: 1300,
//         maxYear: 1450,
// /*      initialYear: 1368,
//       initialMonth: 05,
//       initialDay: 30,*/
//         confirm: Text(
//           'تایید',
//           style: TextStyle(color: Colors.red),
//         ),
//         cancel: Text(
//           'لغو',
//           style: TextStyle(color: Colors.cyan),
//         ),
//         dateFormat: _format, onChanged: (year, month, day) {
//           if (!showTitleActions) {
//             // _changeDatetime(year, month, day);
//           }
//         }, onConfirm: (year, month, day) {
//           // _changeDatetime(year, month, day);
//           var Data=Convert_DATE(day.toString(), month.toString(), year.toString());
//           function(Data);
//           // setState(() {
//           //   DATA=Data;
//           //   creationDate=DATA;
//           // });
//
//
//           // _valuePiker =
//           // " تاریخ ترکیبی : $_datetime  \n سال : $year \n  ماه :   $month \n  روز :  $day";
//         });
  }

  static void showDatePicker_DeadLine(BuildContext context,Function function) {
    final bool showTitleActions = false;
       dataaaa(context, function) ;


    }

  }


