import 'dart:io';

import 'package:flutter/material.dart';

import '../dialogs/index.dart';
import '../models/index.dart';
import '../notifiers/app_notifier.dart';
import '../services/index.dart';
import '../widgets/index.dart';

class SettingScreen extends StatefulWidget {
  void Function()? onSaved;
  SettingScreen({super.key, this.onSaved});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  bool isChanged = false;
  late AppConfigModel configFile;

  void init() async {
    configFile = appConfigNotifier.value;
  }

  void _saveConfig() async {
    try {
      if (Platform.isAndroid) {
        if (!await checkStoragePermission()) {
          if (mounted) {
            showConfirmStoragePermissionDialog(context);
          }
          return;
        }
      }
      //save
      setConfigFile(configFile);
      await initAppConfigService();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Config ကိုသိမ်းဆည်းပြီးပါပြီ')));
      setState(() {
        isChanged = false;
      });
    } catch (e) {
      debugPrint('saveConfig: ${e.toString()}');
    }
  }

  Future<bool> _onBackpress() async {
    return await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        contentText: 'setting ကိုသိမ်းဆည်းထားချင်ပါသလား?',
        cancelText: 'မသိမ်းဘူး',
        submitText: 'သိမ်းမယ်',
        onCancel: () {},
        onSubmit: () {
          _saveConfig();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isChanged) {
          return await _onBackpress();
        }
        return true;
      },
      child: MyScaffold(
        appBar: AppBar(title: const Text('Setting')),
        body: ListView(
          children: [
            //theme mode
            ListTileWithDesc(
              title: 'Dark Mode',
              widget: Checkbox(
                value: configFile.isDarkTheme,
                onChanged: (value) {
                  setState(() {
                    configFile.isDarkTheme = value!;
                    _saveConfig();
                  });
                  isDarkThemeNotifier.value = value!;
                },
              ),
            ),

            //
          ],
        ),
        floatingActionButton: isChanged
            ? FloatingActionButton(
                onPressed: () {
                  _saveConfig();
                },
                child: const Icon(Icons.save),
              )
            : null,
      ),
    );
  }
}
