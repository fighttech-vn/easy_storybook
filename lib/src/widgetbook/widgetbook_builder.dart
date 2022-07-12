import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

class HotreloadWidgetbook extends StatefulWidget {
  static const routeName = '/story-book';

  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  State<HotreloadWidgetbook> createState() => _HotreloadWidgetbookState();
}

class _HotreloadWidgetbookState extends State<HotreloadWidgetbook> {
  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      categories: [
        WidgetbookCategory(
          name: 'widgets',
          widgets: [
            WidgetbookComponent(
              name: 'Button',
              useCases: [
                WidgetbookUseCase(
                  name: 'elevated',
                  builder: (context) => ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      context.knobs
                          .number(
                            label: 'hello',
                          )
                          .toString(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(name: 'Light', data: ThemeData.light()),
        WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
      ],
      appInfo: AppInfo(name: 'Example'),
    );
  }
}
