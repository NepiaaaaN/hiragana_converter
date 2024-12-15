import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiragana_converter/app_notifier_provider.dart';

class InputForm extends ConsumerStatefulWidget {
  const InputForm({super.key});

  @override
  ConsumerState<InputForm> createState() => _InputFormState();
}

class _InputFormState extends ConsumerState<InputForm> {
  final _formKey = GlobalKey<FormState>();
  // TextField Widget の入力文字や選択文字を取得、変更する機能を持つ
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _textEditingController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '文章を入力してください',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '文章が入力されていません';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // GlobalKey から Form ウィジェットの State を取得
              final formState = _formKey.currentState!;
              // validate メソッドを呼び出すと、Form ウィジェットの子孫にある FormField ウィジェットでバリデーションが行われる
              if (!formState.validate()) {
                return;
              }
              final sentence = _textEditingController.text;
              // ここで convert を呼び出すと、AppState が Data に切り替わり、変換結果画面が表示される
              await ref.read(appNotifierProvider.notifier).convert(sentence);
            },
            child: const Text(
              '変換',
            ),
          ),
        ],
      ),
    );
  }

  // StatefulWidget が破棄される時に呼び出し
  // TextEditingController クラスを破棄するために StatefulWidget を継承した
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
