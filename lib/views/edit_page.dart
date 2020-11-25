import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usstockmemo/components/tf.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/viewmodels/edit_model.dart';

class EditPage extends StatelessWidget {
  EditPage({this.stockmemo});
  final StockMemo stockmemo;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = stockmemo != null;
    final nameController = TextEditingController();
    final tickerController = TextEditingController();
    final marketController = TextEditingController();
    final memoController = TextEditingController();

    if (isUpdate) {
      nameController.text = stockmemo.name;
      tickerController.text = stockmemo.ticker;
      marketController.text = stockmemo.market;
      memoController.text = stockmemo.memo;
    }

    return ChangeNotifierProvider<EditModel>(
      create: (_) => EditModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? 'Edit' : 'New'),
        ),
        body: Consumer<EditModel>(
          builder: (context, model, child) {
            return ListView(
              children: [
                TF(
                  controller: nameController,
                  labelText: 'Stock Name',
                  maxLines: 1,
                  onChanged: (text) {
                    model.stockName = text;
                  },
                ),
                TF(
                  controller: tickerController,
                  labelText: 'Ticker',
                  maxLines: 1,
                  onChanged: (text) {
                    model.stockTicker = text;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Market',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    ListTile(
                      subtitle: DropdownButton<String>(
                        underline: Container(
                          height: 1,
                          color: Colors.black26,
                        ),
                        value: model.dropdownValue,
                        onChanged: model.onChanged,
                        items: model.markets.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
                  labelText: 'Memo',
                  onChanged: (text) {
                    model.stockMemo = text;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      isUpdate ? 'Edited' : 'Saved',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () async {
                      model.startLoading();
                      if (isUpdate) {
                        await updateMemo(model, context);
                      } else {
                        await addMemo(model, context);
                      }
                      model.endLoading();
                    },
                  ),
                ),
              ],
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
          return AlertDialog(
            title: Text('Saved'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
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
          return AlertDialog(
            title: Text('Updated'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
