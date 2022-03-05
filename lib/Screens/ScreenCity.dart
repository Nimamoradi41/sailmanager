import 'package:flutter/material.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/Models/ModelCity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import 'PishFactorNotAccept.dart';

class ScreenCity extends StatefulWidget {


  String IdProvice;
  String NameProvice;


  ScreenCity(this.IdProvice,this.NameProvice);

  @override
  State<ScreenCity> createState() => _ScreenCityState();
}

class _ScreenCityState extends State<ScreenCity> {
  var Baseurl="";

  var UserName="";

  var Password="";

  Future GetLogins() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Baseurl=  prefs.getString("Baseurl")!;
    UserName=  prefs.getString("UserName")!;
    Password=  prefs.getString("Password")!;
    Run();
  }

  List<ReC_City> datamian=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetLogins();
  }


  Future Run()async {
    var ss = await ApiService.GetCity(
        Baseurl, UserName, Password, widget.IdProvice, '');

    setState(() {
      if(ss.res.length>0)
      {
        datamian=ss.res;
      }else{
        datamian.clear();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
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
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  onChanged: (val) async {
                                    if(val.isNotEmpty)
                                    {
                                       var ss=await ApiService.GetCity(Baseurl, UserName, Password,widget.IdProvice,val.toString());
                                      setState(() {
                                        if(ss.res.length>0)
                                          {
                                            datamian=ss.res;
                                          }else{
                                          datamian.clear();
                                        }

                                      });
                                    }else{
                                      setState(() {
                                        datamian.clear();
                                      });
                                    }

                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Color(0xff1F3C84).withOpacity(0.80)
                                      ),
                                      hintText: 'شهر خود را جستجو کنید...'
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: datamian.length,
                          itemBuilder: (ctx,item){
                            return  GestureDetector(
                              onTap: (){
                                var dr=datamian[item];
                                Navigator.pop(context,dr);
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
                                child: Container(

                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 50,
                                            child: BoxInfo_3('شهر',datamian[item].name)),
                                        Container(
                                          width: 2,
                                          height: Sizewid*1/7,
                                          color: ColorLine,
                                        ),
                                        Expanded(
                                            flex: 50,
                                            child:
                                            BoxInfo_3('استان',widget.NameProvice)
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )

              )
            ],
          )



      ),
    );
  }
}
