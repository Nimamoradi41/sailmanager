import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/Models/ModelDetailFactor.dart';
import 'package:sailmanager/Models/ModelPIshfactorsNotAccept.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import 'PishFactorNotAccept.dart';


class DetailPishFactor extends StatefulWidget {



  String NumberFactor;

  Re_NotAccept MyData;
  DetailPishFactor(this.NumberFactor,this.MyData);

  @override
  State<DetailPishFactor> createState() => _DetailPishFactorState();
}

class _DetailPishFactorState extends State<DetailPishFactor> {


  String countChkInWay='';
  String priceChkInWay='';
  String countChkReturn='';
  String priceChkReturn='';
  String Etebar='';

  List<ListKala> MyData=[];



  Future RunAcceptOrNotAccept(bool Flag,String Com,bool Flag_Desc) async{


     if(Flag_Desc==true)
      {
        if(Com==null||Com.isEmpty)
        {
          ApiService.ShowSnackbar('توضیحات خود را وارد کنید');
          return;
        }
      }


    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    var Data=await ApiService.Confirm(pr, base!, UserName!, Password!,widget.NumberFactor,Flag,Com);

    pr.hide();
    if(Data!=null)
      {
        if(Data.code==200)
          {
            Navigator.pop(context,true);
          }
      }
  }


