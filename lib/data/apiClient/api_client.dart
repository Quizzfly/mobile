import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/app_export.dart';
import '../models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../models/login/post_login_resp.dart';
import '../models/register/post_register_resp.dart';
import '../models/my_user/get_my_user_resp.dart';
import '../models/update_profile/patch_update_profile_req.dart';
import '../models/upload_file/post_upload_file.dart';
import 'network_interceptor.dart';

// ignore_for_file: must_be_immutable
class ApiClient {
  factory ApiClient() {
    return _apiClient;
  }
  ApiClient._internal();
  var url = "http://103.161.96.76:3000";
  static final ApiClient _apiClient = ApiClient._internal();

  final _dio =
      Dio(BaseOptions(connectTimeout: const Duration(seconds: 60), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  }))
        ..interceptors.add(NetworkInterceptor());

  ///method can be used for checking internet connection
  ///returns [bool] based on availability of internet
  Future isNetworkConnected() async {
    if (!await NetworkInfo().isConnected()) {
      throw NoInternetException('No Internet Found!');
    }
  }

  /// is true when the response status code is between 200 and 299
  ///
  /// user can modify this method with custom logics based on their API response
  bool isSuccessCall(Response response) {
    if (response.statusCode != null) {
      return response.statusCode! >= 200 && response.statusCode! <= 299;
    }
    return false;
  }

  /// Performs API call for {{baseUrl}}/api/v1/auth/login
  ///
  /// Sends a POST request to the server's '{{baseUrl}}/api/v1/auth/login' endpoint
  /// with the provided headers and request data
  /// Returns a [PostLoginResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<PostLoginResp> login({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/login',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostLoginResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostLoginResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Sends a POST request to the server's '{{baseUrl}}/api/v1/auth/register' endpoint
  /// with the provided headers and request data
  /// Returns a [PostRegisterResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<PostRegisterResp> register({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/register',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return PostRegisterResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? PostRegisterResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Get user information with Bearer token
  Future<GetMyUserResp> getMyUser({
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/api/v1/users/me',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetMyUserResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetMyUserResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }


  Future<GetMyUserResp> updateProfile({
    required PatchUpdateProfileReq requestData,
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.patch(
        '$url/api/v1/users/profile/me',
        data: requestData.toJson(),
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetMyUserResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetMyUserResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<UploadFileResp> uploadFile({
    required File file,
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();


      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      var response = await _dio.post(
        '$url/api/v1/files',
        data: formData,
        options: Options(headers: headers),
      );


      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return UploadFileResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? UploadFileResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(error, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Sends a POST request to the server's 'http://103.161.96.76:3000/api/v1/auth/forgot-password' endpoint
  /// with the provided headers and request data
  /// Returns a [PostPostAuthForgot PasswordResp] object representing the response.
  /// Throws an error if the request fails or an exception occurs.
  Future<bool> postAuthForgotPassword({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.post(
        '$url/api/v1/auth/forgot-password',
        data: requestData,
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      // Return true if status code is 204
      return response.statusCode == 204;
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // Add this method to your ApiClient class
  Future<GetLibraryQuizzflyResp> getLibraryQuizzfly({
    Map<String, String> headers = const {},
  }) async {
    ProgressDialogUtils.showProgressDialog();
    try {
      await isNetworkConnected();
      var response = await _dio.get(
        '$url/api/v1/quizzfly',
        options: Options(headers: headers),
      );
      ProgressDialogUtils.hideProgressDialog();
      if (isSuccessCall(response)) {
        return GetLibraryQuizzflyResp.fromJson(response.data);
      } else {
        throw response.data != null
            ? GetLibraryQuizzflyResp.fromJson(response.data)
            : 'Something Went Wrong!';
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
