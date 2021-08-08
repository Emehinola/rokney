import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet {
  Future<bool> checkConnection(ConnectivityResult sub) async {
    if ((sub == ConnectivityResult.mobile) | (sub == ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
