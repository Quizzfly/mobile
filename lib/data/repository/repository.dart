import 'dart:io';
import 'package:quizzfly_application_flutter/data/models/change_password/post_change_password_resp.dart';
import 'package:quizzfly_application_flutter/data/models/detail_quizzfly/get_detail_quizzfly_resp.dart';
import 'package:quizzfly_application_flutter/data/models/upload_file/post_upload_file.dart';
import '../apiClient/api_client.dart';
import '../models/delete_user/post_request_delete_user_req.dart';
import '../models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../models/login/post_login_resp.dart';
import '../models/my_user/get_my_user_resp.dart';
import '../models/register/post_register_resp.dart';
import '../models/update_profile/patch_update_profile_req.dart';
import '../models/update_quizzfly_setting/put_update_quizzfly_setting_resp.dart';
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
      print('Error fetching user profile: $e');
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
      print('Error updating user profile: $e');
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
      print('Error updating user profile: $e');
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
      print('Error forgot password : $e');
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
      print('Error fetching quizzfly library: $e');
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
      print('Error fetching user profile: $e');
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

  Future<PutUpdateQuizzflySettingsResp> updateQuizzflySettings({
    Map<String, String> headers = const {},
    Map requestData = const {},
    String? id
  }) async {
    return await _apiClient.updateQuizzflySettings(
      headers: headers,
      requestData: requestData,
      id: id
    );
  }
  Future<bool> deleteQuizzfly({
    Map<String, String> headers = const {},
    String? id
  }) async {
    return await _apiClient.deleteQuizzfly(
      headers: headers,
      id: id
    );
  }
}
