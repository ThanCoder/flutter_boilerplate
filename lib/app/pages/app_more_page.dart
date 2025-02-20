import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/notifiers/app_notifier.dart';
import 'package:flutter_boilerplate/app/services/index.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/app/widgets/index.dart';

class AppMorePage extends StatefulWidget {
  const AppMorePage({super.key});

  @override
  State<AppMorePage> createState() => _AppMorePageState();
}

class _AppMorePageState extends State<AppMorePage> {
  String version = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    try {
      final res = await PackageInfo.fromPlatform();
      setState(() {
        version = res.version;
      });
      print(res);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //theme
            ListTileWithDesc(
              leading: Icon(Icons.dark_mode_outlined),
              title: 'Dark Theme',
              trailing: ValueListenableBuilder(
                valueListenable: isDarkThemeNotifier,
                builder: (context, isDark, child) => Checkbox(
                  value: isDark,
                  onChanged: (value) {
                    isDarkThemeNotifier.value = value!;
                    //set config
                    appConfigNotifier.value.isDarkTheme = value;
                    setConfigFile(appConfigNotifier.value);
                  },
                ),
              ),
            ),
            //version
            ListTileWithDesc(
              leading: Icon(Icons.settings),
              title: 'Setting',
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),

            //version
            ListTileWithDesc(
              leading: Icon(Icons.cloud_upload_rounded),
              title: 'Check Version',
              desc: 'Current Version - $version',
            ),
          ],
        ),
      ),
    );
  }
}
