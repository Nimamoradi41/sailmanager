import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanager/Models/ModelProvice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ApiService.dart';
import 'Constants.dart';
import 'Models/CustGroup.dart';
import 'Models/ListCustomer.dart';
import 'Models/ListPersonel.dart';
import 'Models/ModelCity.dart';

class DataBseFile {

  int PageCounterCustomer = 0;
  int PageCounterCity = 0;

  DataBseFile._();

  static final DataBseFile db = DataBseFile._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null)
      return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await Init();
    return _database;
  }

  DataBseFile();

  static final Customer_tbl = "Customer";
  static final Personel_tbl = "Personel";
  static final CustProup_tbl = "CustProup";
  static final Province_tbl = "Province";
  static final City_tbl = "City";
  String path = '';


  newCustomer(Re_Customer s) async {
    final db = await database;
    var res = await db!.rawInsert('''
        INSERT INTO Customer (
        id, name, tell1, tell2, groupId, address, provinceId, cityId, masirId, reginId    
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', [
      s.id,
      s.name,
      s.tell1,
      s.tell2,
      // s.phone,
      s.groupId,
      s.address,
      s.provinceId,
      s.cityId,
      s.masirId,
      s.reginId
    ]);
    print(res.toString());
    return res;
  }


  Init({String dbname: 'managerdatabase.db'}) async {
    return await openDatabase(join(await getDatabasesPath(), dbname),
        onCreate: (Database db, int version) async {
          await db.execute('''
              CREATE TABLE Personel (
              visRdf text,
              name text not null,
              tell1 text not null,
              tell2 text not null,
              cell text not null)
                           ''');

          await db.execute('''
              CREATE TABLE Province (
              id text,
              name text not null)
                           ''');


          await db.execute('''
              CREATE TABLE City (
              id text,
              cityId text not null,
              name text not null)
                           ''');


          await db.execute('''
              CREATE TABLE CustProup (
              id text,
              name text not null)
                           ''');


          await db.execute('''
              CREATE TABLE Customer (
              id text not null,
              name text not null,
              tell1 text not null,
              tell2 text not null,
              groupId text not null,
              address text not null,
              provinceId text not null,
              cityId text not null,
              masirId text not null,
              reginId text not null)
                           ''');
        }, version: 1);
  }


  Future GetPersonel() async
  {
    // List<RePerson> Personel = <RePerson>[];
    // final db = await database;
    // var res = await db!.query("Personel");
    // res.forEach((result) {
    //   var dd = result;
    //   var visRdf = 0;
    //   var name = dd['name'].toString();
    //   String tell1 = dd['tell1'].toString();
    //   String tell2 = dd['tell2'].toString();
    //   String cell = dd['cell'].toString();
    //   if (dd['visRdf']
    //       .toString()
    //       .isEmpty) {
    //     visRdf = 0;
    //   } else {
    //     visRdf = int.parse(dd['visRdf'].toString());
    //   }
    //   var s = RePerson(tell2: tell2,
    //       tell1: tell1,
    //       cell: cell,
    //       name: name,
    //       visRdf: visRdf);
    //   Personel.add(s);
    // });
    // return Personel;
    // close();

  }


  Future<List<Re_Customer>> GetCustomer() async
  {
    List<Re_Customer> Customers = <Re_Customer>[];
    final db = await database;
    var res = await db!.query("Customer");
    print(res.length.toString());
    res.forEach((result) {
      var dd = result;
      var visRdf = 0;
      var name = dd['name'].toString();
      int id = int.parse(dd['id'].toString());
      String tell1 = dd['tell1'].toString();
      String tell2 = dd['tell2'].toString();
      // String phone = dd['phone'].toString();
      int groupId = int.parse(dd['groupId'].toString());
      String address = dd['address'].toString();
      int provinceId = int.parse(dd['provinceId'].toString());
      int cityId = int.parse(dd['cityId'].toString());
      int masirId = int.parse(dd['masirId'].toString());
      int reginId = int.parse(dd['reginId'].toString());



      // var s = Customer_Db(
      //     tell2: tell2,
      //     tell1: tell1,
      //     // phone: phone,
      //     groupId: groupId,
      //     address: address,
      //     provinceId: provinceId,
      //     cityId: cityId,
      //     masirId: masirId,
      //     reginId: reginId,
      //     name: name,
      //     id: id);
      // Customers.add(s);
    });
    return Customers;
    // close();

  }


  Future<List<ReCustGroup_2>> GetCusgroups() async
  {
    List<ReCustGroup_2> Customers = <ReCustGroup_2>[];
    final db = await database;
    var res = await db!.query("CustProup");
    print(res.length.toString());
    res.forEach((result) {
      var dd = result;
      var visRdf = 0;
      var name = dd['name'].toString();
      int id = int.parse(dd['id'].toString());




      var s = ReCustGroup_2(
          id: id,
          name: name,
         );
      Customers.add(s);
    });
    return Customers;
    // close();

  }


  Future<List<Re_Provice>> GetPrivice() async
  {
    List<Re_Provice> Customers = <Re_Provice>[];
    final db = await database;
    var res = await db!.query("Province");
    print(res.length.toString());
    res.forEach((result) {
      var dd = result;
      var visRdf = 0;
      var name = dd['name'].toString();
      int id = int.parse(dd['id'].toString());




      var s = Re_Provice(
        id: id.toString(),
        name: name,
      );
      Customers.add(s);
    });
    return Customers;
    // close();

  }



  Future<List<ReC_City>> GetCity() async
  {
    List<ReC_City> Customers = <ReC_City>[];
    final db = await database;
    var res = await db!.query("City");
    print(res.length.toString());
    res.forEach((result) {
      var dd = result;
      var visRdf = 0;
      var name = dd['name'].toString();
      var cityId = dd['cityId'].toString();
      int id = int.parse(dd['id'].toString());



      var s = ReC_City(
        id:"-7",
        name: '',
        provinceId: "-7",
      );



      Customers.add(s);
    });
    return Customers;
    // close();
  }



  Future Insert_Allof_Customer(List<Re_Customer> model, bool Flag) async
  {
    print('model '+model.length.toString());
    final db = await database;
    if (Flag) {
      print('is Trureeeee');
      await db!.delete(Customer_tbl);
    }


    // var dd = await Future.wait(model.map((e) async {
    //   var ress = await db!.insert(Customer_tbl, e.toJson(),
    //       conflictAlgorithm: ConflictAlgorithm.ignore);
    //   print('Id is ' + ress.toString());
    //   return ress.toString();
    // }));




    var dd = await Future.wait(model.map((e) async {
      var ress = await newCustomer(e);
      print('Id is ' + ress.toString());
      return ress.toString();
    }));


    // final db=await database;
    // var page= 9;
    // var pageCounter=0;
    // if(page==0)
    //   {
    //     var res2  =await db!.delete('Customer');
    //   }
    //
    // if(pageCounter<page)
    // {
    //     var dd=  await Future.wait(model.map((e) async {
    //       var uuid = Uuid();
    //       e.id=uuid.v1().toString();
    //       var ress=  await db!.insert(Customer_tbl,e.ToMapDatabase(),conflictAlgorithm: ConflictAlgorithm.replace);
    //       print('Id is '+ress.toString());
    //       return ress.toString();
    //     }));
    //     print(dd.toString());
    //     pageCounter=pageCounter+1;
    //     print('Conter is'+pageCounter.toString());
    //     return pageCounter.toString();
    //     Insert_Allof_Customer(model);
    //
    //   }


    // close();


  }




  Future Insert_Allof_Personel(List<RePerson> model) async
  {
    final db = await database;

    print('is Trureeeee');
    await db!.delete(Personel_tbl);

    var dd = await Future.wait(model.map((e) async {
      var ress = await db.insert(Personel_tbl, e.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      print('Id is ' + ress.toString());
      return ress.toString();
    }));


    // final db=await database;
    // var page= 9;
    // var pageCounter=0;
    // if(page==0)
    //   {
    //     var res2  =await db!.delete('Customer');
    //   }
    //
    // if(pageCounter<page)
    // {
    //     var dd=  await Future.wait(model.map((e) async {
    //       var uuid = Uuid();
    //       e.id=uuid.v1().toString();
    //       var ress=  await db!.insert(Customer_tbl,e.ToMapDatabase(),conflictAlgorithm: ConflictAlgorithm.replace);
    //       print('Id is '+ress.toString());
    //       return ress.toString();
    //     }));
    //     print(dd.toString());
    //     pageCounter=pageCounter+1;
    //     print('Conter is'+pageCounter.toString());
    //     return pageCounter.toString();
    //     Insert_Allof_Customer(model);
    //
    //   }


    // close();


  }


  Future Insert_Allof_CustGrops(List<ReCustGroup_2> model) async
  {
    final db = await database;

    print('is Trureeeee');
    await db!.delete(CustProup_tbl);

    var dd = await Future.wait(model.map((e) async {
      var ress = await db.insert(CustProup_tbl, e.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      print('Id is ' + ress.toString());
      return ress.toString();
    }));


    // final db=await database;
    // var page= 9;
    // var pageCounter=0;
    // if(page==0)
    //   {
    //     var res2  =await db!.delete('Customer');
    //   }
    //
    // if(pageCounter<page)
    // {
    //     var dd=  await Future.wait(model.map((e) async {
    //       var uuid = Uuid();
    //       e.id=uuid.v1().toString();
    //       var ress=  await db!.insert(Customer_tbl,e.ToMapDatabase(),conflictAlgorithm: ConflictAlgorithm.replace);
    //       print('Id is '+ress.toString());
    //       return ress.toString();
    //     }));
    //     print(dd.toString());
    //     pageCounter=pageCounter+1;
    //     print('Conter is'+pageCounter.toString());
    //     return pageCounter.toString();
    //     Insert_Allof_Customer(model);
    //
    //   }


    // close();


  }


  Future Insert_Allof_Provice(List<Re_Provice> model) async
  {
    final db = await database;

    print('is Trureeeee');
    await db!.delete(Province_tbl);

    var dd = await Future.wait(model.map((e) async {
      var ress = await db.insert(Province_tbl, e.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      print('Id is ' + ress.toString());
      return ress.toString();
    }));


    // final db=await database;
    // var page= 9;
    // var pageCounter=0;
    // if(page==0)
    //   {
    //     var res2  =await db!.delete('Customer');
    //   }
    //
    // if(pageCounter<page)
    // {
    //     var dd=  await Future.wait(model.map((e) async {
    //       var uuid = Uuid();
    //       e.id=uuid.v1().toString();
    //       var ress=  await db!.insert(Customer_tbl,e.ToMapDatabase(),conflictAlgorithm: ConflictAlgorithm.replace);
    //       print('Id is '+ress.toString());
    //       return ress.toString();
    //     }));
    //     print(dd.toString());
    //     pageCounter=pageCounter+1;
    //     print('Conter is'+pageCounter.toString());
    //     return pageCounter.toString();
    //     Insert_Allof_Customer(model);
    //
    //   }


    // close();


  }


  Future Insert_Allof_City(List<ReC_City> model, bool Flag) async
  {
    final db = await database;
    if (Flag) {
      print('is Trureeeee');
      await db!.delete(City_tbl);
    }


    var dd =
        await Future.wait(model.map((e) async {
      var ress = await db!.insert(
          City_tbl, e.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
      print('Id is ' + ress.toString());
      return ress.toString();
    }));
  }


  ShowSnackbar(String Msg) {
    Fluttertoast.showToast(
        msg: Msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: BaseColor,
        fontSize: 16.0
    );
  }


  Future<String> SendRequestCustomer(ProgressDialog pro, String Len,
      int Counter) async
  {
    String StrTime = '';
    var Flag2 = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base = prefs.getString('Baseurl');
    var UserName = prefs.getString('UserName');
    var Password = prefs.getString('Password');
    print('PageCounterCustomer' + PageCounterCustomer.toString());
    // var Data = await ApiService.GetCustomer(
    //     pro,
    //     base!,
    //     UserName!,
    //     Password!,
    //     PageCounterCustomer.toString(),
    //     Len,
    //     Counter);
    // if (PageCounterCustomer == 0) {
    //   Flag2 = true;
    // }
    // PageCounterCustomer = PageCounterCustomer + 1;
    // if (Data.res.list != null) {
    //   var ss = await Insert_Allof_Customer(Data.res.list, Flag2);
    // }
    //
    //
    // if(PageCounterCustomer<Data.res.page)
    // {
    //   Counter=Counter+Data.res.list.length;
    //   SendRequestCustomer(pro, Data.res.count.toString(),Counter);
    // }else{
    // PageCounterCustomer = 0;
    // Jalali j = Jalali.now();
    //
    // var d = DateTime.now();
    // StrTime =
    //     Convert_DATE(j.day.toString(), j.month.toString(), j.year.toString());
    // StrTime = StrTime + " " + d.hour.toString() + ":" + d.minute.toString();
    //
    // pro.hide();
    // if (Data != null) {
    //   if (Data.code == 200) {
    //     ApiService.ShowSnackbar('همگام سازی مشتری ها  با موفقیت انجام شد');
    //   } else {
    //     ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    //   }
    // } else {
    //   ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    // }
    //
    //
    // }


    return StrTime;


    print('fINISHEED');
    // Map<String, dynamic> toJson() => {
    //   "error": error,
    //   "code": code,
    //   "msg": msg,
    //   "result": result,
    // };


    // var Str=await Insert_Allof_Customer(model);
    // var Len=model.length.toString();
    // pro.update(
    //     message:' درحال دریافت لیست پرسنل $PageCounterCustomer/$Len '
    // );
    //
    // var Len2=model.length;
    // if(PageCounterCustomer<Len2)
    //   {
    //     PageCounterCustomer=PageCounterCustomer+1;
    //    await  SendRequestCustomer( pro, model);
    //   }else{
    //   pro.hide();
    // }
  }


  Future SendRequestPersonel(ProgressDialog pro) async
  {
  //   String StrTime = '';
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var base = prefs.getString('Baseurl');
  //   var UserName = prefs.getString('UserName');
  //   var Password = prefs.getString('Password');
  //   print('PageCounterCustomer' + PageCounterCustomer.toString());
  //   var Data = await ApiService.GetPerson(pro, base!, UserName!, Password!);
  //   if (Data != null) {
  //     await Insert_Allof_Personel(Data.res);
  //   }
  //
  //   Jalali j = Jalali.now();
  //
  //   var d = DateTime.now();
  //   StrTime =
  //       Convert_DATE(j.day.toString(), j.month.toString(), j.year.toString());
  //   StrTime = StrTime + " " + d.hour.toString() + ":" + d.minute.toString();
  //
  //   pro.hide();
  //   if (Data != null) {
  //     if (Data.code == 200) {
  //       ApiService.ShowSnackbar('همگام سازی مشتری ها  با موفقیت انجام شد');
  //     } else {
  //       ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
  //     }
  //   } else {
  //     ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
  //   }
  //
  //   return StrTime;
  // }
  //
  //
  // Future<String> SendRequestCustGroups(ProgressDialog pro) async
  // {
  //   String StrTime = '';
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var base = prefs.getString('Baseurl');
  //   var UserName = prefs.getString('UserName');
  //   var Password = prefs.getString('Password');
  //   print('PageCounterCustomer' + PageCounterCustomer.toString());
  //   var Data = await ApiService.CustGroup(pro, base!, UserName!, Password!);
  //   if (Data != null) {
  //     await Insert_Allof_CustGrops(Data.res);
  //   }
  //   Jalali j = Jalali.now();
  //
  //   var d = DateTime.now();
  //   StrTime =
  //       Convert_DATE(j.day.toString(), j.month.toString(), j.year.toString());
  //   StrTime = StrTime + " " + d.hour.toString() + ":" + d.minute.toString();
  //
  //   pro.hide();
  //   ApiService.ShowSnackbar('همگام سازی گروه گالا  با موفقیت انجام شد');
  //   return StrTime;
  // }
  //
  //
  // Future<String> SendRequestProvice(ProgressDialog pro) async
  // {
  //   String StrTime = '';
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var base = prefs.getString('Baseurl');
  //   var UserName = prefs.getString('UserName');
  //   var Password = prefs.getString('Password');
  //   print('PageCounterCustomer' + PageCounterCustomer.toString());
  //   var Data = await ApiService.GetProvice(pro, base!, UserName!, Password!);
  //   if (Data != null) {
  //     // if(Data.res.length>0)
  //     //   {
  //     //     prefs.setString('ProviceId',Data.res[0].id.toString());
  //     //   }
  //
  //     await Insert_Allof_Provice(Data.res);
  //   }
  //   Jalali j = Jalali.now();
  //
  //   var d = DateTime.now();
  //   StrTime =
  //       Convert_DATE(j.day.toString(), j.month.toString(), j.year.toString());
  //   StrTime = StrTime + " " + d.hour.toString() + ":" + d.minute.toString();
  //
  //   pro.hide();
  //   ApiService.ShowSnackbar('همگام سازی استان ها با موفقیت انجام شد');
  //   return StrTime;
  }


  Future<String> SendRequestCity(ProgressDialog pro, String Len, int Counter) async
  {
    String StrTime = '';
    var Flag2 = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base = prefs.getString('Baseurl');
    var UserName = prefs.getString('UserName');
    var Password = prefs.getString('Password');
    print('PageCounterCustomer' + PageCounterCity.toString());
    // var Data = await ApiService.GetCity(
    //     pro,
    //     base!,
    //     UserName!,
    //     Password!,
    //     PageCounterCity.toString(),
    //     Len,
    //     Counter);
    if (PageCounterCity == 0) {
      Flag2 = true;
    }
    PageCounterCity = PageCounterCity + 1;
    // if (Data.res != null) {
    //   var ss = await Insert_Allof_City(Data.res, Flag2);
    // }


    // if (PageCounterCity < Data.page) {
    //   Counter = Counter + Data.res.length;
    //   SendRequestCity(pro, Data.res.toString(), Counter);
    // } else {
      PageCounterCity = 0;
      Jalali j = Jalali.now();
      var d = DateTime.now();
      StrTime =
          Convert_DATE(j.day.toString(), j.month.toString(), j.year.toString());
      StrTime = StrTime + " " + d.hour.toString() + ":" + d.minute.toString();

      pro.hide();
      // if (Data != null) {
      //   if (Data.code == 200) {
      //     ApiService.ShowSnackbar('همگام سازی شهر ها  با موفقیت انجام شد');
      //   } else {
      //     ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
      //   }
      // } else {
      //   ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
      // }


    // }
    return StrTime;
  }
}