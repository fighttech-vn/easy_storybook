import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClearScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const ClearScreen({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);

  @override
  State<ClearScreen> createState() => _ClearScreenState();
}

class _ClearScreenState extends State<ClearScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: widget.sharedPreferences.clear(),
        builder: (context, ___) {
          return Column(
            children: [
              const Text('success'),
              OutlinedButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('OK'),
              )
            ],
          );
        },
      ),
    );
  }
}
