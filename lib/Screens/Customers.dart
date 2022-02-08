import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants.dart';

class Customers extends StatelessWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('لیست مشتری ها',style: TextStyle(
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
            BoxInfo78(Sizewid,'بناری','099909439787','06134440238','06134587455',
                'زیتون کارمندی خیابان فیلسوف',(){},(){})
          ],
        ),
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


  BoxInfo78(this.Sizewid, this.NameMoshtari, this.Mobile, this.Tel1, this.Tel2,
      this.Address, this.Factors, this.Location);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('مشتری',style:
                  TextStyle(
                      color: ColorFirst,
                      fontSize: SizeFirst
                  ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(Mobile==null||
                                Mobile.isEmpty?'نامشخص':
                            Mobile,style:
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
                        Text('تلفن ۲',style:
                        TextStyle(
                            color: ColorFirst,
                            fontSize: SizeFirst
                        ),),
                        Padding(
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
                        Text('تلفن ۱',style:
                        TextStyle(
                            color: ColorFirst,
                            fontSize: SizeFirst
                        ),),
                        Padding(
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
                    height:  Sizewid*1/7),
                GestureDetector(
                  onTap: Location,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SvgPicture.asset('images/locsale.svg',width: 25,height: 25,),
                  ),
                ),
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
                        padding: const EdgeInsets.only(top: 4.0),
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
