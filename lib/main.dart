import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/services/app_config_services.dart';
import 'package:window_manager/window_manager.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux) {
    await WindowManager.instance.ensureInitialized();
  }
  //init config
  await initAppConfigService();

  runApp(const MyApp());
}
