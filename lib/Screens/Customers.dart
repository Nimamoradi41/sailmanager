import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/DataBseFile.dart';
import 'package:sailmanager/Models/CustGroup.dart';
import 'package:sailmanager/Models/CustGroup.dart';
import 'package:sailmanager/Models/CustGroup.dart';
import 'package:sailmanager/Models/ListCustomer.dart';
import 'package:sailmanager/Models/ModelCity.dart';
import 'package:sailmanager/Models/ModelProvice.dart';
import 'package:sailmanager/Models/ModelRegion.dart';
import 'package:sailmanager/Models/ModelWay.dart';
import 'package:sailmanager/Screens/PishFactorsCustomer.dart';
import 'package:sailmanager/Screens/ScreenState.dart';
import 'package:sailmanager/Screens/ScreenWay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
import 'ScreenCity.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {



 Future GetGroups(double s)async {

   SharedPreferences prefs = await SharedPreferences.getInstance();
   var base =prefs.getString('Baseurl');
   var UserName =prefs.getString('UserName');
   var Password =prefs.getString('Password');
   var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
   var Data=await ApiService.CustGroup(pr, base!, UserName!, Password!);

   pr.hide();
   if(Data!=null)
   {
     if(Data.code==200)
     {
       ReCustGroup.addAll(Data.res);
       ReCustGroup.forEach((element) {
         spinnerItems.add(element.name);
       });
       setState(() {

       });

       if(ReRe_Provice.length>2)
         {
           ShowModall_CusGroups(ReCustGroup,s);
         }else{
         GetProvi(s);
       }

     }
   }
 }


 var base ="";
 var UserName ="";
 var Password ="";

 Future GetProvi(double s)async {



   SharedPreferences prefs = await SharedPreferences.getInstance();
     base =prefs.getString('Baseurl')!;
     UserName =prefs.getString('UserName')!;
     Password =prefs.getString('Password')!;
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
   var Data=await ApiService.GetProvice(pr, base, UserName, Password);

   pr.hide();
   if(Data!=null)
   {
     if(Data.code==200)
     {
       ReRe_Provice.addAll(Data.res);
       ReRe_Provice.forEach((element) {
         spinnerItems_Provice.add(element.name);
       });

       if(ReRe_Provice.length>0)
         {
           dropdownProvice=ReRe_Provice[0].name;
           IdProvine=ReRe_Provice[0].id;
         }


       setState(() {

       });
       ShowModall_CusGroups(ReCustGroup,s);
     }
   }
 }



 Future<void> openMap(double latitude, double longitude) async {
   String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
   if (await canLaunch(googleUrl)) {
     await launch(googleUrl);
   } else {
     throw 'Could not open the map.';
   }
 }


  List<Re_Customer> MyData=[];
  List<Re_Customer> MyDataSourch=[];
  List<ReCustGroup_2> ReCustGroup=[];
  List<Re_Provice> ReRe_Provice=[];
  List<ReC_City> ReRe_ReC=[];
  List <String> spinnerItems = [
  ] ;


 List <String> spinnerItems_Provice = [
 ] ;

  List <String> StatusAccont = [
    'همه',
    'بدهکار',
    'بستانکار',
  ] ;
  String dropdownValue = 'همه';
  String dropdownProvice = '';
  String StatusAccontValue = 'همه';
  String flagAccount = '0';
  String groupId = '-1';

  String IdProvine="-1";
  String IdCity="-1";
  String IdState="-1";
  String IdWay="-1";
  String NameCity="شهر را انتخاب کنید";
  String NameState="منطقه را انتخاب کنید";
  String NameWay="مسیر را انتخاب کنید";


  ShowModall_CusGroups(List<ReCustGroup_2> data,double Sizewid)
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  StatefulBuilder(
          builder: (BuildContext context, setState)=> Container(
          margin: EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('وضعیت حساب',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:BaseColor,
                                decoration: TextDecoration.none),),
                        ),
                        DropdownButton<String>(
                          value: StatusAccontValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 2,
                          alignment: Alignment.center,
                          style: TextStyle(color: BaseColor,
                              fontSize: 12,fontFamily: 'iransans'),
                          onChanged: (s){
                            setState(() {
                              if(s.toString()=='همه')
                                {
                                  flagAccount="0";
                                }

                              if(s.toString()=='بدهکار')
                              {
                                flagAccount="1";
                              }


                              if(s.toString()=='بستانکار')
                              {
                                flagAccount="2";
                              }

                              StatusAccontValue = s.toString();
                            });
                          },
                          underline:  Container(color: Colors.transparent),
                          items: StatusAccont.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      color: ColorLine
                      ,width: 2,
                      height: Sizewid*1/7),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('گروه مشتری',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:BaseColor,
                                decoration: TextDecoration.none),),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 2,
                          alignment: Alignment.center,
                          style: TextStyle(color: BaseColor, fontSize: 12,fontFamily: 'iransans'),
                          onChanged: (s){
                            setState(() {
                              var dds=ReCustGroup.where((element) =>element==s.toString()).toList();
                              if(dds.length>0)
                                {
                                  groupId=dds[0].id.toString();
                                }
                              dropdownValue = s.toString();
                            });
                          },
                          underline:  Container(color: Colors.transparent),
                          items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      color: ColorLine
                      ,width: 2,
                      height: Sizewid*1/7),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('استان',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:BaseColor,
                                decoration: TextDecoration.none),),
                        ),
                        DropdownButton<String>(
                          value: dropdownProvice,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 2,
                          alignment: Alignment.center,
                          style: TextStyle(color: BaseColor, fontSize: 12,fontFamily: 'iransans'),
                          onChanged: (s){
                            setState(() {
                              var ds=ReRe_Provice.where((element) => element.name==s.toString()).toList();
                              if(ds.length>0)
                                {
                                  IdProvine=ds[0].id;
                                }
                              dropdownProvice = s.toString();
                            });
                          },
                          underline:  Container(color: Colors.transparent),
                          items: spinnerItems_Provice.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: GestureDetector(
                      onTap: () async{
                        if(IdProvine.isNotEmpty)
                          {
                            var resuilt= await    Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => ScreenCity(IdProvine,dropdownProvice) ));

                            if(resuilt!=null)
                              {
                                ReC_City model=resuilt;
                                if(model.id!=null){
                                  setState(() {
                                    IdCity=model.id;
                                    NameCity=model.name;
                                  });

                                }
                              }
                          }else{
                          ApiService.ShowSnackbar('ابتدا استان را انتخاب کنید');
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BaseColor,width: 2),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Text(NameCity,
                                textAlign: TextAlign.center,)),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.arrow_circle_down_outlined,color: BaseColor, size: 20,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('شهر',
                        textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: GestureDetector(
                      onTap: () async{
                        if(IdCity.isNotEmpty)
                        {
                          var resuilt= await    Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ScreenState(IdCity,NameCity) ));

                          if(resuilt!=null)
                          {
                            ReRegion model=resuilt;
                            if(model.id!=null){
                              setState(() {
                                IdState=model.id;
                                NameState=model.name;
                              });

                            }
                          }
                        }else{
                          ApiService.ShowSnackbar('ابتدا شهر را انتخاب کنید');
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BaseColor,width: 2),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Text(NameState,
                                textAlign: TextAlign.center,)),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.arrow_circle_down_outlined,color: BaseColor, size: 20,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('منطقه',
                        textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: GestureDetector(
                      onTap: () async{
                        if(IdState.isNotEmpty)
                        {
                          var resuilt= await    Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ScreenWay(IdState,NameState) ));
                          if(resuilt!=null)
                          {
                            ReWay model=resuilt;
                            if(model.id!=null){
                              setState(() {
                                IdWay=model.id;
                                NameWay=model.name;
                              });

                            }
                          }
                        }else{
                          ApiService.ShowSnackbar('ابتدا منطقه را انتخاب کنید');
                        }

                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: BaseColor,width: 2),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Text(NameWay,
                                textAlign: TextAlign.center,)),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.arrow_circle_down_outlined,color: BaseColor, size: 20,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('مسیر',
                        textAlign: TextAlign.center,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ) ;
    });
  }





  ShowModall_GetPrivice(List<Re_Provice> data)
  {

    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.builder(
          // itemCount: Departments.length,
          itemCount: data.length,
          itemBuilder: (ctx,item){
            return Container(
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: ()
                {
                  Provicemain=data[item].id ;

                },
                child: Column(
                  children: [
                    Text(data[item].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:BaseColor,
                          decoration: TextDecoration.none),),
                    Divider(),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            );
          },
        ),
      ) ;
    });
  }



  ShowModall_GetCity(List<ReC_City> data)
  {

    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        margin: EdgeInsets.only(top: 16),
        child: ListView.builder(
          // itemCount: Departments.length,
          itemCount: data.length,
          itemBuilder: (ctx,item){
            return Container(
              child: InkWell(
                highlightColor: Colors.transparent,
                onTap: ()
                {
                  Citymain=data[item].id as int ;

                },
                child: Column(
                  children: [
                    Text(data[item].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:BaseColor,
                          decoration: TextDecoration.none),),
                    Divider(),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            );
          },
        ),
      ) ;
    });
  }




  int Groupmain=-1;
  String Provicemain='-1';
  int Citymain=-1;
  Future GetData()async{
     var Data=await DataBseFile().GetCustomer();
     var Data2=await DataBseFile().GetCusgroups();
     var Data3=await DataBseFile().GetPrivice();
     var Data4=await DataBseFile().GetCity();
     ReCustGroup.add(ReCustGroup_2(id: -1, name: 'همه'));
     // ReRe_Provice.add(Re_Provice(id:'-7', name: 'همه'));
     // ReRe_ReC.add(ReC_City(id: -7,name:'' ,provinceId: -7));
     // ReCustGroup.addAll(Data2);
     // ReRe_Provice.addAll(Data3);
     // ReRe_ReC.addAll(Data4);
     // if(Data!=null)
     //   {
     //     print(Data.length.toString());
     //     if(Data.length>0)
     //       {
     //         MyData=Data;
     //         MyDataSourch=Data;
     //         setState(() {
     //         });
     //       }
     //   }
  }






  Future get2()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    base =prefs.getString('Baseurl')!;
    UserName =prefs.getString('UserName')!;
    Password =prefs.getString('Password')!;
    Run22();
  }

  late ProgressDialog pr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
    get2();
       pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
  }


  Future Run22()async{
    var MyDataCustomer = await ApiService.GetCustomer( base, UserName, Password, groupId,
        IdProvine, IdCity, IdState, IdWay,'',flagAccount.toString(),true,pr);
    if(MyDataCustomer!=null)
    {
      if(MyDataCustomer.res.length==0)
      {

        MyData.clear();
        MyDataSourch.clear();
        setState(() {
        });
      }else{
        setState(() {
          MyDataSourch=MyDataCustomer.res;
          MyData=MyDataCustomer.res;
        });
      }
    }else{
      MyData.clear();
      MyDataSourch.clear();
    }


    setState(() {

    });
  }




  List<Re_Customer> MyDataCustomer=[];




  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
    final oCcy = new NumberFormat(",###", "en_US");
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorBack,
        body: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back,color: BaseColor,),
                        ),
                        Expanded(
                          child: Card(
                           margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            child: TextField(
                              textAlign: TextAlign.end,
                              onChanged: (val) async{
                                if(val.isNotEmpty)
                                {
                                  // val=val.replaceAll('ی','ي');
                                  // val=val.replaceAll('ک','ك');
                                  var MyDataCustomer = await ApiService.GetCustomer( base, UserName, Password, groupId,
                                      IdProvine, IdCity, IdState, IdWay,val.toString(),flagAccount.toString(),false,pr);
                                  if(MyDataCustomer!=null)
                                    {
                                      if(MyDataCustomer.res.length==0)
                                      {

                                        MyData.clear();
                                        MyDataSourch.clear();
                                        setState(() {
                                        });
                                      }else{
                                        setState(() {
                                          MyDataSourch=MyDataCustomer.res;
                                          MyData=MyDataCustomer.res;
                                        });
                                      }
                                    }else{
                                    MyData.clear();
                                    MyDataSourch.clear();
                                  }

                                  setState(() {

                                  });
                                }else{
                                  MyDataSourch.clear();
                                  // print(Customer.length.toString());
                                  setState(() {

                                  });

                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Color(0xff1F3C84).withOpacity(0.80)
                                  ),
                                  hintText: 'مشتری خود را جستجو کنید...'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child:   MyDataSourch.length>0? ListView.builder(
                        itemCount: MyDataSourch.length,
                        itemBuilder: (Ctx,Item){

                          return  BoxInfo78(Sizewid,MyDataSourch[Item].name.trim(),'',MyDataSourch[Item].tell1,MyDataSourch[Item].tell2,
                              MyDataSourch[Item].address.trim(),(){
                                print('dlvl,dvl,,ldlv,');
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => PishFactorsCustomer(MyDataSourch[Item].id) ));
                              },(){

                            if(MyDataSourch[Item].lat==null||MyDataSourch[Item].lng==null)
                              return;

                            if(MyDataSourch[Item].lat!=0&&MyDataSourch[Item].lng!=0)
                              {
                                openMap(MyDataSourch[Item].lat, MyDataSourch[Item].lng);
                              }

                              },MyDataSourch[Item].id,

                              MyDataSourch[Item].man.contains('.')?

                              oCcy.format(int.parse(MyDataSourch[Item].man.replaceAll('.','')))
                                  :''
                              
                              ,MyDataSourch[Item].lat,MyDataSourch[Item].lng);
                        },
                      ):Center(
                        child:  Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('images/noting.svg',width: 150,height: 150,),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24.0),
                                child: Text('محتوایی برای نمایش وجود ندارد',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: SizeFirst,
                                      fontWeight: FontWeight.bold,
                                      color: BaseColor
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.only(right: 8,left: 8,top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Run22();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: BaseColor.withOpacity(0.25),
                                              spreadRadius: 2,
                                              blurRadius: 8
                                          )
                                        ],
                                        color: BaseColor,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Icon(Icons.refresh,color: Colors.white,size: 25,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('دریافت اطلاعات',
                                      textAlign: TextAlign.center,
                                      style:
                                    TextStyle(
                                        color: ColorFirst,
                                        fontSize: 12
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                if(ReCustGroup.length>2)
                                  {
                                    ShowModall_CusGroups(ReCustGroup,Sizewid);
                                  }else{
                                  GetGroups(Sizewid);
                                }

                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: BaseColor.withOpacity(0.25),
                                              spreadRadius: 2,
                                              blurRadius: 8
                                          )
                                        ],
                                        color: BaseColor,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset('images/cate23.svg',width: 15,height: 15,color: Colors.white,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text('فیلتر',
                                      textAlign: TextAlign.center,
                                      style:
                                      TextStyle(
                                          color: ColorFirst,
                                          fontSize: 12
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: Sizewid*1/SizeResponsive,
                            width: 2,
                            color: ColorLine,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text('تعداد مشتری',
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(
                                        color: ColorFirst,
                                        fontSize: 12
                                    ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(MyDataSourch.length.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                    TextStyle(
                                        color: ColorFirst,
                                        fontSize: 12
                                    ),),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                )

            )
          ],
        )
      ),
    );
  }
}

