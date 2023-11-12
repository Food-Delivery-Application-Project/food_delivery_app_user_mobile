part of 'timer_cubit_cubit.dart';

abstract class OtpTimerState {
  const OtpTimerState();
}

class OtpTimerInitial extends OtpTimerState {
  const OtpTimerInitial();
}

class OtpTimerRunning extends OtpTimerState {
  final int secondsValue;
  const OtpTimerRunning({required this.secondsValue});
}

class OtpTimerStoppedShowButton extends OtpTimerState {
  const OtpTimerStoppedShowButton();
}
