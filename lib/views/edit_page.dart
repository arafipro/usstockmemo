import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usstockmemo/components/adbanner.dart';
import 'package:usstockmemo/components/ad.dart';
import 'package:usstockmemo/components/tf.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/viewmodels/edit_model.dart';

class EditPage extends StatelessWidget {
  EditPage({
    this.stockmemo,
  });
  final StockMemo stockmemo;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = stockmemo != null;
    final nameController = TextEditingController();
    final tickerController = TextEditingController();
    final memoController = TextEditingController();

    if (isUpdate) {
      nameController.text = stockmemo.name;
      tickerController.text = stockmemo.ticker;
      memoController.text = stockmemo.memo;
    }

    return ChangeNotifierProvider<EditModel>(
      create: (_) => EditModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '米国株投資メモ - 編集' : '米国株投資メモ - 新規登録'),
        ),
        body: Consumer<EditModel>(
          builder: (context, model, child) {
            return Form(
              key: _key,
              child: ListView(
                children: [
                  AdBanner(),
                  TF(
                    controller: nameController,
                    labelText: '銘柄名',
                    maxLines: 1,
                    onChanged: (text) {
                      model.stockName = text;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return '銘柄名を入力してください';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TF(
                    controller: tickerController,
                    labelText: 'ティッカー',
                    maxLines: 1,
                    maxLength: 5,
                    onChanged: (text) {
                      model.stockTicker = text;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ティッカーを入力してください';
                      }
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(
                          '市場',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        subtitle: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.black26,
                          ),
                          onChanged: (value) {
                            model.onChanged(value);
                            stockmemo.market = value;
                          },
                          value:
                              isUpdate ? stockmemo.market : model.dropdownValue,
                          items: model.markets.map<DropdownMenuItem<String>>(
                            (String text) {
                              return DropdownMenuItem<String>(
                                value: text,
                                child: Text(text),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  TF(
                    controller: memoController,
                    maxLines: 10,
                    labelText: 'メモ',
                    onChanged: (text) {
                      model.stockMemo = text;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'メモを入力してください';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text(
                        isUpdate ? '編集完了' : '保存',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () async {
                        model.startLoading();
                        if (_key.currentState.validate()) {
                          if (isUpdate) {
                            await updateMemo(model, context);
                          } else {
                            await addMemo(model, context);
                          }
                        }
                        model.endLoading();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future addMemo(EditModel model, BuildContext context) async {
    try {
      await model.addMemo();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AD(
            title: '保存しました',
            buttonText: 'OK',
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AD(
            title: e.toString(),
            buttonText: 'OK',
          );
        },
      );
    }
  }

  Future updateMemo(EditModel model, BuildContext context) async {
    try {
      await model.updateMemo(stockmemo);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AD(
            title: '変更しました',
            buttonText: 'OK',
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AD(
            title: e.toString(),
            buttonText: 'OK',
          );
        },
      );
    }
  }
}
