part of 'login_bloc.dart';

/// Represents the state of Login in the application.
// ignore_for_file: must_be_immutable
class LoginState extends Equatable {
  LoginState(
      {this.emailController, this.passwordController, this.loginModelObj});

  TextEditingController? emailController;

  TextEditingController? passwordController;

  LoginModel? loginModelObj;

  @override
  List<Object?> get props =>
      [emailController, passwordController, loginModelObj];
  LoginState copywith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    LoginModel? loginModelobj,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      loginModelObj: loginModelobj ?? this.loginModelObj,
    );
  }
}
