import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/launch_url_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // uses ProviderScope to provide a scope of created providers
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

// uses ConsumerWidget for faster access for the WidgetRef
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
    // since riverpod v2 ProviderListener is deprecated and should use WidgetRef.listen instead
    ref.listen(
      launchStreamProvider,
      (previous, AsyncValue? next) {
        next?.when(
            data: (data) {
              // checks for the AsyncValue instance type if AsyncData then either an empty data or a success url
              // if AsyncError then prints the error with stackTrace
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
