import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:usstockmemo/services/admob.dart';

class AdBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdmobBanner(
      adUnitId: AdMobService().getBannerAdUnitId(),
      adSize: AdmobBannerSize(
        width: WidgetsBinding.instance.window.physicalSize.width.toInt(),
        height: AdMobService().getHeight(context).toInt(),
        name: 'SMART_BANNER',
      ),
    );
  }
}
// 参考資料
// AdMobのバナー広告を超簡単に設置する
// https://yaba-blog.com/flutter-admob/

// MediaQueryの代わりにWidgetsBinding.instance.windowを使用する
// https://stackoverflow.com/questions/50214338/
