import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';


//
// class LocalAuthApi{
//   static final auth=LocalAuthentication();
//
//
//   static  Future<bool> HasBioMetric() async{
//     try{
//         return await auth.canCheckBiometrics;
//     }on PlatformException catch(e)
//     {
//       print('Eerror is Herr22'+e.toString());
//       return false;
//     }
//   }
//
//    static Future<bool> authenticate() async{
//     var hasfinger=await HasBioMetric();
//     if(!hasfinger) return false;
//     try{
//
//       return await auth.authenticateWithBiometrics(localizedReason: 'احراز هویت ',
//           useErrorDialogs: true,
//            stickyAuth: true );
//     }catch(w)
//      {
//        print('Eerror is Herr'+w.toString());
//        return false;
//      }
//    }
//
//

// }