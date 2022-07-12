import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class StorybookDelegate {
  final DependencyStorybook dependency;

  StorybookDelegate(this.dependency);

  DependencyStorybook get getDependency;

  String get intStory;

  ThemeData? get light;
  ThemeData? get dark;

  Iterable<LocalizationsDelegate<dynamic>>? get localizationsDelegates;
}

abstract class DependencyStorybook {
  final Dio dio;

  DependencyStorybook(this.dio);
}
