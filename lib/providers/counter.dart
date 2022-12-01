import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void inc() => _value++;

  void dec() => _value--;

  int get value => _value;

  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  CounterProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final CounterState state = CounterState();

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    throw oldWidget.state.diff(state);
  }

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }
}