  Future getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    var Data=await ApiService.GetDetailFactor(pr, base!, UserName!, Password!, widget.NumberFactor);
    pr.hide();
    if(Data!=null)
    {
      if(Data.code==200)
      {
        MyData=Data.res.listKala;
        countChkReturn=Data.res.countChkReturn;
        priceChkReturn=Data.res.priceChkReturn;
        countChkInWay=Data.res.countChkInWay;
        priceChkInWay=Data.res.priceChkInWay;
        Etebar=Data.res.etebar;
        setState(() {

        });
      }else{
        ApiService.ShowSnackbar(Data.msg);
        Navigator.pop(context);
      }

    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
      Navigator.pop(context);
    }
  }



  var Flag_Desc=false;

  TextEditingController txt_1 =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
          child: Text(widget.NumberFactor+' : شماره پیش فاکتور  ',style: TextStyle(
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
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
                                child: BoxInfo_3('تاریخ',widget.MyData.date)),
                            Container(
                              width: 2,
                              height: Sizewid*1/7,
                              color: ColorLine,
                            ),
                            Expanded(
                                flex: 75,
                                child:
                                BoxInfo_Right('نام مشتری',widget.MyData.customerName)
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
                          Expanded(child: BoxInfo_3('مبلغ',widget.MyData.payment)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(child: BoxInfo_3('کل',widget.MyData.tedJoz)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(child: BoxInfo_3('جز',widget.MyData.tedJoz)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(child: BoxInfo_3('واحد',widget.MyData.tedVah)),

                        ],
                      )
                    ],
                  ),
                ) ,
              ),
              Container(
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
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: BoxInfo_3('مبلغ',priceChkInWay)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(
                              flex: 2,
                              child: BoxInfo_3('تعداد',countChkInWay)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('چک \n در راه',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorFirst,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 2,
                        color: ColorLine,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                              child: BoxInfo_3('مبلغ',priceChkReturn)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(
                              flex: 2,
                              child: BoxInfo_3('تعداد',countChkReturn)),
                          Container(
                            width: 2,
                            height: Sizewid*1/7,
                            color: ColorLine,
                          ),
                          Expanded(
                            flex: 1,
                              child: BoxInfo_3(
                                  'چک برگشتی',
                                  countChkReturn.isEmpty||countChkReturn=='0'?
                              'ندارد':'دارد')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                width: double.infinity,
                height: 2,
                color: ColorLine,
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Text('مانده اعتبار',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: ColorSecond,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,

                            ),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
                              child: Text(Etebar,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorSecond,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,

                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: Sizewid*1/7,
                      color: ColorLine,
                    ),
                    Expanded(
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Text('مانده مشتری',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSecond,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,

                              ),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
                              child: Text(Etebar,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorSecond,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,

                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: Sizewid*1/7,
                      color: ColorLine,
                    ),
                    Expanded(
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Text('تخفیف',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorSecond,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,

                              ),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
                              child: Text(Etebar,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorSecond,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,

                                ),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                height: 2,
                color: ColorLine,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('لیست اقلام فاکتور',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: ColorFirst,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),),
              ),
              ListView.builder(
                itemCount:MyData.length ,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx,item){
                  return Container(
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
                                    child: BoxInfo_3('محتوایی',MyData[item].moh)),
                                Container(
                                  width: 2,
                                  height: Sizewid*1/7,
                                  color: ColorLine,
                                ),
                                Expanded(
                                    flex: 75,
                                    child:
                                    BoxInfo_Right('نام کالا',MyData[item].naka)
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
                              Expanded(child: BoxInfo_3('کل',MyData[item].kol)),
                              Container(
                                width: 2,
                                height: Sizewid*1/7,
                                color: ColorLine,
                              ),
                              Expanded(child: BoxInfo_3('جز',MyData[item].joz)),
                              Container(
                                width: 2,
                                height: Sizewid*1/7,
                                color: ColorLine,
                              ),
                              Expanded(child: BoxInfo_3('واحد',MyData[item].vah)),

                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                            height: 2,
                            width: double.infinity,
                            color: ColorLine,
                          ),
                          Row(
                            children: [
                              Expanded(child: BoxInfo_3('بهای کل',MyData[item].kol)),
                              Container(
                                width: 2,
                                height: Sizewid*1/7,
                                color: ColorLine,
                              ),
                              Expanded(child: BoxInfo_3('بهای جز',MyData[item].joz)),
                              Container(
                                width: 2,
                                height: Sizewid*1/7,
                                color: ColorLine,
                              ),
                              Expanded(child: BoxInfo_3('تخفیف',MyData[item].vah)),

                            ],
                          )
                        ],
                      ),
                    ) ,
                  );
                },
              ),
              Flag_Desc?
              BoxInput_Desc('images/svg_aser.svg','آدرس سرور خود را وارد کنید','آدرس سرور',txt_1):Container(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8,top: 16),
                        child: ElevatedButton(onPressed: (){
                          if(txt_1.text.isEmpty)
                            {
                              ApiService.ShowSnackbar('توضیحات خود را وارد کنید');
                              setState(() {
                                Flag_Desc=true;
                              });
                              return;
                            }
                          RunAcceptOrNotAccept(false,txt_1.text,Flag_Desc);
                        },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Color(0xff5E5E5E)),
                                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                )
                            ),
                            child:Text('عدم تایید',
                              style: TextStyle(color:Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8,top: 16),
                        child: ElevatedButton(onPressed: (){
                          RunAcceptOrNotAccept(false,txt_1.text,Flag_Desc);
                        },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(BaseColor),
                                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                )
                            ),
                            child:Text('تایید',
                              style: TextStyle(color:Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         width: double.infinity,
              //         margin: EdgeInsets.only(right: 16,left: 16,top: 32),
              //         child: ElevatedButton(onPressed: (){},
              //             style: ButtonStyle(
              //                 backgroundColor: MaterialStateProperty.all(BaseColor),
              //                 padding: MaterialStateProperty.all(EdgeInsets.all(14)),
              //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //                     RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(24.0),
              //
              //                     )
              //                 )
              //             ),
              //             child:Text('ورود',
              //               style: TextStyle(color:Colors.white,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold),)),
              //       ),
              //     ),
              //   ],
              // )

            ],
          ),
        ),
      ),
    );
  }
}

class BoxInput_Desc extends StatelessWidget {
  String  Icone;

  String Hint;

  String Title;


  TextEditingController txtc;


  BoxInput_Desc(this.Icone, this.Hint, this.Title,this.txtc);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 24),
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('توضیحات',
                style: TextStyle(color: BaseColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),),
            ),
            Divider(height: 10,),
            Row(
              children: [
                Expanded(child: TextField(
                  controller: txtc,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      hintText:'توضیحات خود را وارد کنید',
                      hintStyle: TextStyle(
                          color: Color(0xffAEAEAE)
                      )
                  ),
                ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
