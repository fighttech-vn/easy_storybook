import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../storybook_delegate.dart';

abstract class StorybookFLutter {
  List<Story> getMaterialStory();
  List<Story> getWidgetsStory();
  List<Story> getScreenStory();
}

class FlutterStorybookScreen extends StatefulWidget {
  static const routeName = '/story-book';

  final StorybookFLutter storybookFLutter;
  final StorybookDelegate storybookDelegate;

  const FlutterStorybookScreen({
    Key? key,
    required this.storybookFLutter,
    required this.storybookDelegate,
  }) : super(key: key);

  @override
  State<FlutterStorybookScreen> createState() => _FlutterStorybookScreenState();
}

class _FlutterStorybookScreenState extends State<FlutterStorybookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildStorybook(widget.storybookFLutter),
    );
  }

  Widget buildStorybook(StorybookFLutter storybookDelegate) {
    return Storybook(
      plugins: initializePlugins(
        initialDeviceFrameData: DeviceFrameData(
          device: Devices.ios.iPhone13,
        ),
        contentsSidePanel: true,
        knobsSidePanel: true,
      ),
      wrapperBuilder: (ct, wid) {
        return MaterialApp(
          theme: widget.storybookDelegate.light,
          darkTheme: widget.storybookDelegate.dark,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          home: Scaffold(body: Center(child: wid)),
          localizationsDelegates:
              widget.storybookDelegate.localizationsDelegates,
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('es', ''), // Spanish, no country code
          ],
          locale: const Locale('en', ''),
        );
      },
      initialStory: widget.storybookDelegate.intStory,
      stories: [
        ...storybookDelegate.getMaterialStory(),
        ...storybookDelegate.getWidgetsStory(),
        ...storybookDelegate.getScreenStory(),
      ],
    );
  }
}
