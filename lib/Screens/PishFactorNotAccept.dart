import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/Constants.dart';
import 'package:sailmanager/Models/ModelPIshfactorsNotAccept.dart';
import 'package:sailmanager/Models/Pickers.dart';
import 'package:sailmanager/Screens/DetailPishFactor.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PishFactorNotAccept extends StatefulWidget {
  const PishFactorNotAccept({Key? key}) : super(key: key);

  @override
  State<PishFactorNotAccept> createState() => _PishFactorNotAcceptState();
}

class _PishFactorNotAcceptState extends State<PishFactorNotAccept> {



  List<Re_NotAccept> MyData=[];







  Future GetData()async{
       GetDataNow();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
  var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    var Data=await ApiService.PishFactorsNotAccept(pr, base!, UserName!, Password!,creationDateStart,creationDateEnd);
    pr.hide();
    if(Data!=null)
      {
        if(Data.code==200)
          {
            MyData=Data.res;
            setState(() {

            });
          }else{
          ApiService.ShowSnackbar(Data.msg);
        }

      }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }
  }



  Future GetDataRef()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    var Data=await ApiService.PishFactorsNotAccept(pr, base!, UserName!, Password!,creationDateStart,creationDateEnd);
    pr.hide();
    if(Data!=null)
    {
      if(Data.code==200)
      {
        MyData.clear();
        MyData=Data.res;
        setState(() {

        });
      }else{
        ApiService.ShowSnackbar(Data.msg);
      }

    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }
  }





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
  String creationDateStart='';
  String creationDateEnd='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     GetData();
  }
  Updata_creationDateStart(String s){
    setState(() {
      creationDateStart=s;
    });
  }
  Updata_creationDateEnd(String s){
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
  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorBack,
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('لیست پیش فاکتور های تایید نشده',style: TextStyle(
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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
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
                  child:
                      MyData.length>0?
                  ListView.builder(
                    itemCount: MyData.length,
                    itemBuilder: (ctx,item){
                      return GestureDetector(
                        onTap: () async{
                       var Date= await      Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context)
                                  => DetailPishFactor(MyData[item].id.toString(),MyData[item])));
                          if(Date!=null)
                            {
                              MyData.removeAt(item);
                              setState(() {

                              });
                            }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 25,
                                          child: BoxInfo_3('تاریخ',MyData[item].date)),
                                      Container(
                                        width: 2,
                                        height: Sizewid*1/7,
                                        color: ColorLine,
                                      ),
                                      Expanded(
                                          flex: 75,
                                          child:
                                          BoxInfo_Right('نام مشتری',MyData[item].customerName)
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  height: 2,
                                  width: double.infinity,
                                  color: ColorLine,
                                ),
                                Row(
                                  children: [
                                    Expanded(child: BoxInfo_3('مبلغ',MyData[item].payment)),
                                    Container(
                                      width: 2,
                                      height: Sizewid*1/7,
                                      color: ColorLine,
                                    ),
                                    Expanded(child: BoxInfo_3('کل',MyData[item].tedJoz)),
                                    Container(
                                      width: 2,
                                      height: Sizewid*1/7,
                                      color: ColorLine,
                                    ),
                                    Expanded(child: BoxInfo_3('جز',MyData[item].tedJoz)),
                                    Container(
                                      width: 2,
                                      height: Sizewid*1/7,
                                      color: ColorLine,
                                    ),
                                    Expanded(child: BoxInfo_3('واحد',MyData[item].tedVah)),

                                  ],
                                )
                              ],
                            ),
                          ) ,
                        ),
                      );
                    },
                  ):
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

                    ],
                  ),
                ),
              ],
            ),
          ),

          // DraggableScrollableSheet(
          //   initialChildSize: 0.2,
          //   minChildSize: 0.1,
          //   maxChildSize: 0.3,
          //   builder: (contex, con)=>
          //   Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
          //     ),
          //     child: SingleChildScrollView(
          //       controller: con,
          //       child: Container(height: 50,color: Colors.black,),
          //     ),
          //   )
          // )
        ],

      )
    );
  }
}

class BoxInfo_3 extends StatelessWidget {
  String First;

  String Second;


  BoxInfo_3(this.First, this.Second);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(First,
          style: TextStyle(
              fontSize: SizeFirst,
              color: ColorFirst
          ),),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(Second==null||Second.isEmpty?'نامشخص':Second,
            style: TextStyle(
                fontSize: SizeSecond,
                color: ColorSecond
            ),),
        )
      ],
    );
  }
}



class BoxInfo_Right extends StatelessWidget {


  String First;

  String Second;


  BoxInfo_Right(this.First, this.Second);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(First,
            style: TextStyle(
                fontSize: SizeFirst,
                color: ColorFirst
            ),),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(Second==null||Second.isEmpty?'نامشخص':Second,
              style: TextStyle(
                  fontSize: SizeSecond,
                  color: ColorSecond
              ),),
          )
        ],
      ),
    );
  }
}
