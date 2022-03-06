// @dart=2.9
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/DataBseFile.dart';
import 'package:sailmanager/ScreensArts/Art1.dart';
import 'package:sailmanager/teeeee.dart';
import 'package:sailmanager/tetstst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ScreensArts/Art2.dart';


import '../Constants.dart';
import 'MainMap.dart';
class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {




  TextEditingController txt_1 =TextEditingController();
  TextEditingController txt_2 =TextEditingController();
  TextEditingController txt_3 =TextEditingController();


  Future Run ()async{
    if(txt_1.text.isEmpty)
      {
        ApiService.ShowSnackbar('آدرس سرور را وارد کنید');
        return;
      }


    print(txt_1.text);
    if(!txt_1.text.startsWith('https://')&&!txt_1.text.startsWith('http://'))
    {
      ApiService.ShowSnackbar('آدرس سرور اشتباه وارد شده است');
      return;
    }




    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(txt_2.text.isEmpty)
    {
      ApiService.ShowSnackbar('نام کاربری را وارد کنید');
      return;
    }


    if(txt_3.text.isEmpty)
    {
      ApiService.ShowSnackbar('رمز عبور را وارد کنید');
      return;
    }




    var  Login= await ApiService.Login(pr,txt_1.text,txt_2.text,txt_3.text);



    if(Login!=null)
    {
       if(Login.res)
         {





           var Baseurl= await Conv_English(txt_1.text.toString());
           var UserName= await Conv_English(txt_2.text.toString());
           var Password= await Conv_English(txt_3.text.toString());
           prefs.setString("Baseurl", Baseurl);
           prefs.setString("UserName", UserName);
           prefs.setString("Password", Password);
           prefs.setBool("Login",true);
           prefs.setBool("Remember",Remember);
           pr.hide();
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (context) => MainMap()),
             // MaterialPageRoute(builder: (context) => LoginScreen()),
                 (Route<dynamic> route) => false,
           );




         }else
           {
             ApiService.ShowSnackbar(Login.msg);
           }
    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }
      {}
  }





  bool Remember=false ;
  bool Personels=false ;
  var pr;


 Future  GetUser()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();

   var base =prefs.getString('Baseurl');
   var UserName =prefs.getString('UserName');
   var login =prefs.getBool('Login');
   if(prefs.getBool('Personels')!=null)
     {
       Personels =prefs.getBool('Personels')!;
     }



   if(base!=null)
     {
       txt_1.text=base;
     }
   if(login!=null)
     {
       Remember=login;
     }


   if(UserName!=null)
   {
     txt_2.text=UserName;
   }




   setState(() {

   });
 }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Align(
            alignment: Alignment.topRight,
            child: Text('مجوز',textAlign: TextAlign.right,)),
        content:
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Text('برای خروج از فرم اطمینان دارید?',textAlign: TextAlign.end,),
              ],
            ),
          ),
        )
        ,
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text('نه',style: TextStyle(fontSize: 16)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:  Text('بله',style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    GetUser();
  }
  @override
  Widget build(BuildContext context) {
    final SizeApp=MediaQuery.of(context).size;
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
           child:  Container(
             color: ColorBack,
             child: Stack(
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     CustomPaint(
                       size: Size(SizeApp.width, (SizeApp.height*0.15).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                       painter: Art1(),
                     ),
                     CustomPaint(
                       size: Size(SizeApp.width, (SizeApp.height*0.15).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                       painter: Art3(),
                     ),
                   ],
                 ),
                 Container(
                   margin: EdgeInsets.only(top:SizeApp.height*0.07),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Image.asset('images/slma.png',   width: SizeApp.width*0.30,
                           height: SizeApp.width*0.30),
                       Text('گروه نرم افزاری آتیران',
                         style: TextStyle(color: Color(0xff575757),
                             fontSize: 16,
                             fontWeight: FontWeight.bold),),
                       BoxInput('images/svg_aser.svg','آدرس سرور خود را وارد کنید','آدرس سرور',txt_1),
                       BoxInput('images/admin2.svg','نام کاربری خود را وارد کنید','نام کاربری',txt_2),
                       BoxInput('images/ghofl.svg','کلمه عبور خود را وارد کنید','کلمه عبور',txt_3),
                       Container(
                         margin: EdgeInsets.symmetric(horizontal: 16),
                         width: double.infinity,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Expanded(child: Text(
                               'مرا به خاطر بسپار',
                               textAlign: TextAlign.end,
                               style: TextStyle(
                                   color: BaseColor,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),
                             )),
                             Theme(
                               data: ThemeData(unselectedWidgetColor:  BaseColor),
                               child: Checkbox(
                                   value: Remember,
                                   onChanged: (val){
                                     setState(() {
                                       Remember=!Remember;
                                     });
                                   }),
                             )
                           ],
                         ),
                       ),
                       Container(
                         width: double.infinity,
                         margin: EdgeInsets.only(right: 16,left: 16,top: 32),
                         child: ElevatedButton(onPressed: Run,
                             style: ButtonStyle(
                               backgroundColor: MaterialStateProperty.all(BaseColor),
                               padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                     RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(24.0),

                                     )
                                 )
                             ),
                             child:Text('ورود',
                           style: TextStyle(color:Colors.white,
                               fontSize: 16,
                               fontWeight: FontWeight.bold),)),
                       )
                     ],
                   ),
                 ),
                 Positioned(
                   right: 8,
                   bottom: 8,
                   child: Text('نسخه 1.0.0',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                     fontSize: 16
                   ),),
                 )
               ],

             ),
           )

      ),
    );




  }
}



class BoxInput extends StatelessWidget {
   String  Icone;

   String Hint;

   String Title;


   TextEditingController txtc;


   BoxInput(this.Icone, this.Hint, this.Title,this.txtc);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: BaseColor,width: 2),
        boxShadow: [
          BoxShadow(
            color: BaseColor.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 8
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(Title,
              style: TextStyle(color: BaseColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),),
            Divider(height: 10,),
            Row(
              children: [
                Expanded(child: TextField(
                  controller: txtc,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
              border: InputBorder.none,
              hintText:Hint,
                    hintStyle: TextStyle(
                      color: Color(0xffAEAEAE)
                    )
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Icone,width: 15,height: 15,color: BaseColor,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


