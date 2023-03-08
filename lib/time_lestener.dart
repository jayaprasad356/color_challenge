import 'dart:async';

import 'package:flutter/cupertino.dart';
final timerBloc = TimerBloc();

class TimerBloc {
  late Timer _timer;

  int _start = 60;

  StreamController<int> timerStreamController = StreamController<int>.broadcast();
  final ValueNotifier<int> _timerValueNotifier=ValueNotifier<int>(60);

  Stream get timerStreams {
    if(!timerStreamController.hasListener){
      startTimer();
    }
    return timerStreamController.stream;
  }
  int get timerStream {
    if(!_timerValueNotifier.hasListeners){
      startTimer();
    }
    return _timerValueNotifier.value;
  }

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer =  Timer.periodic(oneSec, (Timer timer) {
      if (_start < 1) {
        _start = 60;
      } else {
        _start = _start - 1;
      }
      timerStreamController.sink.add(_start);
    });
  }

  stopTimer() {
    _timer?.cancel();
  }

  dispose() {
    timerStreamController.close();
  }
}