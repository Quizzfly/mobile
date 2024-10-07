import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/profile_setting_model.dart';
part 'profile_setting_event.dart';
part 'profile_setting_state.dart';

/// A bloc that manages the state of a ProfileSetting according to the event that is dispatched to it.
class ProfileSettingBloc extends Bloc<ProfileSettingEvent, ProfileSettingState> {
  ProfileSettingBloc(ProfileSettingState initialstate) : super(initialstate) {
    on<ProfileSettingInitialEvent>(_onInitialize);
  }
  _onInitialize(
    ProfileSettingInitialEvent event,
    Emitter<ProfileSettingState> emit,
  ) async {}
}
