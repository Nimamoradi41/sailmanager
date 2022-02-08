import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/Models/ListPersonel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../DataBseFile.dart';


class Personels extends StatefulWidget {

  List<RePerson> Customer_temps2 = <RePerson>[];


  Personels(this.TypeSwitch_Now);

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
    var data= await DataBseFile.db.GetPersonel();
    data.forEach((element) {
      print(element.visRdf.toString());
    });

    Customer=data;
    widget.Customer_temps2=data;
    print('Customer.length'+Customer.length.toString());
    setState(() {
      widget.Customer_temps2=data;
    });
    print('SiGetDataPersonelze Is'+Customer.length.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    GetDataPersonel();
  }


  var pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F7FE),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back,size: 25,color: Color(0xff1F3C84),),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onChanged: (val){
                          List<RePerson> data=[];
                          if(val.isNotEmpty)
                          {
                            // val=val.replaceAll('ی','ي');
                            // val=val.replaceAll('ک','ك');
                            print('Customer_temps2 Is '+ widget.Customer_temps2.length.toString());
                            print('Word Is  '+ val);
                            Customer   = widget.Customer_temps2.where((i) => i.name.contains(val)||
                                i.visRdf.toString().contains(val.toString())||i.tell2.contains(val.toString())
                                ||i.tell1.contains(val)||i.cell.toString().contains(val)).toList();

                            print('data Is '+Customer.length.toString());
                            if(Customer.length==0)
                            {
                              setState(() {
                                Customer.clear();
                              });
                            }else{
                              setState(() {
                              });
                            }
                          }else{

                            setState(() {
                              Customer= widget.Customer_temps2;
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
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // itemCount: Customer_temps2.take(30).length,
                        itemCount: Customer.length>30?Customer.take(30).length:
                        Customer.length,
                        itemBuilder: (ctx,item){
                          return   InkWell(
                            onTap: () async{
                              print(widget.TypeSwitch_Now.toString());
                              if(widget.TypeSwitch_Now)
                                {
                                  var data= await ApiService.OnlinePeson(pr, Baseurl, UserName, Password, Customer[item].visRdf.toString());
                                  pr.hide();
                                  print(data.toString());
                                  Navigator.pop(context,data);
                                }else{
                                print('QQQa');
                                var data= await ApiService.OfflinePeson(pr, Baseurl, UserName, Password, Customer[item].visRdf.toString());
                                pr.hide();
                                print(data.toString());
                                Navigator.pop(context,data);
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
                                    Text(
                                      'نام پرسنل:  '+
                                      Customer[item].name.toString()==null?'نامشخص':
                                      'نام پرسنل:  '+
                                      Customer[item].name.toString(),
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
                                            rowInfo_2( 'موبایل', Customer[item].cell)),
                                        Container(width: 2, color: ColorLine,),
                                        Expanded(
                                            child:
                                            rowInfo_2( 'تلفن 2', Customer[item].tell2)),
                                        Container(width: 2, color: ColorLine,),
                                        Expanded(
                                            child:
                                            rowInfo_2( 'تلفن ۱', Customer[item].tell1)),
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