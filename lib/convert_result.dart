import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiragana_converter/app_notifier_provider.dart';

class ConvertResult extends ConsumerWidget {
  const ConvertResult({
    super.key,
    // 変換結果の文字列をコンストラクタ引数で受け取る
    required this.sentence,
  });

  final String sentence;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(appNotifierProvider.notifier);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(sentence),
          ),
          const SizedBox(height: 20),
          // テキスト入力画面に戻る処理
          ElevatedButton(
            onPressed: notifier.reset,
            child: const Text('再入力'),
          ),
        ],
      ),
    );
  }
}
