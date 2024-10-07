part of 'profile_setting_bloc.dart';

/// Represents the state of Profile Setting in the application.
// ignore_for_file: must_be_immutable
class ProfileSettingState extends Equatable {
  ProfileSettingState({this.profileSettingModelObj});
  ProfileSettingModel? profileSettingModelObj;
  @override
  List<Object?> get props => [profileSettingModelObj];
  ProfileSettingState copyWith({ProfileSettingModel? profileSettingModelObj}) {
    return ProfileSettingState(
      profileSettingModelObj:
          profileSettingModelObj ?? this.profileSettingModelObj,
    );
  }
}
