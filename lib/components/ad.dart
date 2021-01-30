import 'package:flutter/material.dart';

// AlertDialogコンポーネント
class AD extends StatelessWidget {
  AD({
    this.title,
    this.buttonText,
    this.onPressed,
  });

  final String title;
  final String buttonText;
  final onPressed;

  @override
  Widget build(BuildContext context) {
		return AlertDialog(
			title: Text(title),
			actions: <Widget>[
				FlatButton(
					child: Text(buttonText),
					// onPressedを三項演算子で制御
					// onPressedが未指定(null)の場合はNavigator.of(context).pop()を返す
					onPressed: onPressed == null
							? () {
									Navigator.of(context).pop();
								}
							// onPressedが指定された場合は指示に従う
							: onPressed,
				),
			],
		);
  }
}
