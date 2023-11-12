import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_cubit_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  int i = 30;
  late Timer timer;

  OtpTimerCubit() : super(const OtpTimerInitial());

  startOtpIntervals() async {
    emit(const OtpTimerInitial());
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(OtpTimerRunning(secondsValue: i));
      i--;
      if (i == 0) {
        timer.cancel();
        i = 10;
        emit(const OtpTimerStoppedShowButton());
      }
    });
  }

  pauseTimer() {
    timer.cancel();
    emit(const OtpTimerInitial());
  }

  stopTimer() {
    timer.cancel();
    i = 10;

    emit(const OtpTimerStoppedShowButton());
  }
}
