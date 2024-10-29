import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider extends ChangeNotifier {
  late final FlutterSecureStorage storage;

  /// The `StorageProvider` provides the FlutterSecureStorage object,
  /// Which can be used to access and store data in an ecrypted manner.
  StorageProvider() {
    storage = const FlutterSecureStorage();
  }
}
