import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage with a specific storage name.
  await GetStorage.init("checkb");
  runApp(const MyApp());
}
