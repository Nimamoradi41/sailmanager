import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/Models/ModelFactorsAll.dart';
import 'package:sailmanager/Models/Pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../Constants.dart';
import 'dart:math' as math;
class PishFactorsAll extends StatefulWidget {
  const PishFactorsAll({Key? key}) : super(key: key);

  @override
  State<PishFactorsAll> createState() => _PishFactorsAllState();
}
enum TypeFactor { All, Accept, NotAccept ,Cancel}
class _PishFactorsAllState extends State<PishFactorsAll> {
  void GetDataNow()
  {
    // DateTime dt = DateTime.now();
    Jalali j = Jalali.now();
    // print(dt.toJalali().toString());
    creationDateStart=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
    creationDateEnd=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());

    setState(() {

    });
  }


  TypeFactor _site = TypeFactor.All;
  int FlagInt=0;
  String creationDateEnd='';
  String creationDateStart='';
  Updata_creationDateStart(String s,String s2){
    setState(() {
      creationDateStart=s;
    });
  }

  Updata_creationDateEnd(String s,String s2){
    setState(() {
      creationDateEnd=s;
    });
  }



  void _showDatePicker_Start(BuildContext context) {
    Pickers.showDatePicker_To(context,Updata_creationDateStart);
  }


  void _showDatePicker_End(BuildContext context) {
    Pickers.showDatePicker_To(context,Updata_creationDateEnd);
  }





  ShowModall_Type()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return   Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(
                    child:  Text('نوع پیش فاکتور',
                      textAlign: TextAlign.end,
                      style: TextStyle(color:
                      BaseColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w100),),
                  )),


                ],
              ),
              Divider(height: 10,color: ColorLine,),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child:
                      Text('همه',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeFactor.All,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value)async {
                          MyDate= await MyDate_Temp;
                          setState(() {
                            _site = value;
                            FlagInt=0;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('تایید شده',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeFactor.Accept,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value)async {
                          MyDate= await MyDate_Temp.where((element) => element.flag==1).toList();
                          setState(() {
                            _site = value;
                            FlagInt=1;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('عدم تایید',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeFactor.Cancel,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) async{
                          MyDate= await MyDate_Temp.where((element) => element.flag==3).toList();
                          setState(() {
                            _site = value;
                            FlagInt=3;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('در انتظار تایید',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeFactor.NotAccept,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) async{
                          MyDate= await MyDate_Temp.where((element) => element.flag==2).toList();
                          setState(() {
                            FlagInt=2;
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }







  List<Re_FactorsAlls> MyDate=[];
  List<Re_FactorsAlls> MyDate_Temp=[];



  Future GetDataRef()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    var Data=await ApiService.PishFactorsAlls(pr, base!, UserName!, Password!,creationDateStart,creationDateEnd,FlagInt);
    pr.hide();
    if(Data!=null)
    {
      if(Data.code==200)
      {
        MyDate.clear();
        MyDate=Data.res;
        MyDate_Temp=Data.res;
        setState(() {
        });
      }else{
        ApiService.ShowSnackbar(Data.msg);
      }

    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }
  }

  @override
  void initState() {
    super.initState();
    GetDataNow();
    GetDataRef();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('لیست پیش فاکتور ها',style: TextStyle(
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
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: BaseColor)
                ),
                child: Row(
                  children: [
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(creationDateEnd,
                          style: TextStyle(
                              fontSize: SizeSecond,
                              fontWeight: FontWeight.bold,
                              color: BaseColor
                          ),),
                        Text(': تا تاریخ',
                          style: TextStyle(
                              fontSize: SizeSecond,
                              color: BaseColor

                          ),),
                      ],)),
                    Container(
                      width: 2,
                      color: ColorLine,
                      height: Sizewid*1/7,
                    ),
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(creationDateStart,
                          style: TextStyle(
                              fontSize: SizeSecond,
                              color: BaseColor,
                              fontWeight: FontWeight.bold
                          ),),
                        Text(': از تاریخ',
                          style: TextStyle(
                            fontSize: SizeSecond,
                            color: BaseColor,
                          ),),
                      ],)),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: GetDataRef,
                      child: Container(
                        child:
                        ListView.builder(
                          itemCount: MyDate.length,
                          itemBuilder: (ctx,item){
                            return
                              BoxInfo_77(
                                  Sizewid,MyDate[item].customerName,MyDate[item].date,MyDate[item].tedVah,MyDate[item].tedJoz,MyDate[item].tedKol,
                                  MyDate[item].payment,
                                  MyDate[item].flag==1?'تایید شده':
                                  MyDate[item].flag==2?'در انتظار تایید':
                                  'عدم تایید'
                                  ,Colors.white,
                                  MyDate[item].flag==1?Color(0xff4E9F3D):
                                  MyDate[item].flag==2?BaseColor:
                                  Color(0xffE02401)
                              );








                          },
                        )
                      ),
                    ),
                    MyDate.length==0?
                    Center(
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
                    ):Container(),
                  ],

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        GetDataRef();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: BaseColor.withOpacity(0.25),
                                  spreadRadius: 2,
                                  blurRadius: 8
                              )
                            ],
                            color: BaseColor,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Icon(Icons.refresh,color: Colors.white,size: 40,),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showDatePicker_End(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: BaseColor.withOpacity(0.25),
                                  spreadRadius: 2,
                                  blurRadius: 8
                              )
                            ],
                            color: BaseColor,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Center(
                          child: SvgPicture.asset('images/datetosale.svg',width: 25,height: 25,color: Colors.white,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showDatePicker_Start(context);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: BaseColor.withOpacity(0.25),
                                  spreadRadius: 2,
                                  blurRadius: 8
                              )
                            ],
                            color: BaseColor,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Center(
                          child: SvgPicture.asset('images/datefromsale.svg',width: 25,height: 25,color: Colors.white,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        ShowModall_Type();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: BaseColor.withOpacity(0.25),
                                  spreadRadius: 2,
                                  blurRadius: 8
                              )
                            ],
                            color: BaseColor,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Center(
                          child: Icon(Icons.category_outlined,color: Colors.white,size: 35,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Positioned(
          //   left: 10,
          //   bottom: 10,
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         onTap: (){
          //           GetDataRef();
          //         },
          //         child: Container(
          //           margin: EdgeInsets.only(right: 8),
          //           height: 60,
          //           width: 60,
          //           decoration: BoxDecoration(
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: BaseColor.withOpacity(0.25),
          //                     spreadRadius: 2,
          //                     blurRadius: 8
          //                 )
          //               ],
          //               color: BaseColor,
          //               borderRadius: BorderRadius.circular(16)
          //           ),
          //           child: Icon(Icons.refresh,color: Colors.white,size: 40,),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           _showDatePicker_End(context);
          //         },
          //         child: Container(
          //           margin: EdgeInsets.symmetric(horizontal: 8),
          //           height: 60,
          //           width: 60,
          //           decoration: BoxDecoration(
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: BaseColor.withOpacity(0.25),
          //                     spreadRadius: 2,
          //                     blurRadius: 8
          //                 )
          //               ],
          //               color: BaseColor,
          //               borderRadius: BorderRadius.circular(16)
          //           ),
          //           child: Center(
          //             child: SvgPicture.asset('images/datetosale.svg',width: 25,height: 25,color: Colors.white,),
          //           ),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           _showDatePicker_Start(context);
          //         },
          //         child: Container(
          //           margin: EdgeInsets.symmetric(horizontal: 8),
          //           height: 60,
          //           width: 60,
          //           decoration: BoxDecoration(
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: BaseColor.withOpacity(0.25),
          //                     spreadRadius: 2,
          //                     blurRadius: 8
          //                 )
          //               ],
          //               color: BaseColor,
          //               borderRadius: BorderRadius.circular(16)
          //           ),
          //           child: Center(
          //             child: SvgPicture.asset('images/datefromsale.svg',width: 25,height: 25,color: Colors.white,),
          //           ),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: (){
          //           ShowModall_Type();
          //         },
          //         child: Container(
          //           margin: EdgeInsets.symmetric(horizontal: 8),
          //           height: 60,
          //           width: 60,
          //           decoration: BoxDecoration(
          //               boxShadow: [
          //                 BoxShadow(
          //                     color: BaseColor.withOpacity(0.25),
          //                     spreadRadius: 2,
          //                     blurRadius: 8
          //                 )
          //               ],
          //               color: BaseColor,
          //               borderRadius: BorderRadius.circular(16)
          //           ),
          //           child: Center(
          //             child: Icon(Icons.category_outlined,color: Colors.white,size: 35,),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )

        ],

      ),
    );
  }
}

class BoxInfo_77 extends StatelessWidget {

  BoxInfo_77(
      this.Sizewid,
      this.Value1,
      this.Value2,
      this.Value3,
      this.Value4,
      this.Value5,
      this.Value6,
      this.Value7,
      this.ColorText,
      this.ColorBack);


  final double Sizewid;
  String Value1;
  String Value2;
  String Value3;
  String Value4;
  String Value5;
  String Value6;
  String Value7;


  Color ColorText;
  Color ColorBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  (
          Container(
           margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
           width: double.infinity,
            decoration: BoxDecoration(
              color: ColorBack,
                boxShadow: [
                  BoxShadow(
                      color: BaseColor.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 8
                  )
                ],
              borderRadius: BorderRadius.circular(16)
            ),
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(Value7==null||Value7.isEmpty?
                    'نامشخص':Value7,style:
                    TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
                Expanded(child:Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('تاریخ',style:
                                  TextStyle(
                                    color: ColorFirst,
                                    fontSize: SizeFirst
                                  ),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(Value2==null||Value2.isEmpty?
                                    'نامشخص':Value2,style:
                                    TextStyle(
                                        color: ColorSecond,
                                        fontSize: SizeSecond
                                    ),),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                                color: ColorLine
                              ,width: 2,
                              height: Sizewid*1/7),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('نام مشتری',style:
                                  TextStyle(
                                      color: ColorFirst,
                                      fontSize: SizeFirst
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0,right: 8),
                                    child: Text(Value1==null||Value1.isEmpty?
                                    'نامشخص':Value1,style:
                                    TextStyle(
                                        color: ColorSecond,
                                        fontSize: SizeSecond
                                    ),),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            color: ColorLine
                            ,width: double.infinity,
                            height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text('مبلغ',style:
                                  TextStyle(
                                      color: ColorFirst,
                                      fontSize: SizeFirst
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(Value6==null||Value6.isEmpty?
                                      'نامشخص':Value6,style:
                                      TextStyle(
                                          color: ColorSecond,
                                          fontSize: SizeSecond
                                      ),),
                                    ),
                                  )
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
                                children: [
                                  Text('کل',style:
                                  TextStyle(
                                      color: ColorFirst,
                                      fontSize: SizeFirst
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(Value5==null||Value5.isEmpty?
                                    'نامشخص':Value5,style:
                                    TextStyle(
                                        color: ColorSecond,
                                        fontSize: SizeSecond
                                    ),),
                                  )
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
                                children: [
                                  Text('جز',style:
                                  TextStyle(
                                      color: ColorFirst,
                                      fontSize: SizeFirst
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(Value4==null||Value4.isEmpty?
                                    'نامشخص':Value4,style:
                                    TextStyle(
                                        color: ColorSecond,
                                        fontSize: SizeSecond
                                    ),),
                                  )
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
                                children: [
                                  Text('واحد',style:
                                  TextStyle(
                                      color: ColorFirst,
                                      fontSize: SizeFirst
                                  ),),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(Value3==null||Value3.isEmpty?
                                      'نامشخص':Value3
                                      ,style:
                                    TextStyle(
                                        color: ColorSecond,
                                        fontSize: SizeSecond
                                    ),),
                                  )
                                ],
                              ),
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                ))

              ],
            ),
          )
      ),
    );
  }


}
