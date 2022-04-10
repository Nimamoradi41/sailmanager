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
  List<RePerson> Customer_temps3 = <RePerson>[];
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
    Customer_temps3=widget.Customer_temps2;
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
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back,color: BaseColor,),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: TextField(
                          textAlign: TextAlign.end,
                          onChanged: (val) async{
                            if(val.isNotEmpty)
                            {
                              print(Customer.length.toString());
                              // val=val.replaceAll('ی','ي');
                              // val=val.replaceAll('ک','ك');
                              Customer_temps3 =widget.Customer_temps2.where((i) => i.name.contains(val)||i.tell2.contains(val.toString())
                                  ||i.tell1.contains(val)).toList();

                              // Customer_temps2.sort((a, b) => a.name.compareTo(b.name));

                              // Customer_temps2.sort((a,b){})

                              // Customer_temps2.sort((a, b) {
                              //   return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                              // });
                              setState(() {
                                if(Customer_temps3.length==0)
                                {
                                  Customer_temps3.clear();
                                }
                              });




                            }else{
                              // print(Customer.length.toString());
                              setState(() {
                                Customer_temps3=widget.Customer_temps2;
                              });

                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Color(0xff1F3C84).withOpacity(0.80)
                              ),
                              hintText: 'پرسنل خود را جستجو کنید...'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Customer_temps3.length==0?
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
                            Customer_temps3.length,
                            itemBuilder: (ctx,item){
                              return   InkWell(
                                onTap: () async{

                                  if(widget.TypeSwitch_Now)
                                  {
                                    if( Customer_temps3[item].lat>0)
                                      {
                                        Navigator.pop(context, Customer_temps3[item]);
                                      }else{
                                      ApiService.ShowSnackbar('پرسنل مورد نظر موقعیت مکانی ندارد');
                                    }
                                  }else{

                                    // var data= await ApiService.OfflinePeson(pr, Baseurl, UserName, Password,
                                    //     widget.Customer_temps2[item].visRdf.toString(),creationDateStart,
                                    //     creationDateEnd,creationDateStart_En,creationDateEnd_En);
                                    datatransfe.clear();
                                      await Run77(pr, Baseurl, UserName, Password, Customer_temps3[item].visRdf.toString()
                                        , creationDateStart, creationDateEnd, creationDateStart_En, creationDateEnd_En, pageCounter1.toString());
                                    // List<Latlng> data=data3;
                                    if(datatransfe!=null)
                                      {
                                        if(datatransfe.length>0)
                                          {

                                            pr.hide();
                                            datatransfe[0].name= Customer_temps3[item].name;
                                            Navigator.pop(context,datatransfe);
                                          }else{

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
                                              Customer_temps3[item].name.toString()==null?'نامشخص':
                                          'نام پرسنل:  '+
                                              Customer_temps3[item].name.toString(),
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
                                                rowInfo_2( 'موبایل',  Customer_temps3[item].cell)),
                                            Container(width: 2, color: ColorLine,),
                                            Expanded(
                                                child:
                                                rowInfo_2( 'تلفن 2',  Customer_temps3[item].tell2)),
                                            Container(width: 2, color: ColorLine,),
                                            Expanded(
                                                child:
                                                rowInfo_2( 'تلفن ۱',  Customer_temps3[item].tell1)),
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
