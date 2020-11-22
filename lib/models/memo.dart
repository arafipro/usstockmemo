// メモモデル
class Memo {
  int id;
  String name;          // 銘柄名
  String ticker;        // ティッカー
  String market;        // 市場
  String memo;          // メモ
  DateTime recordedAt;  // 記録日時

  Memo(this.name, this.ticker, this.market, this.memo, this.recordedAt);
  Memo.withId(this.id, this.name, this.ticker, this.market, this.memo, this.recordedAt);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['ticker'] = ticker;
    map['market'] = market;
    map['memo'] = memo;
    map['recordedAt'] = recordedAt;

    return map;
  }

  Memo.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.ticker = map['ticker'];
    this.market = map['market'];
    this.memo = map['memo'];
    this.recordedAt = map['recordedAt'];
  }
}
