import 'dart:io';
import 'package:quizzfly_application_flutter/data/models/upload_file/post_upload_file.dart';
import '../apiClient/api_client.dart';
import '../models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../models/login/post_login_resp.dart';
import '../models/my_user/get_my_user_resp.dart';
import '../models/register/post_register_resp.dart';
import '../models/update_profile/patch_update_profile_req.dart';
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
    try{
    return await _apiClient.postAuthForgotPassword(
      headers: headers,
      requestData: requestData,
    );
    } catch(e){
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
}
