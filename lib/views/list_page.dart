import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/viewmodels/list_model.dart';
import 'package:usstockmemo/views/edit_page.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListModel>(
      create: (_) => ListModel()..fetchMemos(),
      child: Scaffold(
        body: Consumer<ListModel>(
          builder: (context, model, child) {
            final memos = model.memos;
            final listTiles = memos
                .map(
                  (memo) => Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          title: Column(
                            children: [
                              Text(
                                memo.name,
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '(' + memo.ticker.toUpperCase() + ')',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    memo.market.toUpperCase(),
                                    textAlign: TextAlign.center,
                                  ),
                                  // SizedBox(
                                  //   width: 8,
                                  // ),
                                  // Text('登録日時')
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(memo.memo),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton.icon(
                              color: Colors.blue,
                              shape: StadiumBorder(),
                              icon: Icon(Icons.edit),
                              label: Text('編集'),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(
                                      stockmemo: memo,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                                model.fetchMemos();
                              },
                            ),
                            RaisedButton.icon(
                              color: Colors.red,
                              shape: StadiumBorder(),
                              icon: Icon(Icons.delete),
                              label: Text('削除'),
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('${memo.name}を削除しますか？'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await deleteMemo(
                                                context, model, memo);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<ListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchMemos();
              },
            );
          },
        ),
      ),
    );
  }

  Future deleteMemo(
      BuildContext context, ListModel model, StockMemo memo) async {
    try {
      await model.deleteMemo(memo);
      await _showDialog(context, '削除しました');
      await model.fetchMemos();
    } catch (e) {
      await _showDialog(context, e.toString());
      print(e.toString());
    }
  }

  Future _showDialog(BuildContext context, String title) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
