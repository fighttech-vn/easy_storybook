import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/src/navigation/organizer_provider.dart';
import 'package:widgetbook/src/navigation/organizer_state.dart';
import 'package:widgetbook/src/repositories/story_repository.dart';
import 'package:widgetbook/src/widgets/search_bar.dart' as widgetbook;

import '../../helper/widget_test_helper.dart';

Finder _findTextField() {
  final textFieldFinder = find.byKey(
    Key(
      '${widgetbook.SearchBar}.$TextField',
    ),
  );
  expect(textFieldFinder, findsOneWidget);
  return textFieldFinder;
}

Finder _findCancelButton() {
  final cancelSearchButton = find.byKey(
    Key('${widgetbook.SearchBar}.CancelSearchButton'),
  );

  expect(cancelSearchButton, findsOneWidget);
  return cancelSearchButton;
}

void _expectNoCancelButton() {
  final cancelSearchButton = find.byKey(
    Key('${widgetbook.SearchBar}.CancelSearchButton'),
  );

  expect(cancelSearchButton, findsNothing);
}

void _expectEmptyTextField(String previousValue) {
  final textFinder = find.text(previousValue);
  expect(textFinder, findsNothing);
}

void main() {
  group(
    '${widgetbook.SearchBar}',
    () {
      testWidgets(
        'behaves correctly',
        (WidgetTester tester) async {
          final organizerProvider = OrganizerProvider(
            state: OrganizerState.unfiltered(
              categories: [],
            ),
            storyRepository: StoryRepository(),
          );
          await tester.pumpWidgetWithMaterialApp(
            ChangeNotifierProvider.value(
              value: organizerProvider,
              child: const widgetbook.SearchBar(),
            ),
          );

          _expectNoCancelButton();

          const searchTerm = 'Test';
          final textFieldFinder = _findTextField();

          await tester.enterText(
            textFieldFinder,
            searchTerm,
          );
          await tester.pump();

          final cancelSearchButton = _findCancelButton();

          await tester.tap(cancelSearchButton);
          await tester.pump();

          _expectNoCancelButton();
          _expectEmptyTextField(searchTerm);
        },
      );
    },
  );
}
