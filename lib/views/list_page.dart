import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  (memos) => ListTile(
                    title: Text(memos.name),
                    subtitle: Text(memos.market),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.edit),                       onPressed: () async {
                        // todo: 画面遷移
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                              stockmemo: memos,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchMemos();
                      },
),
                        IconButton(icon: Icon(Icons.delete), onPressed: () {}),
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
}
