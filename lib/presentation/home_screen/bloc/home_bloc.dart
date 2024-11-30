import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/grid_label_item_model.dart';
import '../models/home_initial_model.dart';
import '../models/home_model.dart';
import '../models/recent_activities_grid_item_model.dart';
part 'home_event.dart';
part 'home_state.dart';

/// A bloc that manages the state of a Home according to the event that is dispatched to it.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<HomeInitialEvent>(_onInitialize);
  }
  _onInitialize(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        homeInitialModelObj: state.homeInitialModelObj?.copyWith(
          gridLabelItemList: fillGridLabelItemList(),
          recentActivitiesGridItemList: fillRecentActivitiesGridItemList(),
        ),
      ),
    );
  }

  List<GridLabelItemModel> fillGridLabelItemList() {
    return [
      GridLabelItemModel(image: ImageConstant.imgCreate, label: "Your group"),
      GridLabelItemModel(image: ImageConstant.imgCreate, label: "Your group"),
      GridLabelItemModel(image: ImageConstant.imgGroup, label: "Your group"),
      GridLabelItemModel()
    ];
  }

  List<RecentActivitiesGridItemModel> fillRecentActivitiesGridItemList() {
    return [
      RecentActivitiesGridItemModel(
          title: "Untitled",
          date: "16/11/2024",
          imagePath: ImageConstant.imageEducation),
      RecentActivitiesGridItemModel(
          title: "Hello everyone to co..",
          date: "16/11/2024",
          imagePath: ImageConstant.imageBackToSchool),
      RecentActivitiesGridItemModel(
          title: "Hello everyone to co..",
          date: "16/11/2024",
          imagePath: ImageConstant.imgBackground1),
      RecentActivitiesGridItemModel(
        title: "Untitled",
        date: "16/11/2024",
      )
    ];
  }
}
