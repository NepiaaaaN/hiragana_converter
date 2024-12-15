// アプリの状態を表現する sealed class
sealed class AppState {
  const AppState();
}

// 入力状態
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
