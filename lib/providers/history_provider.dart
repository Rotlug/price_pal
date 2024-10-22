import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  late List<Purchase> history = [];
  final SharedPreferencesAsync sp = SharedPreferencesAsync();

  HistoryProvider() {
    getHistory().then((value) => history = value);
  }

  Future<List<Purchase>> getHistory() async {
    String? historyJson = await sp.getString("history");
    if (historyJson == null) return [];

    List<dynamic> list = jsonDecode(historyJson);
    return list.map((e) => Purchase.fromJson(e)).toList();
  }

  Future<List<Purchase>> addToHistory(Purchase purchase) async {
    history.add(purchase);
    notifyListeners();

    await sp.setString("history", jsonEncode(history));
    return [];
  }
}

class Purchase {
  final String item;
  final String price;

  Purchase(this.item, this.price);

  Purchase.fromJson(Map<String, dynamic> json)
      : item = json['item'] as String,
        price = json['price'] as String;

  Map<String, dynamic> toJson() => {'item': item, 'price': price};
}
