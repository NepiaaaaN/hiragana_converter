import 'package:flutter/material.dart';
// jsonEncode関数参照のため
import 'dart:convert';
import 'package:hiragana_converter/data.dart';
// "http"という別名を付ける
import 'package:http/http.dart' as http;

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
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
              // HTTPリクエストのURLやリクエストヘッダを生成する
              final url = Uri.parse('https://labs.goo.ne.jp/api/hiragana');
              final headers = {'Content-Type': 'application/json'};

              // 定義したリクエストオブジェクトを生成
              final request = Request(
                // 環境変数に登録した appId を参照(define/env.json)
                appId: const String.fromEnvironment('appId'),
                sentence: _textEditingController.text,
              );

              // http パッケージのpostメソッドを呼び出してWeb APIを呼び出す
              // 非同期処理の完了を待ちたいので await を付与
              final result = await http.post(
                url,
                headers: headers,
                // toJson メソッドで Map に変換し、そこから jsonEncode 関数で JSON 文字列に変換
                body: jsonEncode(request.toJson()),
              );

              final response = Response.fromJson(
                jsonDecode(result.body) as Map<String, Object?>,
              );
              debugPrint('変換結果 : ${response.converted}');
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
