import 'dart:io';
import 'package:quizzfly_application_flutter/data/models/detail_post/get_detail_post_resp.dart';
import 'package:quizzfly_application_flutter/data/models/list_comment/get_list_comment_resp.dart';
import 'package:quizzfly_application_flutter/data/models/list_post/get_list_post_group_resp.dart';

import '../../data/models/my_group/get_my_group_resp.dart';
import '../../data/models/change_password/post_change_password_resp.dart';
import '../../data/models/detail_quizzfly/get_detail_quizzfly_resp.dart';
import '../../data/models/list_question/get_list_question_resp.dart';
import '../models/upload_file/post_upload_file_resp.dart';
import '../apiClient/api_client.dart';
import '../models/create_group/post_create_group_resp.dart';
import '../models/delete_user/post_request_delete_user_req.dart';
import '../models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../models/list_comment/post_comment_resp.dart';
import '../models/list_comment/post_react_post_resp.dart';
import '../models/login/post_login_resp.dart';
import '../models/my_user/get_my_user_resp.dart';
import '../models/register/post_register_resp.dart';
import '../models/update_profile/patch_update_profile_req.dart';
import '../models/update_quizzfly_setting/put_update_quizzfly_setting_resp.dart';
import '../models/upload_file/post_upload_multiple_file_resp.dart';
import '../models/verify_delete_user/delete_verify_delete_user_resp.dart';

/// Repository class for managing API requests.
///
/// This class provides a simplified interface for making the
/// API request using the [ApiClient] instance
class Repository {
  final _apiClient = ApiClient();
  Future<PostRegisterResp> register({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.register(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<PostLoginResp> login({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.login(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<GetMyUserResp> getMyUser(
      {Map<String, String> headers = const {}}) async {
    try {
      return await _apiClient.getMyUser(
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetMyUserResp> updateProfile({
    required PatchUpdateProfileReq requestData,
    Map<String, String> headers = const {},
  }) async {
    try {
      return await _apiClient.updateProfile(
        requestData: requestData,
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadFileResp> uploadFile({
    required File file,
    Map<String, String> headers = const {},
  }) async {
    try {
      return await _apiClient.uploadFile(file: file, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadMultipleFileResp> uploadMultipleFiles({
    required List<File> files,
    Map<String, String> headers = const {},
  }) async {
    try {
      return await _apiClient.uploadMultipleFiles(
          files: files, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> postAuthForgotPassword({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    try {
      return await _apiClient.postAuthForgotPassword(
        headers: headers,
        requestData: requestData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetLibraryQuizzflyResp> getLibraryQuizzfly({
    Map<String, String> headers = const {},
  }) async {
    try {
      return await _apiClient.getLibraryQuizzfly(
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<GetDetailQuizzflyResp> getDetailQuizzfly(String id) async {
    return await _apiClient.getDetailQuizzfly(id);
  }

  Future<PostChangePasswordResp> changePassword(
      {Map<String, String> headers = const {},
      Map requestData = const {}}) async {
    try {
      return await _apiClient.changePassword(
        headers: headers,
        requestData: requestData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PostRequestDeleteUserResp> requestDeleteUser({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.requestDeleteUser(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<bool> logoutPost({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.logoutPost(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<DeleteVerifyDeleteUserResp> verifyDeleteUser({
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParams = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.verifyDeleteUser(
      headers: headers,
      queryParams: queryParams,
    );
  }

  Future<PutUpdateQuizzflySettingsResp> updateQuizzflySettings(
      {Map<String, String> headers = const {},
      Map requestData = const {},
      String? id}) async {
    return await _apiClient.updateQuizzflySettings(
        headers: headers, requestData: requestData, id: id);
  }

  Future<bool> deleteQuizzfly(
      {Map<String, String> headers = const {}, String? id}) async {
    return await _apiClient.deleteQuizzfly(headers: headers, id: id);
  }

  Future<GetListQuestionsResp> listQuestions(
      {Map<String, String> headers = const {},
      Map requestData = const {},
      String? id}) async {
    return await _apiClient.listQuestions(
        headers: headers, requestData: requestData, id: id);
  }

  Future<PostLoginResp> loginWithGoogle({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.loginWithGoogle(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<PostCreateGroupResp> createGroup({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.createGroup(
      headers: headers,
      requestData: requestData,
    );
  }

  Future<GetMyGroupsResp> getMyGroup({
    Map<String, String> headers = const {},
  }) async {
    try {
      return await _apiClient.getMyGroup(
        headers: headers,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteMyGroup(
      {Map<String, String> headers = const {}, String? id}) async {
    return await _apiClient.deleteMyGroup(headers: headers, id: id);
  }

  Future<bool> deletePost(
      {Map<String, String> headers = const {}, String? id}) async {
    return await _apiClient.deletePost(headers: headers, id: id);
  }

  Future<GetListPostGroupResp> getListPostGroup(
      {Map<String, String> headers = const {}, String? id}) async {
    return await _apiClient.getListPostGroup(headers: headers, id: id);
  }

  Future<GetDetailPostResp> getDetailPost(
      {Map<String, String> headers = const {},
      String? groupId,
      String? postId}) async {
    return await _apiClient.getDetailPost(
        headers: headers, groupId: groupId, postId: postId);
  }

  Future<GetListCommentResp> getListCommentPost(
      {Map<String, String> headers = const {}, String? postId}) async {
    return await _apiClient.getListCommentPost(
        headers: headers, postId: postId);
  }

  Future<GetListCommentResp> getListCommentReplies(
      {Map<String, String> headers = const {}, String? postId}) async {
    return await _apiClient.getListCommentReplies(
        headers: headers, postId: postId);
  }

  Future<PostCommentResp> postComment(
      {Map<String, String> headers = const {},
      Map requestData = const {},
      String? postId}) async {
    return await _apiClient.postComment(
        headers: headers, requestData: requestData, postId: postId);
  }

  Future<PostReactPostResp> reactPost(
      {Map<String, String> headers = const {}, String? postId}) async {
    return await _apiClient.reactPost(headers: headers, postId: postId);
  }

  Future<bool> deleteComment(
      {Map<String, String> headers = const {}, String? id}) async {
    return await _apiClient.deleteComment(headers: headers, id: id);
  }

  Future<bool> joinGroup(
      {Map<String, String> headers = const {}, String? id}) async {
    return await _apiClient.joinGroup(headers: headers, id: id);
  }

  Future<bool> inviteMember(
      {Map<String, String> headers = const {},
      String? id,
      Map requestData = const {}}) async {
    return await _apiClient.inviteMember(
        headers: headers, id: id, requestData: requestData);
  }

  Future<bool> postNewPost(
      {Map<String, String> headers = const {},
      String? id,
      Map requestData = const {}}) async {
    return await _apiClient.postNewPost(
        headers: headers, id: id, requestData: requestData);
  }
}
