import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/launch_url_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Task'),
      ),
      body: body(ref),
    );
  }

  Widget body(WidgetRef ref) {
    ref.listen(
      launchStreamProvider,
      (previous, AsyncValue? next) {
        next?.when(
            data: (data) {
              if (data is AsyncData) {
                print('ok');
              } else if (data is AsyncError) {
                print(data.error.toString());
                print(data.stackTrace.toString());
              }
            },
            error: (error, stackTrace) {
              print(error.toString());
              print(stackTrace.toString());
            },
            loading: () {});
      },
    );
    return const SizedBox();
  }
}
