import 'package:find_me/app/locator.dart';
import 'package:find_me/caches/preferences.dart';
import 'package:find_me/ui/find_me.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init locator (DI)
  setupLocator();
  //init hive
  await Hive.initFlutter();
  await locator<Preferences>().openBox();
  runApp(FindMe());
}
