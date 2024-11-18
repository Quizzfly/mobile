import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/leader_board_model.dart';
import '../models/users_rank_list_item_model.dart';

part 'leader_board_event.dart';
part 'leader_board_state.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  LeaderBoardBloc(super.initialState) {
    on<LeaderBoardInitialEvent>(_onInitialize);
  }
  _onInitialize(
    LeaderBoardInitialEvent event,
    Emitter<LeaderBoardState> emit,
  ) async {
    emit(
      state.copyWith(
        leaderBoardModelObj: state.leaderBoardModelObj?.copyWith(
          usersRankListItem: fillUsersRankListItemList(),
        ),
      ),
    );
  }

  List<UsersRankListItemModel> fillUsersRankListItemList() {
    return [
      UsersRankListItemModel(
          no: 1,
          imageAvatar: ImageConstant.imageAvatar,
          id: "341234",
          nickName: "Anh Dung",
          score: 200),
      UsersRankListItemModel(
          no: 2,
          imageAvatar: ImageConstant.imageAvatar,
          id: "341234",
          nickName: "Anh Dung",
          score: 200),
      UsersRankListItemModel(
          no: 3,
          imageAvatar: ImageConstant.imageAvatar,
          id: "341234",
          nickName: "Anh Dung",
          score: 200),
      UsersRankListItemModel(
          no: 4,
          imageAvatar: ImageConstant.imageAvatar,
          id: "341234",
          nickName: "Anh Dung",
          score: 200),
      UsersRankListItemModel(
          no: 5,
          imageAvatar: ImageConstant.imageAvatar,
          id: "341234",
          nickName: "Anh Dung",
          score: 200),
    ];
  }
}
