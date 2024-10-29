import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryProvider extends ChangeNotifier {
  late List<Purchase> history = [];
  final SharedPreferencesAsync _sp = SharedPreferencesAsync();

  /// The `HistoryProvider` class is used to access and add `Purchase`s
  /// to the shopping history of the user.
  HistoryProvider() {
    getHistory().then((value) => history = value);
  }

  Future<List<Purchase>> getHistory() async {
    String? historyJson = await _sp.getString("history");
    if (historyJson == null) return [];

    List<dynamic> list = jsonDecode(historyJson);
    List<Purchase> result = list.map((e) => Purchase.fromJson(e)).toList();

    history = result;
    notifyListeners();

    return result;
  }

  Future<void> addToHistory(Purchase purchase) async {
    history.add(purchase);
    notifyListeners();
    await _sp.setString("history", jsonEncode(history));
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
