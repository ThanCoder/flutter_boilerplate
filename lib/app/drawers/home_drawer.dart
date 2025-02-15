import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../constants.dart';
import '../screens/app_setting_screen.dart';
import '../widgets/index.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    init();
    super.initState();
  }

  String appVersion = '';

  void init() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      setState(() {
        appVersion = packageInfo.version;
      });
    } catch (e) {
      debugPrint('HomeDrawer:init ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 10),
          const Center(child: Text(appTitle)),
          DrawerHeader(
            child: MyImageFile(path: ''),
          ),
          //settting
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ),
              );
            },
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
          ),

          const SizedBox(height: 30),
          //bottom
          ListTile(
            leading: const Icon(Icons.info),
            title: Text('Version: $appVersion ($appVersionName)'),
          ),
        ],
      ),
    );
  }
}
