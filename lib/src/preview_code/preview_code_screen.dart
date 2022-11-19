import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../networking/logger_interceptor.dart';

// key const
const keyPreviewCode = 'keyPreviewCode';

class VerifyPreviewCode {
  final String apiEndpoint;
  final String apiKey;
  final String projectId;
  final String version;

  VerifyPreviewCode({
    required this.apiEndpoint,
    required this.apiKey,
    required this.projectId,
    required this.version,
  });
}

class PreviewCodeScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  final StatefulWidget storyBookScreen;
  final VerifyPreviewCode verifyPreviewCode;

  const PreviewCodeScreen({
    Key? key,
    required this.sharedPreferences,
    required this.storyBookScreen,
    required this.verifyPreviewCode,
  }) : super(key: key);

  @override
  State<PreviewCodeScreen> createState() => _PreviewCodeScreenState();
}

class _PreviewCodeScreenState extends State<PreviewCodeScreen> {
  final codePreviewCtr = TextEditingController();

  void _handleCode(bool isSuccess) {
    if (isSuccess) {
      widget.sharedPreferences.setBool(keyPreviewCode, true).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.storyBookScreen),
          (_) => false,
        ).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              content: Text('Welcome to Storybook!'),
            ),
          );
        });
      });
    } else {
      widget.sharedPreferences.clear().then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Please check preview code!'),
          ),
        );
      });
    }
  }

  void _onTapSubmit() {
    final payload = {
      r'api_key': widget.verifyPreviewCode.apiKey,
      r'id': widget.verifyPreviewCode.projectId,
      r'version': widget.verifyPreviewCode.version,
      r'code': codePreviewCtr.text,
    };

    final dio = Dio(BaseOptions(baseUrl: widget.verifyPreviewCode.apiEndpoint));
    if (kDebugMode) {
      dio.interceptors.add(LoggerInterceptor());
    }

    dio.post('/', data: FormData.fromMap(payload)).then((value) {
      _handleCode(value.data['isSuccess']);
    }).catchError((e) {
      _handleCode(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Preview Code',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: codePreviewCtr,
                      decoration: const InputDecoration(
                        hintText: 'Enter Code Preview',
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        _onTapSubmit();
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 24),
                child: ElevatedButton(
                  onPressed: _onTapSubmit,
                  child: const Text('Submit'),
                ),
              ),
              RichText(
                key: const Key('FinePrint'),
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Powered by',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                  ),
                  TextSpan(
                    text: ' Fighttech.vn',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
