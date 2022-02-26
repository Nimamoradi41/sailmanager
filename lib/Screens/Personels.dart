import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/Models/ListPersonel.dart';
import 'package:sailmanager/Models/OfflineModel.dart';
import 'package:sailmanager/Models/Pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../DataBseFile.dart';


class Personels extends StatefulWidget {

  List<RePerson> Customer_temps2 = <RePerson>[];


  Personels(this.TypeSwitch_Now,this.Customer_temps2);

  bool TypeSwitch_Now ;


  @override
  State<Personels> createState() => _PersonelsState();
}

class _PersonelsState extends State<Personels> {


  List<RePerson> Customer = <RePerson>[];


  var Baseurl='';
  var UserName='';
  var Password='';

  Future GetDataPersonel()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Baseurl=  prefs.getString("Baseurl")!;
    UserName= prefs.getString("UserName")!;
    Password= prefs.getString("Password")!;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetDataNow();
    pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    GetDataPersonel();

  }


  var pr;
  String creationDateEnd='';
  String creationDateStart='';


  String creationDateEnd_En='';
  String creationDateStart_En='';
  Updata_creationDateStart(String s,String s_En){
    setState(() {
      creationDateStart=s;
      creationDateStart_En=s_En;
      creationDateEnd=s;
      creationDateEnd_En=s_En;
    });
  }
  Updata_creationDateEnd(String s,String s_En){
    setState(() {
      creationDateEnd=s;
      creationDateEnd_En=s_En;
    });
  }

  void GetDataNow()
  {
    // DateTime dt = DateTime.now();
    Jalali j = Jalali.now();
    // print(dt.toJalali().toString());
    creationDateStart=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
    creationDateStart_En=Convert_DATE(j.toGregorian().day.toString(),j.toGregorian().month.toString(),j.toGregorian().year.toString());


    creationDateEnd=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
    creationDateEnd_En=Convert_DATE(j.toGregorian().day.toString(),j.toGregorian().month.toString(),j.toGregorian().year.toString());

    setState(() {

    });
  }

  void _showDatePicker_Start(BuildContext context) {
    Pickers.showDatePicker_To(context,Updata_creationDateStart);
  }
  void _showDatePicker_End(BuildContext context) {
    Pickers.showDatePicker_To(context,Updata_creationDateEnd);
  }



  List<Latlng> datatransfe=[];

  int pageCounter1=0;
  Future Run77(ProgressDialog pr,String Baseurl,String UserName,String Password,String visRdf,
      String creationDateStart,String creationDateEnd,String creationDateStart_En,String creationDateEnd_En,String PageCounter)async{
    var data= await ApiService.OfflinePeson(pr, Baseurl, UserName, Password,
        visRdf,creationDateStart,
        creationDateEnd,
        creationDateStart_En,
        creationDateEnd_En,PageCounter);


    if(data!=null)
      {
        if(data.res.latlng.length>0)
          {
            datatransfe.addAll(data.res.latlng);
          }

        pageCounter1=pageCounter1+1;
        if(pageCounter1<data.res.page)
          {
              await  Run77(pr, Baseurl, UserName, Password, visRdf, creationDateStart, creationDateEnd,
                creationDateStart_En, creationDateEnd_En,pageCounter1.toString());

          }else{
          pageCounter1=0;
          pr.hide();
          setState(() {

          });
        }
      }



  }

  @override
  Widget build(BuildContext context) {
    print(widget.Customer_temps2.length.toString());
    return Scaffold(
      backgroundColor: Color(0xffF1F7FE),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.Customer_temps2.length==0?
                Expanded(
                  child: Center(
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
                ):Container(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            // itemCount: Customer_temps2.take(30).length,
                            itemCount:
                            widget.Customer_temps2.length,
                            itemBuilder: (ctx,item){
                              return   InkWell(
                                onTap: () async{
                                  print(widget.TypeSwitch_Now.toString());
                                  if(widget.TypeSwitch_Now)
                                  {
                                    if( widget.Customer_temps2[item].lat>0)
                                      {
                                        Navigator.pop(context, widget.Customer_temps2[item]);
                                      }else{
                                      ApiService.ShowSnackbar('پرسنل مورد نظر موقعیت مکانی ندارد');
                                    }
                                  }else{
                                    print('QQQa');
                                    // var data= await ApiService.OfflinePeson(pr, Baseurl, UserName, Password,
                                    //     widget.Customer_temps2[item].visRdf.toString(),creationDateStart,
                                    //     creationDateEnd,creationDateStart_En,creationDateEnd_En);
                                    datatransfe.clear();
                                      await Run77(pr, Baseurl, UserName, Password, widget.Customer_temps2[item].visRdf.toString()
                                        , creationDateStart, creationDateEnd, creationDateStart_En, creationDateEnd_En, pageCounter1.toString());
                                    // List<Latlng> data=data3;
                                    if(datatransfe!=null)
                                      {
                                        if(datatransfe.length>0)
                                          {
                                            print('12');
                                            print(widget.Customer_temps2[item].name);
                                            pr.hide();
                                            datatransfe[0].name= widget.Customer_temps2[item].name;
                                            Navigator.pop(context,datatransfe);
                                          }else{
                                          print('14');
                                          pr.hide();
                                          ApiService.ShowSnackbar('پرسنل مورد نظر موقعیت مکانی ندارد');
                                        }

                                      } else{

                                    }
                                  }

                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: BaseColor,width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: BaseColor.withOpacity(0.10),
                                            spreadRadius: 1,
                                            blurRadius: 2
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'نام پرسنل:  '+
                                              widget.Customer_temps2[item].name.toString()==null?'نامشخص':
                                          'نام پرسنل:  '+
                                              widget.Customer_temps2[item].name.toString(),
                                          style: TextStyle(color: BaseColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Divider(height: 10,),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child:
                                                rowInfo_2( 'موبایل',  widget.Customer_temps2[item].cell)),
                                            Container(width: 2, color: ColorLine,),
                                            Expanded(
                                                child:
                                                rowInfo_2( 'تلفن 2',  widget.Customer_temps2[item].tell2)),
                                            Container(width: 2, color: ColorLine,),
                                            Expanded(
                                                child:
                                                rowInfo_2( 'تلفن ۱',  widget.Customer_temps2[item].tell1)),
                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              );

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                widget.TypeSwitch_Now==false?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxInfo_48( creationDateStart,':   تاریخ  ','images/datefromsale.svg',(){
                        _showDatePicker_Start(context);
                      },1),
                    ],
                  ),
                ):Container(),
              ],
            )
          ],

        ),
      )
    );
  }



  Container rowInfo_2(String Title,String Vale) {
    return Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8,right: 4,left: 4),
                                                  child: Text(
                                                   'تلفن ۱',
                                                    style: TextStyle(color: BaseColor,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 8),
                                                  child: Text(
                                                    Vale==null||
                                                        Vale.isEmpty
                                                            ?'نامشخص':
                                                    Vale.toString(),
                                                    style: TextStyle(color: BaseColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                          );
  }
}

class BoxInfo_48 extends StatelessWidget {

  String Date;
  String Title;
  String Icone;
  int Type;

  final VoidCallback callback;


  BoxInfo_48(this.Date,this.Title,this.Icone, this.callback,this.Type);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment:  MainAxisAlignment.center ,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
               Date,
              style: TextStyle(color: BaseColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),),
          ),
          Text(
            Title,
            style: TextStyle(color: BaseColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),),
          GestureDetector(
            onTap:callback ,
            child: Container(
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
              child: Center(
                child: SvgPicture.asset(Icone,width: 20,height: 20,color: Colors.white,),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
