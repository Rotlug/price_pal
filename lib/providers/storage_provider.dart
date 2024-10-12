import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider extends ChangeNotifier {
  late final FlutterSecureStorage storage;

  StorageProvider() {
    storage = const FlutterSecureStorage();
  }
}
