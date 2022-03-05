import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart'as http;
import 'package:sailmanager/Models/CustGroup.dart';
import 'package:sailmanager/Models/LoginModel.dart';

import 'Models/CustGroup.dart';
import 'Models/ListCustomer.dart';
import 'Models/ListPersonel.dart';
import 'Models/ModelCity.dart';
import 'Models/ModelConfirm.dart';
import 'Models/ModelDetailFactor.dart';
import 'Models/ModelFactorsAll.dart';
import 'Models/ModelPIshfactorsNotAccept.dart';
import 'Models/ModelProvice.dart';
import 'Models/ModelRegion.dart';
import 'Models/ModelWay.dart';
import 'Models/OfflineModel.dart';
import 'Models/OnlineModel.dart';
import 'Models/PishCustomer.dart';


class ApiService{

  static ShowSnackbar(String Msg){
    Fluttertoast.showToast(
        msg: Msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        fontSize: 16.0
    );
  }



  static Future<LoginModel> Login(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/login/login');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=loginModelFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();
        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());
      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }

    pr.hide();
    return login;
  }




  static Future<OnlineModel> OnlinePeson(ProgressDialog pr,String Baseurl,String User,String Pass,String  VisRdf) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode(
        { "username":User,
      "password":Pass}) ;
    map['visId'] = VisRdf;



    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Online/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=onlineModelFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();
        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());
      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }

    pr.hide();
    return login;
  }



  static Future<OfflineModel> OfflinePeson(ProgressDialog pr,String Baseurl,String User,String Pass,String  VisRdf,String  Start, String End,String  Start_En, String End_En,String Page) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode(
        { "username":User,
          "password":Pass}) ;
    map['date'] = jsonEncode(
        {
          "fromDate":Start_En,
          "toDate":End_En,
          "fromDateFarsi":Start,
          "toDateFarsi":End}) ;
    map['visId'] = VisRdf;
    map['counter'] = Page;





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Ofline/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=offlineModelFromJson(data);


        if(DATA!=null)
        {
          // if(DATA.code==300)
          //   {
          //     if(DATA.msg.isNotEmpty)
          //     {
          //       ShowSnackbar(DATA.msg);
          //     }
          //   }

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();
        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());
      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }


    return login;
  }





  static Future<OfflineModel> OfflinePesona(ProgressDialog pr,String Baseurl,String User,String Pass,String  VisRdf) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode(
        { "username":User,
          "password":Pass}) ;
    map['date'] = jsonEncode(
        {
          "fromDate":'2021/01/03',
          "toDate":'2021/10/03',
          "fromDateFarsi":'1400/10/10',
          "toDateFarsi":'1400/10/10'}) ;
    map['visId'] = VisRdf;
    map['counter'] = "0";





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Ofline/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=offlineModelFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();
        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());
      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }

    pr.hide();
    return login;
  }





  static Future<CustGroup2> CustGroup(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال دریافت گروه پرسنل..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;




    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
      final url = Uri.parse(Baseurl+'/'+'Api/Atiran/CustGroup/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=custGroupFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();
        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());
      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }

    pr.hide();
    return login;
  }




  static Future<ModelProvice> GetProvice(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال دریافت استان ها..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;




    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.127:33224/manager'+'/'+'Api/Atiran/Provice/List');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Provice/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=modelProviceFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();
        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());
      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }

    pr.hide();
    return login;
  }



  static Future<ModelCity> GetCity(String Baseurl,String User,String Pass,String proviceId,String name) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    // if(!pr.isShowing())
    // {
    //   pr.style(
    //     textAlign: TextAlign.center,
    //     message: 'درحال دریافت شهر ها..',
    //     messageTextStyle: TextStyle(
    //         fontFamily:  'iransans',
    //         fontSize: 14,
    //         color: Colors.black87),
    //   );
    //   await  pr.show();
    // }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    map['proviceId']=jsonEncode(proviceId);
    map['name']=jsonEncode(name);





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/City/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {

        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.body.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=modelCityFromJson(data);
        // var DATA=modelCityFromJson(data);
        // var DATA = json.decode(response.body);
        // var DATA=ModelCity.fromJson();
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {
          login= DATA;
        }else{
          login= DATA;
        }
      }else{

        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());

      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }


    return login;
  }



  static Future<ModelWay> GetWay(String Baseurl,String User,String Pass,String proviceId,String name) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    // if(!pr.isShowing())
    // {
    //   pr.style(
    //     textAlign: TextAlign.center,
    //     message: 'درحال دریافت شهر ها..',
    //     messageTextStyle: TextStyle(
    //         fontFamily:  'iransans',
    //         fontSize: 14,
    //         color: Colors.black87),
    //   );
    //   await  pr.show();
    // }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    map['idRegion']=jsonEncode(proviceId);
    map['name']=jsonEncode(name);





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Masir/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {

        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.body.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=modelWayFromJson(data);
        // var DATA=modelCityFromJson(data);
        // var DATA = json.decode(response.body);
        // var DATA=ModelCity.fromJson();
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {
          login= DATA;
        }else{
          login= DATA;
        }
      }else{

        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());

      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }


    return login;
  }



  static Future<ModelRegion> GetRegion(String Baseurl,String User,String Pass,String idCity,String name) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    // if(!pr.isShowing())
    // {
    //   pr.style(
    //     textAlign: TextAlign.center,
    //     message: 'درحال دریافت شهر ها..',
    //     messageTextStyle: TextStyle(
    //         fontFamily:  'iransans',
    //         fontSize: 14,
    //         color: Colors.black87),
    //   );
    //   await  pr.show();
    // }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    map['idCity']=jsonEncode(idCity);
    map['name']=jsonEncode(name);





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Region/List');
    print(map.toString());
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {

        print('eRROR IS'+error.toString());
        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;

      print('Resi'+response.body.toString());
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        var DATA=modelRegionFromJson(data);
        // var DATA=modelCityFromJson(data);
        // var DATA = json.decode(response.body);
        // var DATA=ModelCity.fromJson();
        print(DATA.toString());
        print(response.body.toString());
        if(DATA.res==true)
        {
          login= DATA;
        }else{
          login= DATA;
        }
      }else{

        print(response.statusCode.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    } on SocketException catch (e)
    {
      print('I am Here'+e.toString());

      login= null;
    }
    on TimeoutException catch (e) {
      print('Error issssssssswwwwww: $e');

    } on Error catch (e) {
      print('Error isssssssss: $e');
    }


    return login;
  }





  static Future<ListCustomer> GetCustomer(String Baseurl,String User,String Pass,
      String groupId,String provinceId,String cityId,
      String regeinId,String masirId,String name,String flagAccount,bool flagg,ProgressDialog pr) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Customer/List');

    // print('PageCounterCustomer is'+PageCounterCustomer.toString());
    // ignore: unrelated_type_equality_checks
    if(flagg==true)
    {
      pr.style(
        textAlign: TextAlign.center,
        message: ' درحال دریافت لیست مشتری    ',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;

    map['groupId']=jsonEncode(groupId);
    map['flagAccount']=jsonEncode(flagAccount);
    map['provinceId']=jsonEncode(provinceId);
    map['cityId']=jsonEncode(cityId);
    map['regeinId']=jsonEncode(regeinId);
    map['masirId']=jsonEncode(masirId);
    map['name']=jsonEncode(name);
    // map['countpage']=PageCounterCustomer;



    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {

        print(error.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=listCustomerFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        // pr.hide();
      }
    }

    catch (e)
    {
      print('Eeror is Herer'+e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;


    }
    pr.hide();
    return login;
  }





  static Future<ListPersonel> GetPerson(String Baseurl,String User,String Pass) async{
    var login;

    // final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Personle/ListOnline');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Personle/ListOnline');


    // ignore: unrelated_type_equality_checks

      // pr.style(
      //   textAlign: TextAlign.center,
      //   message: ' درحال دریافت لیست پرسنل',
      //   messageTextStyle: TextStyle(
      //       fontFamily:  'iransans',
      //       fontSize: 14,
      //       color: Colors.black87),
      // );
      // await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;





    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),

      ).catchError((error) {
        // pr.hide();
        print(error.toString());

        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=listPersonelFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        // pr.hide();
      }
    }catch (e)
    {
      print('Eeror is Herer'+e.toString());

      login= null;
      // pr.hide();

    }
    return login;
  }



  static Future<PishCustomer> GetPishCustomer(ProgressDialog pr,String Baseurl,String User,String Pass,String custId) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/ListCustomer');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال دریافت لیست پیش دریافت های مشتری',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['custId'] =custId ;


    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print(error.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=pishCustomerFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {
      print('Eeror is Herer'+e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }


  static Future<ModelDetailFactor> GetDetailFactor(ProgressDialog pr,String Baseurl,String User,String Pass,String shFacfo) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/Details');


    // ignore: unrelated_type_equality_checks

      pr.style(
        textAlign: TextAlign.center,
        message: ' درحال دریافت اطلاعات فاکتور',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['shFacfo'] =shFacfo ;


    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print(error.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=modelDetailFactorFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {
      print('Eeror is Herer'+e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }


  static Future<ModelConfirm> Confirm(ProgressDialog pr,String Baseurl,String User,String Pass,String shFacfo,bool Flag,String comment) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Confirm/Confirm');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['confirm'] =
        jsonEncode({
          "flag":Flag,
          "shfacfo":shFacfo,
          "comment":comment}) ;



    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print(error.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=modelConfirmFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {
      print('Eeror is Herer'+e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



  static Future<ModelFactorsAll> PishFactorsAlls(ProgressDialog pr,String Baseurl,String User,String Pass,String fromDate,String toDate,int flag) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/Report');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['date'] =
        jsonEncode({
          "fromDate":fromDate,
          "flag":flag,
          "toDate":toDate}) ;



    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print(error.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=modelFactorsAllFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {
      print('Eeror is Herer'+e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



  static Future<ModelPIshfactorsNotAccept> PishFactorsNotAccept(ProgressDialog pr,String Baseurl,String User,String Pass,String DataFrom,String DateTo) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/List');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال دریافت لیست پیش فاکتور های تایید تشده',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['date'] = jsonEncode({ "fromDate":DataFrom,
      "toDate":DateTo}) ;





    print('sgfsfgsdfgfdsg'+map.toString());

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        print(error.toString());
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        print('Its Ok Request Nima');
        String data=response.body;
        print(data);
        var DATA=modelPIshfactorsNotAcceptFromJson(data);
        print(DATA.toString());
        print(response.body.toString());
        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {
      print('Eeror is Herer'+e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }





}