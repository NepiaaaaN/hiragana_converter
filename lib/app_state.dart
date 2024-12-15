/// アプリの状態を表現する sealed class
/// この状態が変化すると [main.dart] で変更を変徴し、画面が切り替わる
sealed class AppState {
  const AppState();
}

// 入力状態
/*
  以下の理由により親クラスのコンストラクタを呼び出す
  1. Dartのルールに従い、親クラスとサブクラスの一貫性を保つ
  2. 将来の拡張性(AppStateに処理を追加する可能性) を考慮
  3. const を活用し、イミュータブルオブジェクトとしての特性を保持
  4. sealed class として方の安全性を保証
*/
class Input extends AppState {
  const Input() : super();
}

// Web API のレスポンス待ちの状態
class Loading extends AppState {
  const Loading() : super();
}

// Web API のレスポンスを受け取った状態
class Data extends AppState {
  const Data(this.sentence);

  final String sentence;
}
