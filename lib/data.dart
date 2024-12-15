import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

// アノテーションを付与することで、json_serializable パッケージがJSONの
// シリアライズ、デシリアライズのコードを生成する
// fieldRenameプロパティにFieldRename.snake を指定することで、
// JSONをシリアライズ、デシリアライズする際に、フィールド名をスネークケースに変換するよう指定している
@JsonSerializable(fieldRename: FieldRename.snake)
class Request {
  const Request({
    required this.appId,
    required this.sentence,
    this.outputType = 'hiragana',
  });

  final String appId;
  final String sentence;
  final String outputType;

  /// toJson
  /// 役割 : Dart オブジェクトをJSONに変換する
  /// このクラス(Request) のインスタンスを JSON 形式のデータに変換する
  ///
  /// ```dart
  /// final request = Request(appId: "1234", sentence: "Hello, world!");
  /// final json = request.toJson();
  /// print(json);
  /// // 出力: { "app_id": "1234", "sentence": "Hello, world!", "output_type": "hiragana" }
  /// ```
  Map<String, Object?> toJson() => _$RequestToJson(this);
}

/// fromJson
/// 役割 : JSON データを使って Dart のオブジェクトを生成する
/// _$ResponseFromJson(json) という自動生成された関数を使用して、具体的な変換処理を行う
///
/// ```dart
/// final json = {
///   "converted": "こんにちは"
/// };
/// final response = Response.fromJson(json);
/// print(response.converted);
/// // 出力: こんにちは
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class Response {
  const Response({
    required this.converted,
  });

  // 変換後のひらがな文字列が入る
  final String converted;

  // ResponseクラスのインスタンスをJSONから生成するためのfactoryコンストラクタ
  factory Response.fromJson(Map<String, Object?> json) =>
      _$ResponseFromJson(json);
}
