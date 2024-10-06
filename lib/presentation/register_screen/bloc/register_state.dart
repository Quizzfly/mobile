part of 'register_bloc.dart';

/// Represents the state of Login in the application.
// ignore_for_file: must_be_immutable
class RegisterState extends Equatable {
  RegisterState(
      {this.nameController,
      this.emailController,
      this.passwordController,
      this.confirmPasswordController,
      this.registerModelObj});

  TextEditingController? nameController;

  TextEditingController? emailController;

  TextEditingController? passwordController;

  TextEditingController? confirmPasswordController;

  RegisterModel? registerModelObj;

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        confirmPasswordController,
        registerModelObj
      ];
  RegisterState copyWith({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    RegisterModel? registerModelObj,
  }) {
    return RegisterState(
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      confirmPasswordController:
          confirmPasswordController ?? this.confirmPasswordController,
      registerModelObj: registerModelObj ?? this.registerModelObj,
    );
  }
}
