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
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            memo.name,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '(' + memo.ticker.toUpperCase() + ')',
                          ),
                        ],
                      ),
                      subtitle: Text(memo.market.toUpperCase()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
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
                          IconButton(
                            icon: Icon(Icons.delete),
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
