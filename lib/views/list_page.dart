import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usstockmemo/components/ad.dart';
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
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    memo.market.toUpperCase(),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  memo.memo,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '登録日時：' + memo.createdAt,
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '更新日時：' + memo.updatedAt,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
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
                                    return AD(
                                      title: '${memo.name}を削除しますか？',
                                      buttonText: 'OK',
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await deleteMemo(context, model, memo);
                                      },
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
        return AD(
          title: title,
          buttonText: 'OK',
        );
      },
    );
  }
}
