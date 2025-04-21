import 'package:flutter/material.dart';
import '../general_server/index.dart';

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
          GeneralServerNotiButton(),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
