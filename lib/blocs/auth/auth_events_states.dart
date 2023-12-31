part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin({required this.email, required this.password});
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister({required this.email, required this.password});
}

class AuthEventVerifyOtp extends AuthEvent {
  final String email;
  final String otp;

  AuthEventVerifyOtp({required this.email, required this.otp});
}

class AuthEventSendOtp extends AuthEvent {
  final String email;

  AuthEventSendOtp({required this.email});
}

class AuthEventVerifyEmail extends AuthEvent {
  final String email;

  AuthEventVerifyEmail({required this.email});
}

class AuthEventCompleteProfile extends AuthEvent {
  final RegisterUserModel user;

  AuthEventCompleteProfile({required this.user});
}

class AuthEventSendVerificationForPasswordReset extends AuthEvent {
  final String email;

  AuthEventSendVerificationForPasswordReset({required this.email});
}

class AuthEventImagePicker extends AuthEvent {}

class AuthEventChangePasswordAfterOtpVerification extends AuthEvent {
  final String userId;
  final String password;

  AuthEventChangePasswordAfterOtpVerification(
      {required this.userId, required this.password});
}

// States
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthRegistrationSuccessState extends AuthState {
  final ApiResponse response;
  AuthRegistrationSuccessState({required this.response});
}

class AuthSendVerificationState extends AuthState {
  final AuthModel response;
  AuthSendVerificationState({required this.response});
}

class AuthVerificationState extends AuthState {
  final AuthModel response;
  AuthVerificationState({required this.response});
}

class AuthLoginState extends AuthState {
  final ApiResponse response;
  AuthLoginState({required this.response});
}

class AuthCompleteProfileState extends AuthState {
  final ApiResponse<dynamic> response;
  AuthCompleteProfileState({required this.response});
}

class AuthSendVerificationForPasswordResetState extends AuthState {
  final AuthModel response;
  AuthSendVerificationForPasswordResetState({required this.response});
}

class AuthVerifyOtpState extends AuthState {
  final ApiResponse<dynamic> response;
  AuthVerifyOtpState({required this.response});
}

class AuthSentOtpState extends AuthState {
  final ApiResponse response;
  AuthSentOtpState({required this.response});
}

class AuthChangePasswordAfterOtpVerificationState extends AuthState {
  final AuthModel response;
  AuthChangePasswordAfterOtpVerificationState({required this.response});
}

class AuthImagePickerState extends AuthState {
  final File? image;
  AuthImagePickerState({required this.image});
}

class AuthStateFailure extends AuthState {
  final String message;

  AuthStateFailure({required this.message});
}
