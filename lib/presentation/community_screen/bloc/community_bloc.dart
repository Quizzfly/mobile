import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/community_model.dart';
import '../models/community_activity_tab_model.dart';
import '../models/community_list_item_model.dart';
part 'community_event.dart';
part 'community_state.dart';

/// A bloc that manages the state of a Community according to the event that is dispatched to it.
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  CommunityBloc(super.initialState) {
    on<CommunityInitialEvent>(_onInitialize);
  }
  _onInitialize(
    CommunityInitialEvent event,
    Emitter<CommunityState> emit,
  ) async {
    emit(
      state.copyWith(
        commentInputFieldController: TextEditingController(),
        postInputFieldController: TextEditingController(),
      ),
    );
    emit(state.copyWith(
      communityActivityTabModelObj:
          state.communityActivityTabModelObj?.copyWith(
        communityListItemList: fillCommunityListItemList(),
      ),
    ));
  }

  List<CommunityListItemModel> fillCommunityListItemList() {
    return [
      CommunityListItemModel(
          name: "Aarav Sharma",
          host: "Host",
          description: "The whole secret of existence lies in the pursuit of meaning, purpose, and connection. It is a delicate dance between self-discovery, compassion for others, and embracing the ever-unfolding mysteries of life. Finding harmony in the ebb and flow of experiences, we unlock the profound beauty that resides within our shared journey.",
          image: ImageConstant.imageBackToSchool,
          likeCount: 16,
          commentCount: 24,
          share: "Share",
          userOne: ImageConstant.imageAvatar),
      CommunityListItemModel(
          name: "Anh Dung",
          host: "Host",
          description: "The whole secret of existence lies in the pursuit of meaning, purpose, and connection. It is a delicate dance between self-discovery, compassion for others, and embracing the ever-unfolding mysteries of life. Finding harmony in the ebb and flow of experiences, we unlock the profound beauty that resides within our shared journey.",
          image: ImageConstant.imageBackToSchool,
          likeCount: 16,
          commentCount: 24,
          share: "Share",
          userOne: ImageConstant.imageAvatar),
      CommunityListItemModel(
          name: "Anh Dung Ne",
          host: "Host",
          description: "The whole secret of existence lies in the pursuit of meaning, purpose, and connection. It is a delicate dance between self-discovery, compassion for others, and embracing the ever-unfolding mysteries of life. Finding harmony in the ebb and flow of experiences, we unlock the profound beauty that resides within our shared journey.",
          image: ImageConstant.imageBackToSchool,
          likeCount: 16,
          commentCount: 24,
          share: "Share",
          userOne: ImageConstant.imageAvatar)
    ];
  }
}
