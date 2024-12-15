import 'package:flutter/material.dart';
import 'package:hiragana_converter/app_state.dart';
import 'package:hiragana_converter/app_notifier_provider.dart';
import 'package:hiragana_converter/convert_result.dart';
import 'package:hiragana_converter/input_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiragana_converter/loading_indicator.dart';

void main() {
  runApp(
    // アプリのルートウィジェットを ProviderScope でラップ
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hiragana Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// build メソッドの第二引数で WidgetRef を受け取るため、ConsumerWidget に変更
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hiragana Converter'),
      ),

      /// [app_notifier_provider.dart] の状態が変化したら自動で画面が切り替わる
      body: switch (appState) {
        Loading() => const LoadingIndicator(),
        Input() => const InputForm(),
        Data(sentence: final sentence) => ConvertResult(sentence: sentence),
      },
    );
  }
}
