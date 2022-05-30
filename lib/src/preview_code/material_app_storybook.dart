import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clear_screen.dart';
import 'preview_code_screen.dart';

class MaterialAppStorybook extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final StatefulWidget storybookScreen;
  final VerifyPreviewCode verifyPreviewCode;

  const MaterialAppStorybook({
    Key? key,
    required this.sharedPreferences,
    required this.storybookScreen,
    required this.verifyPreviewCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGanted = sharedPreferences.getBool(keyPreviewCode) ?? false;

    return MaterialApp(
      home: isGanted
          ? storybookScreen
          : PreviewCodeScreen(
              sharedPreferences: sharedPreferences,
              storyBookScreen: storybookScreen,
              verifyPreviewCode: verifyPreviewCode,
            ),
      onGenerateRoute: (settings) {
        if (settings.name == '/clear') {
          return MaterialPageRoute(
            builder: (_) => ClearScreen(sharedPreferences: sharedPreferences),
          ); // Pass it to BarPage.
        }
        return null; // Let `onUnknownRoute` handle this behavior.
      },
    );
  }
}
