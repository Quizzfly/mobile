import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../../../data/repository/repository.dart';
import '../models/grid_label_item_model.dart';
import '../models/home_initial_model.dart';
import '../models/home_model.dart';
import '../models/recent_activities_grid_item_model.dart';
part 'home_event.dart';
part 'home_state.dart';

/// A bloc that manages the state of a Home according to the event that is dispatched to it.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _repository = Repository();
  var getRecentActivitiesResp = GetLibraryQuizzflyResp();
  HomeBloc(super.initialState) {
    on<HomeInitialEvent>(_onInitialize);
    on<CreateGetRecentActivitiesEvent>(_callGetRecentActivities);
  }
  _onInitialize(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    add(CreateGetRecentActivitiesEvent(
      onGetRecentActivitiesSuccess: () {},
    ));
    emit(
      state.copyWith(
        homeInitialModelObj: state.homeInitialModelObj?.copyWith(
          gridLabelItemList: fillGridLabelItemList(),
          recentActivitiesGridItemList: [],
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

  FutureOr<void> _callGetRecentActivities(
    CreateGetRecentActivitiesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.getLibraryQuizzfly(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getRecentActivitiesResp = value;
        _onGetRecentActivitiesSuccess(value, emit);
        event.onGetRecentActivitiesSuccess?.call();
      }).onError((error, stackTrace) {
        _onGetRecentActivitiesError();
        event.onGetRecentActivitiesError?.call();
      });
    } catch (e) {
      print('Error loading recent activities: $e');
      _onGetRecentActivitiesError();
      event.onGetRecentActivitiesError?.call();
    }
  }

  void _onGetRecentActivitiesSuccess(
    GetLibraryQuizzflyResp resp,
    Emitter<HomeState> emit,
  ) {
    final recentActivitiesItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.createdAt ?? "");
          return RecentActivitiesGridItemModel(
            title: item.title ?? "Untitled",
            date: formattedDate,
            imagePath: item.coverImage ?? ImageConstant.imgNotFound,
            id: item.id ?? "",
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      homeInitialModelObj: state.homeInitialModelObj?.copyWith(
        recentActivitiesGridItemList: recentActivitiesItems,
      ),
    ));
  }

  void _onGetRecentActivitiesError() {
    // Handle error state here
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return "Today";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
      } else {
        final months = (difference.inDays / 30).floor();
        return "$months ${months == 1 ? 'month' : 'months'} ago";
      }
    } catch (e) {
      return dateStr;
    }
  }
}
