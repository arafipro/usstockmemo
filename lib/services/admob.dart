import 'dart:io';
import 'package:flutter/material.dart';

class AdMobService {
  String getBannerAdUnitId() {
    // iOSとAndroidで広告ユニットIDを分岐させる
    if (Platform.isAndroid) {
      // Androidの広告ユニットID
      return 'ca-app-pub-2054344840815103/2988667404';
      // テスト用
      // return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      // iOSの広告ユニットID
      return 'ca-app-pub-2054344840815103/7031213568';
    }
    return null;
  }

  // 表示するバナー広告の高さを計算
  double getHeight(BuildContext context) {
    final height = WidgetsBinding.instance.window.viewInsets.bottom;
    final percent = (height * 0.06).toDouble();

    return percent;
  }
}
