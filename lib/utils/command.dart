import 'package:flutter/widgets.dart';

class Command extends ChangeNotifier {
  Command(this._action, [this._onEnded]);

  final Future<void> Function() _action;
  final Future<void> Function()? _onEnded;
  bool running = false;
  bool completed = false;
  Exception? error;

  Future<void> execute() async {
    if (running) {
      return;
    }

    running = true;
    notifyListeners();

    try {
      await _action();
    } on Exception catch (e) {
      error = e;
    } finally {
      running = false;
      completed = true;
      notifyListeners();
      await _onEnded?.call();
    }
  }

  void clear() {
    running = false;
    completed = false;
    error = null;
  }
}
