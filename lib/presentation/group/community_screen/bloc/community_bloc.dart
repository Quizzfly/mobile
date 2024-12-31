import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../data/models/invite_member/post_invite_member_req.dart';
import '../../../../data/models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../../../../data/models/new_post/post_new_post_req.dart';
import '../../../../data/models/upload_file/post_upload_multiple_file_resp.dart';
import '../../../../data/models/list_comment/post_react_post_resp.dart';
import '../../../../data/models/list_post/get_list_post_group_resp.dart';
import '../../../../core/app_export.dart';
import '../../../../data/repository/repository.dart';
import '../../../personalization/library_screen/models/library_list_item_model.dart';
import '../models/community_model.dart';
import '../models/community_activity_tab_model.dart';
import '../models/community_list_item_model.dart';

part 'community_event.dart';
part 'community_state.dart';

/// A bloc that manages the state of a Community according to the event that is dispatched to it.
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final Repository _repository = Repository();
  var getListPostGroupResp = GetListPostGroupResp();
  var postReactPostResp = PostReactPostResp();
  var getLibraryResp = GetLibraryQuizzflyResp();

  CommunityBloc(super.initialState) {
    on<CommunityInitialEvent>(_onInitialize);
    on<CreateGetCommunityPostsEvent>(_callGetCommunityPosts);
    on<ReactPostEvent>(_callReactPost);
    on<InviteMemberEvent>(_callInviteMember);
    on<ImagePickedEvent>(_onImagePicked);
    on<CreatePostNewPostEvent>(_callPostNewPost);
    on<SelectQuizzflyEvent>(_onSelectedQuizzfly);
    on<CreateGetLibraryEvent>(_callGetLibrary);
    on<DeletePostEvent>(_callDeletePostApi);
  }

  Future<void> _onInitialize(
    CommunityInitialEvent event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          commentInputFieldController: TextEditingController(),
          postInputFieldController: TextEditingController(),
        ),
      );
      add(
        CreateGetCommunityPostsEvent(
          groupId: state.id,
          onGetCommunityPostsSuccess: () {},
        ),
      );

      emit(
        state.copyWith(
          communityActivityTabModelObj: CommunityActivityTabModel(),
        ),
      );
    } catch (e) {
      debugPrint('Error initializing community data: $e');
    }
  }

  FutureOr<void> _callGetCommunityPosts(
    CreateGetCommunityPostsEvent event,
    Emitter<CommunityState> emit,
  ) async {
    if (event.groupId == null) return;

    emit(state.copyWith(isLoading: true));

    try {
      String? accessToken = PrefUtils().getAccessToken();
      await Future.delayed(const Duration(seconds: 1));

      final value = await _repository.getListPostGroup(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        id: event.groupId,
      );

      getListPostGroupResp = value;
      _onGetCommunityPostsSuccess(value, emit);
      event.onGetCommunityPostsSuccess?.call();
    } catch (e) {
      debugPrint('Error loading community posts: $e');
      _onGetCommunityPostsError(emit);
      event.onGetCommunityPostsError?.call();
    }
  }

  void _onGetCommunityPostsSuccess(
    GetListPostGroupResp resp,
    Emitter<CommunityState> emit,
  ) {
    final communityItems = resp.data?.map((postData) {
          return CommunityListItemModel.fromPostData(
            json: postData.toJson(),
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      isLoading: false,
      communityActivityTabModelObj:
          state.communityActivityTabModelObj?.copyWith(
        communityListItemList: communityItems,
      ),
    ));
  }

  void _onGetCommunityPostsError(Emitter<CommunityState> emit) {
    emit(state.copyWith(isLoading: false));
    debugPrint('Error fetching community posts');
  }

  FutureOr<void> _callReactPost(
    ReactPostEvent event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.reactPost(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        postId: event.postId,
      ).then((value) {
        postReactPostResp = value;
        _onReactPostSuccess(event.postIndex, emit);
        event.onReactPostSuccess?.call();
      }).onError((error, stackTrace) {
        _onReactPostError();
        event.onReactPostError?.call();
      });
    } catch (e) {
      debugPrint('Error reacting to post: $e');
      _onReactPostError();
      event.onReactPostError?.call();
    }
  }

  void _onReactPostSuccess(int postIndex, Emitter<CommunityState> emit) {
    final currentList =
        state.communityActivityTabModelObj?.communityListItemList ?? [];
    if (currentList.isNotEmpty && postIndex < currentList.length) {
      final updatedList = List<CommunityListItemModel>.from(currentList);
      final currentPost = updatedList[postIndex];
      final newIsLiked = !currentPost.isLiked;

      updatedList[postIndex] = currentPost.copyWith(
        isLiked: newIsLiked,
        likeCount: (currentPost.likeCount ?? 0) + (newIsLiked ? 1 : -1),
      );

      emit(state.copyWith(
        communityActivityTabModelObj:
            state.communityActivityTabModelObj?.copyWith(
          communityListItemList: updatedList,
        ),
      ));
    }
  }

  void _onReactPostError() {
    debugPrint('Error reacting to post');
  }

  FutureOr<void> _callInviteMember(
    InviteMemberEvent event,
    Emitter<CommunityState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();
    var postInviteMemberReq = PostInviteMemberReq(emails: event.emails);
    try {
      bool success = await _repository.inviteMember(
          headers: {'Authorization': 'Bearer $accessToken '},
          id: event.groupId,
          requestData: postInviteMemberReq.toJson());
      if (success) {
        event.onInviteMemberSuccess?.call();
      } else {
        event.onInviteMemberError?.call();
      }
    } catch (error) {
      event.onInviteMemberError?.call();
    }
  }

  void _onImagePicked(
    ImagePickedEvent event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(
      imageFiles: event.imageFile,
    ));
  }

  void _onSelectedQuizzfly(
    SelectQuizzflyEvent event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(
      selectedQuizzfly: event.quizzfly,
      forceUpdateSelectedQuizzfly: event.forceUpdateSelectedQuizzfly,
    ));
  }

  FutureOr<void> _callPostNewPost(
    CreatePostNewPostEvent event,
    Emitter<CommunityState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();
    List<FileReq>? processedFiles;

    try {
      if (state.imageFiles != null && state.imageFiles is List<File>) {
        UploadMultipleFileResp uploadResp =
            await _repository.uploadMultipleFiles(
          files: state.imageFiles,
          headers: {},
        );

        processedFiles = uploadResp.data
            ?.map((fileData) => FileReq(
                  publicId: fileData.publicId,
                  originalFilename: fileData.originalFilename,
                  format: fileData.format,
                  resourceType: fileData.resourceType,
                  url: fileData.url,
                  bytes: fileData.bytes,
                ))
            .toList();
      }

      var postNewPostReq = PostNewPostReq(
        type: state.selectedQuizzfly?.id == null ? "POST" : "SHARE",
        files: processedFiles,
        content: state.postInputFieldController?.text.trim(),
        quizzflyId: state.selectedQuizzfly?.id,
      );

      bool success = await _repository.postNewPost(
        headers: {'Authorization': 'Bearer $accessToken'},
        id: event.groupId,
        requestData: postNewPostReq.toJson(),
      );

      if (success) {
        event.onPostNewPostSuccess?.call();
        add(CreateGetCommunityPostsEvent(
          groupId: event.groupId,
          onGetCommunityPostsSuccess: () {},
        ));
      } else {
        event.onPostNewPostError?.call();
      }
    } catch (error) {
      debugPrint('Error creating post: $error');
      event.onPostNewPostError?.call();
    }
  }

  FutureOr<void> _callGetLibrary(
    CreateGetLibraryEvent event,
    Emitter<CommunityState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.getLibraryQuizzfly(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getLibraryResp = value;
        _onGetLibrarySuccess(value, emit);
        event.onGetLibrarySuccess?.call();
      }).onError((error, stackTrace) {
        _onGetLibraryError();
        event.onGetLibraryError?.call();
      });
    } catch (e) {
      debugPrint('Error loading library: $e');
      _onGetLibraryError();
      event.onGetLibraryError?.call();
    }
  }

  void _onGetLibrarySuccess(
    GetLibraryQuizzflyResp resp,
    Emitter<CommunityState> emit,
  ) {
    final libraryItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.createdAt ?? "");
          return LibraryListItemModel.fromQuizzflyData(
            json: item.toJson(),
            formattedDate: formattedDate,
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      communityActivityTabModelObj:
          state.communityActivityTabModelObj?.copyWith(
        libraryListItemList: libraryItems,
      ),
    ));
  }

  void _onGetLibraryError() {
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

  FutureOr<void> _callDeletePostApi(
    DeletePostEvent event,
    Emitter<CommunityState> emit,
  ) async {
    if (event.id == null) return;

    String? accessToken = PrefUtils().getAccessToken();

    try {
      bool success = await _repository.deletePost(
        headers: {'Authorization': 'Bearer $accessToken'},
        id: event.id!,
      );

      if (success) {
        event.onDeletePostEventSuccess?.call();
      } else {
        event.onDeletePostEventError?.call();
      }
    } catch (error) {
      debugPrint('Error deleting post: $error');
      event.onDeletePostEventError?.call();
    }
  }
}
