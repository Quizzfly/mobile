part of 'register_bloc.dart';

/// Represents the state of Login in the application.
// ignore_for_file: must_be_immutable
class RegisterState extends Equatable {
  RegisterState(
      {this.nameController,this.emailController, this.passwordController, this.registerModelObj});

  TextEditingController? nameController;
  
  TextEditingController? emailController;

  TextEditingController? passwordController;

  RegisterModel? registerModelObj;

  @override
  List<Object?> get props =>
      [emailController, passwordController, registerModelObj];
  RegisterState copyWith({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    RegisterModel? registerModelObj,
  }) {
    return RegisterState(
      nameController : nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      registerModelObj: registerModelObj ?? this.registerModelObj,
    );
  }
}