class BoxInfo78 extends StatelessWidget {


  final double Sizewid;
  final String NameMoshtari;
  final String Mobile;
  final String Tel1;
  final String Tel2;
  final String Address;
  final   VoidCallback  Factors;
  final VoidCallback Location;
  final String ID;
  final String Mande;
  final double lat;
  final double lng;



  BoxInfo78(this.Sizewid, this.NameMoshtari, this.Mobile, this.Tel1, this.Tel2,
      this.Address, this.Factors, this.Location,this.ID,this.Mande,this.lat,this.lng);



  _launchCaller3(String string2) async {
    String url = 'tel:'+string2;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Not CAnt');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: BaseColor.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 8
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('مانده',style:
                      TextStyle(
                          color: ColorFirst,
                          fontSize: SizeFirst
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0,left: 4,right: 4),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(Mande==null||
                              Mande.isEmpty?'نامشخص':

                          Mande,
                            textAlign: TextAlign.center,
                            style:
                          TextStyle(
                              color: ColorSecond,
                              fontSize: SizeSecond
                          ),),
                        ),
                      )
                    ],
                  )),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      color: ColorLine
                      ,width: 2,
                      height: Sizewid*1/10),
                  Expanded(
                      flex: 8,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('مشتری',style:
                      TextStyle(
                          color: ColorFirst,
                          fontSize: SizeFirst
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(NameMoshtari==null||
                              NameMoshtari.isEmpty?'نامشخص':
                          NameMoshtari,style:
                          TextStyle(
                              color: ColorSecond,
                              fontSize: SizeSecond
                          ),),
                        ),
                      )
                    ],
                  ))

                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                color: ColorLine
                ,width: double.infinity,
                height: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text('موبایل',style:
                        TextStyle(
                            color: ColorFirst,
                            fontSize: SizeFirst
                        ),),
                        GestureDetector(
                          onTap: (){
                            if(Mobile.isNotEmpty)
                              {
                                _launchCaller3(Mobile);
                              }

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(Mobile==null||
                                  Mobile.isEmpty?'نامشخص':
                              Mobile,
                                style:
                              TextStyle(
                                  color: ColorSecond,
                                  fontSize: SizeSecond
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      color: ColorLine
                      ,width: 2,
                      height: Sizewid*1/10),
                  Expanded(
                    child: Column(
                      children: [
                        Text('تلفن ۲',style:
                        TextStyle(
                            color: ColorFirst,
                            fontSize: SizeFirst
                        ),),
                        GestureDetector(
                          onTap: (){
                            if(Tel2.isNotEmpty)
                            {
                              print('89');
                              _launchCaller3(Tel1);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(Tel2==null||
                                  Tel2.isEmpty?'نامشخص':
                              Tel2,style:
                              TextStyle(
                                  color: ColorSecond,
                                  fontSize: SizeSecond
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      color: ColorLine
                      ,width: 2,
                      height: Sizewid*1/10),
                  Expanded(
                    child: Column(
                      children: [
                        Text('تلفن ۱',style:
                        TextStyle(
                            color: ColorFirst,
                            fontSize: SizeFirst
                        ),),
                        GestureDetector(
                          onTap: (){
                            if(Tel1.isNotEmpty)
                            {
                              print('89');
                              _launchCaller3(Tel1);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(Tel1==null||
                                  Tel1.isEmpty?'نامشخص':
                              Tel1,style:
                              TextStyle(
                                  color: ColorSecond,
                                  fontSize: SizeSecond
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                color: ColorLine
                ,width: double.infinity,
                height: 2),
            Row(
              children: [
                GestureDetector(
                  onTap: Factors,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset('images/pishfactors.svg',width: 20,height: 25,),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                    color: ColorLine
                    ,width: 2,
                    height:  Sizewid*1/10),
                lat!=null && lat>0?
                GestureDetector(
                  onTap: Location,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset('images/locsale.svg',width: 25,height: 25,),
                  ),
                ):Container(),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('آدرس',style:
                      TextStyle(
                          color: ColorFirst,
                          fontSize: SizeFirst
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0,left: 8,right: 8),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(Address==null||
                              Address.isEmpty?'نامشخص':
                          Address,style:
                          TextStyle(
                              color: ColorSecond,
                              fontSize: SizeSecond
                          ),),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
