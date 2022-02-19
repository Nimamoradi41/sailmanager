import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailmanager/ApiService.dart';
import 'package:sailmanager/Constants.dart';
import 'package:sailmanager/DataBseFile.dart';
import 'package:sailmanager/Models/ListCustomer.dart';
import 'package:sailmanager/Models/ListPersonel.dart';
import 'package:sailmanager/Models/OfflineModel.dart';
import 'package:sailmanager/Models/OnlineModel.dart';
import 'package:sailmanager/Screens/Personels.dart';
import 'package:sailmanager/Screens/PishFactorNotAccept.dart';
import 'package:sailmanager/Screens/PishFactorsAll.dart';
import 'package:sailmanager/Screens/ScreenSetting.dart';

import 'Customers.dart';

class MainMap extends StatefulWidget {
  const MainMap({Key? key}) : super(key: key);


  @override
  State<MainMap> createState() => _MainMapState();
}

enum TypeMap { normal, hybrid, terrain ,satellite}
class _MainMapState extends State<MainMap> {

  TypeMap _site = TypeMap.normal;

  bool TypeSwitch_Now=true;
  bool TypeSwitch_After=false;
  int group=1;
  List<RePerson> Customer_temps2 = <RePerson>[];
  List<RePerson> Customer = <RePerson>[];
      CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.319743, 48.677719),
    zoom: 13.4746,
  );






  ShowModall_()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
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
                          if(val.isNotEmpty)
                          {
                            Customer.clear();
                            // val=val.replaceAll('ی','ي');
                            // val=val.replaceAll('ک','ك');
                            var data   =Customer_temps2.where((i) => i.name.contains(val)||i.visRdf.toString().contains(val.toString())||i.tell2.contains(val.toString())
                                ||i.tell1.contains(val)||i.cell.toString().contains(val)).toList();


                            setState(() {

                              if(data.length==0)
                              {
                                Customer.clear();
                              }
                            });
                          }else{

                            setState(() {
                              Customer.clear();
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
                      margin: EdgeInsets.only(top: 4),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // itemCount: Customer_temps2.take(30).length,
                        itemCount: Customer.length>30?Customer.take(30).length:
                        Customer.length,
                        itemBuilder: (ctx,item){
                          return   InkWell(
                            onTap: (){
                              // final data = { "id" : Customer[item].id
                              //     .toString(), "name" : Customer[item].name.toString() };
                              // Navigator.pop(context,data);
                            },
                            child:  Card(
                              margin: EdgeInsets.all(8),
                              // child: DoubleRowMultyOne_Customer(
                              //   'موبایل','تلفن ثابت','نام مشتری','آدرس',
                              //   'assets/pngs/mobile_1.svg',
                              //   'assets/pngs/tel_1.svg',
                              //   'assets/pngs/ad_1.svg',
                              //   'assets/pngs/loccc.svg',
                              //   Customer_temps2[item].mobile,
                              //   Customer_temps2[item].tell1,
                              //   Customer_temps2[item].name,
                              //   Customer_temps2[item].address,
                              // ),
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
      ) ;
    });
  }






  ShowModall_setting()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child:
                  Container(
                  child:  Text('تنظیمات',
                    textAlign: TextAlign.end,
                    style: TextStyle(color:
                    BaseColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w100),),
                  )),
                  GestureDetector(
                    onTap: (){
                      // Navigator.pop(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ScreenSetting()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.settings_rounded,size: 25,color: Color(0xff1F3C84),),
                    ),
                  ),

                ],
              ),
              Divider(height: 10,color: ColorLine,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(
                    child:  Text('حالت های نمایش نقشه',
                      textAlign: TextAlign.end,
                      style: TextStyle(color:
                      BaseColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w100),),
                  )),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.map,size: 25,color: Color(0xff1F3C84),),
                    ),
                  ),

                ],
              ),
              Divider(height: 10,color: ColorLine,),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child:  Text('normal',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.normal,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('hybrid',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.hybrid,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('satellite',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.satellite,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('terrain',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.terrain,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
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
      ) ;
    });
  }


  ShowModall_MainMenu()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Customers()));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container(
                      child:  Text('لیست مشتریان',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),),
                    )),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('images/admin2.svg',width: 20,height: 20,color: Color(0xff1F3C84),),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(height: 10,color: ColorLine,),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)
                              => PishFactorsAll()));
                    },
                    child: Container(
                      child:  Text('لیست پیش فاکتور ها(همه)',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),),
                    ),
                  )),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('images/list_4.svg',width: 15,height: 15,color: Color(0xff1F3C84),),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ) ;
    });
  }



    Set<Marker> _Markers={};

  late GoogleMapController controller2;

  Set<Polyline> _poly=Set<Polyline>();

  List<LatLng> _cordinate=[];
  List<Polygon> Polygons=[];





  late PolylinePoints polylinePoints;
  // late BitmapDescriptor pinLocationIcon;


  // void Setm() async{
  //   pinLocationIcon= await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 5),
  //       'images/locpng.png');
  // }
  @override
  void initState() {
    super.initState();
    polylinePoints=PolylinePoints();
    // Setm();
  }



   RunAllTime(){

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType:_site==TypeMap.normal?
            MapType.normal:
            _site==TypeMap.hybrid?MapType.hybrid:
            _site==TypeMap.terrain?MapType.terrain:
            MapType.satellite,
            polylines: _poly,
            onMapCreated: (GoogleMapController controller) {
              controller2 = controller;
            },
            markers: _Markers,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: false,
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 6),
                child: Row(
            children: [
                InkWell(
                    onTap: (){
                      ShowModall_setting();
                    },
                    child: BtnSmall('images/seti.svg')),
                Expanded(
                  child: buildContainer(),
                )
            ],
          ),
              )),
          Positioned(
         bottom: 0,
         left: 0,
         right: 0,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    ShowModall_MainMenu();
                  },
                  child: BtnSmall('images/cate23.svg')),
              GestureDetector(
                onTap: (){
                  // ShowModall_();
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)
                          => PishFactorNotAccept()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child:  BtnSmall('images/pish.svg'),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: InkWell(
                        onTap: () async{
                          var resuilt=await    Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Personels(TypeSwitch_Now)));
                          if(TypeSwitch_Now)
                            {
                              print('TypeSwitch_Now'+ 'Is True');
                              if(resuilt!=null)
                              {
                                print('2302020202020200');
                                _Markers.clear();
                                _poly.clear();
                                _cordinate.clear();
                                setState(() {
                                });
                                print(resuilt.toString());
                                OnlineModel d=resuilt ;
                                if(d.msg.isNotEmpty)
                                  {
                                    ApiService.ShowSnackbar(d.msg);
                                  }
                                if(d.res.lat!=0.0&&d.res.lat!=0)
                                {


                                  print('Data is'+d.res.lat.toString());
                                  var newPosition = CameraPosition(
                                      target: LatLng(d.res.lat,d.res.lng),
                                      zoom: 16);

                                  CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
                                  controller2.moveCamera(update);
                                  _Markers.add(
                                      Marker(
                                          markerId:MarkerId('MarkId'),

                                          position: LatLng(d.res.lat,d.res.lng),
                                          infoWindow: InfoWindow(
                                              title: 'Nima Moradi',
                                              snippet: d.res.datetime
                                          )
                                      ));
                                  print('objectHere is Ojk');
                                  setState(() {

                                  });
                                }


                              }
                            }else{
                            print('TypeSwitch_Now'+ 'Is False');
                             print('HI');
                             if(resuilt!=null)
                             {
                               print('565656565655');
                               print(resuilt.toString());
                               _Markers.clear();
                               _poly.clear();
                               _cordinate.clear();
                               setState(() {

                               });
                               OfflineModel d=resuilt ;
                               if(d.msg.isNotEmpty)
                               {
                                 ApiService.ShowSnackbar(d.msg);
                               }
                               if(d.res.latlng!=null)
                               {
                                 if(d.res.latlng.length>0)
                                   {
                                     var newPosition = CameraPosition(
                                         target: LatLng(d.res.latlng[0].lat,d.res.latlng[0].lng),
                                         zoom: 16);
                                     d.res.latlng.forEach((element) {
                                       print(element.toString());
                                       print('element.toString()');
                                       _cordinate.add(LatLng(element.lat,element.lng));
                                     });
                                     _poly.add(
                                         Polyline(
                                           polylineId: PolylineId("route1"),
                                           patterns: [
                                             PatternItem.dash(20.0),
                                             PatternItem.gap(10)
                                           ],
                                           width: 4,
                                           color: Colors.blue,
                                           points: _cordinate,
                                         )
                                     );
                                     d.res.latlng.forEach((element)
                                     {
                                       _Markers.add(
                                           Marker(
                                               // icon: pinLocationIcon,
                                               markerId:MarkerId('MarkId'+element.lat.toString()+element.lng.toString()),
                                               position: LatLng(element.lat,element.lng),
                                               infoWindow: InfoWindow(
                                                   title: 'Nima Moradi',
                                                   snippet: element.datetime
                                               )
                                           ));
                                     });

                                     CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
                                     controller2.moveCamera(update);
                                     setState(() {

                                     });
                                   }
                               }
                             }else{
                               ApiService.ShowSnackbar('موقعیت مکانی وجود ندارد');
                             }
                          }
                        },
                        child: TextField(
                          enabled: false,
                          autofocus: false,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffBEBEBE),
                                  fontSize: 14
                              ),
                              hintText: 'پرسنل خود را جستجو کنید'
                          ),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(Icons.search,color: Color(0xffCACACA),size: 24,),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
        ],
      ),
    );
  }
  Container buildContainer() {
    return Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          if(!TypeSwitch_After)
                          {
                            setState(() {
                              TypeSwitch_Now=false;
                              TypeSwitch_After=true;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: BoxSwitch('تاریخچه موقعیت ها',TypeSwitch_After),
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: (){
                            if(!TypeSwitch_Now)
                              {
                                setState(() {
                                  TypeSwitch_Now=true;
                                  TypeSwitch_After=false;
                                });
                              }

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: BoxSwitch('موقعیت فعلی',TypeSwitch_Now),
                        ),
                      )),
                    ],
                  ),

                );
  }
}



 class TypingMap extends StatelessWidget {

  int i;
  int group;
  String Text1;


  TypingMap(this.i, this.Text1,this.group);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(Text1,
          textAlign: TextAlign.end,
          style: TextStyle(color:
          BaseColor,
              fontSize: 14,
              fontWeight: FontWeight.w100),),
        Radio(
          value: 1,
          groupValue:group ,
          onChanged: (T) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
 class RowInfo extends StatelessWidget {
   IconData Icon2;

   String Title;


   RowInfo(this.Icon2, this.Title);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Title,
              textAlign: TextAlign.end,
              style: TextStyle(color:
              BaseColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w100),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icon2,color: BaseColor,),
        )
      ],
    );
  }
}
 class BoxSwitch extends StatelessWidget {
   String  Lable;
   bool Active;
   BoxSwitch(this.Lable,this.Active);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:Active?  BoxDecoration(
          color: BaseColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 1
            )
          ],
          borderRadius: BorderRadius.circular(8)
      ):BoxDecoration(),
      child: Padding(
        padding:  const EdgeInsets.only(bottom: 16.0,top: 16.0,right: 0,left: 0),
        child: Center(
          child: Text(Lable,
            style: TextStyle(color:Active?Colors.white:
            BaseColor,
                fontSize: 12,
                fontWeight: FontWeight.w100),),
        ),
      ),
    );
  }
}




 

 

class BtnSmall extends StatelessWidget {
  String Icon;


  BtnSmall(this.Icon);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(BaseColor),

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )
            )
        ),
        child:Padding(
          padding: const EdgeInsets.only(bottom: 16.0,top: 16.0),

          child:

          SvgPicture.asset(Icon, color: Colors.white,
            width: 18,height: 18,),
        ) );
  }
}


class BtnSmallText extends StatelessWidget {
  String Text1;


  BtnSmallText(this.Text1);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(BaseColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )
            )
        ),
        child:Padding(
          padding: const EdgeInsets.only(bottom: 16.0,top: 16.0,right: 0,left: 0),
          child: Text(Text1,
            style: TextStyle(color:Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold),),
        ) );
  }
}
