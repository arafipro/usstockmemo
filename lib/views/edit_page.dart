import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usstockmemo/components/tf.dart';
import 'package:usstockmemo/models/stock_memo.dart';
import 'package:usstockmemo/viewmodels/market_list_model.dart';

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

    return ChangeNotifierProvider<MarketListModel>(
      create: (_) => MarketListModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '編集' : '追加'),
        ),
        body: ListView(
          children: [
            TF(
              controller: nameController,
              labelText: 'Stock Name',
              onChanged: (text) {
                print(text);
              },
            ),
            TF(
              controller: tickerController,
              labelText: 'Ticker',
              onChanged: (text) {
                print(text);
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
                Consumer<MarketListModel>(
                  builder: (context, model, child) {
                    return ListTile(
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
                    );
                  },
                ),
              ],
            ),
            TF(
              controller: nameController,
              maxLines: 10,
              labelText: 'Memo',
              onChanged: (text) {
                print(text);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Expanded(
                child: RaisedButton(
                  color: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorLight,
                  child: Text(
                    'save',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    print('save');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
