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

  Map<String, Object?> toJson() => _$RequestToJson(this);
}

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
