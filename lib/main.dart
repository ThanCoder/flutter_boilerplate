import 'package:flutter/material.dart';
import 'package:than_pkg/than_pkg.dart';
import './app/general_server/index.dart';

import 'app/my_app.dart';
import 'app/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThanPkg.windowManagerensureInitialized();

  //init config
  await initAppConfigService();

  await GeneralServices.instance.init(packageName: 'flutter_boilerplate');

  runApp(const MyApp());
}
