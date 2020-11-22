import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usstockmemo/viewmodels/market_list_model.dart';

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MarketListModel>(
      create: (_) => MarketListModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('US Stock Memo Edit'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Stock Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ticker',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
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
                      items: model.markets
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ));
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Attention',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
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
