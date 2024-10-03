import '../apiClient/api_client.dart';
import '../models/login/post_login_resp.dart';

/// Repository class for managing API requests.
///
/// This class provides a simplified interface for making the
/// API request using the [ApiClient] instance
class Repository {
  final _apiClient = ApiClient();

  Future<PostLoginResp> login({
    Map<String, String> headers = const {},
    Map requestData = const {},
  }) async {
    return await _apiClient.login(
      headers: headers,
      requestData: requestData,
    );
  }
}
