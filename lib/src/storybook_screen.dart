import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'storybook_delegate.dart';

class StoryBookScreen extends StatefulWidget {
  static const routeName = '/story-book';

  final StorybookDelegate storybookDelegate;

  const StoryBookScreen({
    Key? key,
    required this.storybookDelegate,
  }) : super(key: key);

  @override
  StoryBookScreenState createState() => StoryBookScreenState();
}

class StoryBookScreenState extends State<StoryBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildStorybook(widget.storybookDelegate),
    );
  }

  Widget buildStorybook(StorybookDelegate storybookDelegate) {
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
      initialStory: storybookDelegate.intStory,
      stories: [
        ...storybookDelegate.getMaterialStory(),
        ...storybookDelegate.getWidgetsStory(),
        ...storybookDelegate.getScreenStory(),
      ],
    );
  }
}
