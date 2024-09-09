import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_demo_redtilt_task/components/controllers/api_controllers/api_response_data.dart';
import 'package:e_commerce_demo_redtilt_task/components/controllers/shared_preference/token_store.dart';
import 'package:http/http.dart' as http;

Future<ApiResponseData> getApiController(
  String endpoint,
  bool isTokenNeeded,
) async {
  Map<String, String> header = {};
  if (isTokenNeeded) {
    final token = await TokenStore.getBearerToken();
    header["Authorization"] = "Bearer $token";
  }
  ApiResponseData result = ApiResponseData();
  try {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: header,
    );
    result.statusCode = response.statusCode;
    result.responseBody = response.body;
    return result;
  } catch (e) {
    result.responseBody =
        jsonEncode({"message": "Failed to connect $endpoint"});
    log('Failed to connect with $endpoint');
  }
  return result;
}
