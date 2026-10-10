import 'package:app/app.dart';
import 'package:app/config/dependencies.dart';
import 'package:app/config/device_info.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DeviceInfo.instance.initialize();
  configDependencies();
  runApp(const MyApp());
}
