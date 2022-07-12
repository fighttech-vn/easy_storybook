Easy storybook 

## Easy setup

```
  const apiEndpoint = 'https://tech.fighttech.vn';
  const apiKey = 'prjectdname@api@r0';
  const projectId = 'prjectdname';
  const version = '1';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Local database
    final sharedPreferences = await SharedPreferences.getInstance();

    // Remote datasource
    final mockApiResponse = await AppMockApi.shared.loadApiResponseJson();
    final dio = Dio(BaseOptions(baseUrl: MockAdapter.mockBase))
      ..httpClientAdapter = MockAdapter(mockApiResponse);

    injector.registerSingleton<Dio>(dio);
    injector.registerSingleton<SharedPreferences>(sharedPreferences);

    runApp(
      MaterialAppStorybook(
      sharedPreferences: sharedPreferences,
      storybookScreen: const HotreloadWidgetbook(),
      verifyPreviewCode: VerifyPreviewCode(
        apiEndpoint: apiEndpoint,
        apiKey: apiKey,
        projectId: projectId,
        version: version,
      ),
    )
    );
  }

```