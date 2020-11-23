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
        appBar: AppBar(
          title: Text('US Stock Memo List'),
        ),
        body: Consumer<ListModel>(
          builder: (context, model, child) {
            final memos = model.memos;
            final listTiles = memos
                .map(
                  (memo) => ListTile(
                    title: Text(memo.name),
                    subtitle: Text(memo.market),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            // todo: 画面遷移
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
                            // todo: 削除
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
                                        // todo: 削除のAPIを叩く
                                        await deleteMemo(context, model, memo);
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
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
      ),
    );
  }

  Future deleteMemo(BuildContext context, ListModel model, StockMemo memo) async {
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
