import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/release_version_system/release_version_action_button.dart';

import '../constants.dart';
import '../widgets/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          ReleaseVersionActionButton(),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
