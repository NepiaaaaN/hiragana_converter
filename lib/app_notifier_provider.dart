import 'dart:convert';

import 'package:hiragana_converter/app_state.dart';
import 'package:hiragana_converter/data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'app_notifier_provider.g.dart';

@riverpod
class AppNotifier extends _$AppNotifier {
  @override
  AppState build() {
    // 初期状態を提供する build メソッドでは、Input オブジェクトを返す
    // アプリ起動時は入力状態であるため
    return const Input();
  }

  void reset() {
    // 変換結果を表示したあと、再度入力状態に戻す時に呼び出すため、
    // Input オブジェクトを state に代入している
    state = const Input();
  }

  /// [InputForm] Widget の "変換" ボタンをタプした問に呼び出される処理を実装
  Future<void> convert(String sentence) async {
    // アプリの状態を Web API のレスポンス待ちに変更
    state = const Loading();

    // HTTPリクエストのURLやリクエストヘッダを生成する
    final url = Uri.parse('https://labs.goo.ne.jp/api/hiragana');
    final headers = {'Content-Type': 'application/json'};

    // 定義したリクエストオブジェクトを生成
    final request = Request(
      // 環境変数に登録した appId を参照(define/env.json)
      appId: const String.fromEnvironment('appId'),
      sentence: sentence,
    );

    // http パッケージのpostメソッドを呼び出してWeb APIを呼び出す
    // 非同期処理の完了を待ちたいので await を付与
    final response = await http.post(
      url,
      headers: headers,
      // toJson メソッドで Map に変換し、そこから jsonEncode 関数で JSON 文字列に変換
      body: jsonEncode(request.toJson()),
    );

    final result = Response.fromJson(
      jsonDecode(response.body) as Map<String, Object?>,
    );

    // アプリの状態を Web API のレスポンスを受け取った状態に変更するため
    // state に Data オブジェクトを代入
    state = Data(result.converted);
  }
}
