import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/DataBseFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../Constants.dart';


class ScreenSetting extends StatefulWidget {



  @override
  State<ScreenSetting> createState() => _ScreenSettingState();
}

class _ScreenSettingState extends State<ScreenSetting> {


  String CustomerRefTime='هرگز';
  String PersonelsRefTime='';
  String CustGroupRefTime='';
  String ProviceRefTime='';
  String CityRefTime='';


  Future RunCustomer()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Baseurl=  prefs.getString("Baseurl");
    String? UserName=  prefs.getString("UserName");
    String? Password=   prefs.getString("Password");
    ProgressDialog  pr3 = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
   //  var Data=await ApiService.GetCustomer(pr3,Baseurl!,UserName!,Password!,"0","",0);
     String TimeDate= await DataBseFile().SendRequestCustomer(pr3,"0",0);

     print('scsccscscssccscscs'+TimeDate);
     if(TimeDate.isNotEmpty)
       {
          prefs.setString("CustomerRefTime",TimeDate);
          CustomerRefTime=TimeDate;
          setState(() {
          });
       }



  }



  Future RunPersonels()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Baseurl=  prefs.getString("Baseurl");
    String? UserName=  prefs.getString("UserName");
    String? Password=   prefs.getString("Password");
    ProgressDialog  pr3 = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    //  var Data=await ApiService.GetCustomer(pr3,Baseurl!,UserName!,Password!,"0","",0);
    String TimeDate= await DataBseFile().SendRequestPersonel(pr3);

    print('scsccscscssccscscs'+TimeDate);
    if(TimeDate.isNotEmpty)
    {
      prefs.setString("PersonelsRefTime",TimeDate);
      PersonelsRefTime=TimeDate;
      setState(() {

      });
    }



  }




  Future RunCustGroup()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Baseurl=  prefs.getString("Baseurl");
    String? UserName=  prefs.getString("UserName");
    String? Password=   prefs.getString("Password");
    ProgressDialog  pr3 = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    //  var Data=await ApiService.GetCustomer(pr3,Baseurl!,UserName!,Password!,"0","",0);
    String TimeDate= await DataBseFile().SendRequestCustGroups(pr3);

    print('scsccscscssccscscs'+TimeDate);
    if(TimeDate.isNotEmpty)
    {
      prefs.setString("CustGroupRefTime",TimeDate);
      CustGroupRefTime=TimeDate;
      setState(() {

      });
    }
  }


  Future RunProvince()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Baseurl=  prefs.getString("Baseurl");
    String? UserName=  prefs.getString("UserName");
    String? Password=   prefs.getString("Password");
    ProgressDialog  pr3 = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    //  var Data=await ApiService.GetCustomer(pr3,Baseurl!,UserName!,Password!,"0","",0);
    String TimeDate= await DataBseFile().SendRequestProvice(pr3);
    print('scsccscscssccscscs'+TimeDate);
    if(TimeDate.isNotEmpty)
    {
      prefs.setString("ProviceRefTime",TimeDate);
      ProviceRefTime=TimeDate;
      setState(() {

      });
    }
  }

  Future RunCity()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Baseurl=  prefs.getString("Baseurl");
    String? UserName=  prefs.getString("UserName");
    String? Password=   prefs.getString("Password");
    ProgressDialog  pr3 = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    //  var Data=await ApiService.GetCustomer(pr3,Baseurl!,UserName!,Password!,"0","",0);
    String TimeDate= await DataBseFile().SendRequestCity(pr3,"0",0);

    print('scsccscscssccscscs'+TimeDate);
    if(TimeDate.isNotEmpty)
    {
      prefs.setString("CityRefTime",TimeDate);
      CityRefTime=TimeDate;
      setState(() {
      });
    }



  }


  Future getDatRef() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? CustomerRefTime2=  prefs.getString("CustomerRefTime");
    String? PersonelsRefTime2=  prefs.getString("PersonelsRefTime");
    String? CustGroupRefTime2=  prefs.getString("CustGroupRefTime");
    String? ProviceRefTime2=  prefs.getString("ProviceRefTime");
    String? CityRefTime2=  prefs.getString("CityRefTime");
    if(CustomerRefTime2!=null)
      {
        CustomerRefTime=CustomerRefTime2;
      }


    if(PersonelsRefTime2!=null)
    {
      PersonelsRefTime=PersonelsRefTime2;
    }


    if(CustGroupRefTime2!=null)
    {
      CustGroupRefTime=CustGroupRefTime2;
    }


    if(ProviceRefTime2!=null)
    {
      ProviceRefTime=ProviceRefTime2;
    }

    if(CityRefTime2!=null)
    {
      CityRefTime=CityRefTime2;
    }







    setState(() {

    });

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getDatRef();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('تنظیمات',style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),),
        ),
        backgroundColor: BaseColor,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      backgroundColor: ColorBack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            RowSetting('لیست مشتریان',CustomerRefTime,(){
              RunCustomer();
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 10,color: Color(0xffDEDEDE),),
            ),
            RowSetting('لیست پرسنل',PersonelsRefTime.isEmpty?'هرگز':PersonelsRefTime ,(){
              RunPersonels();
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 10,color: Color(0xffDEDEDE),),
            ),
            RowSetting('گروه مشتری',CustGroupRefTime.isEmpty?'هرگز':CustGroupRefTime ,(){
              RunCustGroup();
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 10,color: Color(0xffDEDEDE),),
            ),
            RowSetting('استان ها',ProviceRefTime.isEmpty?'هرگز':ProviceRefTime ,(){
               RunProvince();
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 10,color: Color(0xffDEDEDE),),
            ),
            RowSetting('شهر ها',CityRefTime,(){
                RunCity();
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 10,color: Color(0xffDEDEDE),),
            ),
            RowSetting('منطقه','هرگز',(){

            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 10,color: Color(0xffDEDEDE),),
            ),
            RowSetting('مسیر','هرگز',(){

            }),
          ],
        ),
      ),
    );
  }
}

class RowSetting extends StatelessWidget {

  String title,data;


  final VoidCallback callback;

  RowSetting(this.title, this.data,this.callback);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap:  callback,
            child: Container(
              decoration: BoxDecoration(
                color: BaseColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.refresh,color: Colors.white,size: 25,),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title,style: TextStyle(
                    color: BaseColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0,left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(data,
                            style: TextStyle(
                                color: BaseColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            )),
                        Text('آخرین بروزرسانی',
                            style: TextStyle(
                                color: Color(0xffBEBEBE),
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
