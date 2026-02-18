import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_name.dart';
import 'secure_auth_storage.dart';

enum ApiCallType { GET, POST, DELETE, PUT, PATCH }

class ApiCallResponse {
  const ApiCallResponse(
    this.jsonBody,
    this.headers,
    this.statusCode, {
    this.exception,
  });

  final dynamic jsonBody;
  final Map<String, String> headers;
  final int statusCode;
  final Object? exception;

  bool get succeeded => statusCode >= 200 && statusCode < 300;

  String getHeader(String headerName) => headers[headerName] ?? '';

  String get bodyText =>
      jsonBody is String ? jsonBody as String : jsonEncode(jsonBody ?? {});

  String get exceptionMessage => exception?.toString() ?? '';
}

/// MDL-style check: response succeeded and has non-empty data list.
bool apicheckJsonNull(ApiCallResponse response) {
  if (response.succeeded &&
      response.jsonBody != null &&
      response.jsonBody is Map &&
      response.jsonBody['data'] != null &&
      response.jsonBody['data'] is List &&
      (response.jsonBody['data'] as List).isNotEmpty) {
    return true;
  }
  return false;
}

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode, this.original});

  final String message;
  final int? statusCode;
  final dynamic original;

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (status: $statusCode)' : ''}';
}

class SumikiNovaApi {
  SumikiNovaApi._();

  static String getBaseUrl() => 'http://5.9.161.137/~logiccar/sumika/api/';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: getBaseUrl(),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static Dio get dio => _dio;

  static final SendMessageCall sendMessageCall = SendMessageCall();
  static final RegisterCall registerCall = RegisterCall();
  static final LoginCall loginCall = LoginCall();
  static final VerifyOtpCall verifyOtpCall = VerifyOtpCall();
  static final ForgotPasswordCall forgotPasswordCall = ForgotPasswordCall();
  static final ResetPasswordCall resetPasswordCall = ResetPasswordCall();
  static final ChangePasswordCall changePasswordCall = ChangePasswordCall();
  static final CreateHomeCall createHomeCall = CreateHomeCall();
  static final CreateHomeWithLocationsCall createHomeWithLocationsCall =
      CreateHomeWithLocationsCall();
  static final GetRoomCall getRoomCall = GetRoomCall();
  static final GetDeviceCall getDeviceCall = GetDeviceCall();
}

/// Builds headers with optional Bearer token from [SecureAuthStorage].
Future<Map<String, String>> buildApiHeaders() async {
  final headers = <String, String>{
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  final token = await SecureAuthStorage.getToken();
  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

/// Dio-based implementation of MDL-style makeApiCall. Reference for adding more endpoints.
Future<ApiCallResponse> makeApiCall({
  required String apiUrl,
  required ApiCallType callType,
  Map<String, dynamic> headers = const {},
  Map<String, dynamic> params = const {},
  dynamic body,
  bool returnBody = true,
}) async {
  final h = Map<String, String>.from(
    headers.map((k, v) => MapEntry(k, v.toString())),
  );

  try {
    switch (callType) {
      case ApiCallType.GET:
        final response = await SumikiNovaApi.dio.get<dynamic>(
          apiUrl,
          queryParameters: params.isNotEmpty ? params : null,
          options: Options(headers: h),
        );
        return _toApiCallResponse(response, returnBody);
      case ApiCallType.POST:
        final response = await SumikiNovaApi.dio.post<dynamic>(
          apiUrl,
          queryParameters: params.isNotEmpty ? params : null,
          data: body,
          options: Options(headers: h),
        );
        return _toApiCallResponse(response, returnBody);
      case ApiCallType.PUT:
        final response = await SumikiNovaApi.dio.put<dynamic>(
          apiUrl,
          queryParameters: params.isNotEmpty ? params : null,
          data: body,
          options: Options(headers: h),
        );
        return _toApiCallResponse(response, returnBody);
      case ApiCallType.PATCH:
        final response = await SumikiNovaApi.dio.patch<dynamic>(
          apiUrl,
          queryParameters: params.isNotEmpty ? params : null,
          data: body,
          options: Options(headers: h),
        );
        return _toApiCallResponse(response, returnBody);
      case ApiCallType.DELETE:
        final response = await SumikiNovaApi.dio.delete<dynamic>(
          apiUrl,
          queryParameters: params.isNotEmpty ? params : null,
          data: body,
          options: Options(headers: h),
        );
        return _toApiCallResponse(response, returnBody);
    }
  } on DioException catch (e) {
    final statusCode = e.response?.statusCode ?? -1;
    final responseHeaders =
        e.response?.headers.map.map((k, v) => MapEntry(k, v.join(','))) ??
        <String, String>{};
    dynamic jsonBody;
    try {
      if (e.response?.data != null) {
        jsonBody = e.response!.data is Map
            ? e.response!.data
            : jsonDecode(e.response!.data.toString());
      }
    } catch (_) {
      jsonBody = e.response?.data?.toString();
    }
    return ApiCallResponse(jsonBody, responseHeaders, statusCode, exception: e);
  } catch (e) {
    return ApiCallResponse(null, {}, -1, exception: e);
  }
}

ApiCallResponse _toApiCallResponse(
  Response<dynamic> response,
  bool returnBody,
) {
  final statusCode = response.statusCode ?? 0;
  final headers = response.headers.map.map((k, v) => MapEntry(k, v.join(',')));
  return ApiCallResponse(
    returnBody ? response.data : null,
    headers,
    statusCode,
  );
}

class SendMessageCall {
  Future<ApiCallResponse> call({
    String? user = '',
    String? contact = '',
    String? messageContent = '',
    String? conversation = '',
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final body = <String, String>{
      'User': user ?? '',
      'Contact': contact ?? '',
      'Message Content': messageContent ?? '',
      'Conversation': conversation ?? '',
    };
    return makeApiCall(
      apiUrl: '${baseUrl}send_twilio_sms',
      callType: ApiCallType.POST,
      params: {},
      body: body,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/register — name, email, password, password_confirmation
class RegisterCall {
  Future<ApiCallResponse> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final body = <String, String>{
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.signUp}',
      callType: ApiCallType.POST,
      body: body,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/location_list — Authorization: Bearer required
class GetRoomCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.getroom}',
      callType: ApiCallType.GET,
      headers: headers,
      returnBody: true,
    );
  }
}

class GetDeviceCall {
  Future<ApiCallResponse> call({String? roomId}) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.getdevice}',
      callType: ApiCallType.GET,
      headers: headers,
      // params: <String, String>{'room_id': roomId},
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/login — email, password
class LoginCall {
  Future<ApiCallResponse> call({
    required String email,
    required String password,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    print('email: $email');
    print('password: $password');
    final body = <String, String>{'email': email, 'password': password};
    print('body: $body');
    print('baseUrl: $baseUrl');
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.signIn}',
      callType: ApiCallType.POST,
      body: body,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/verify-register-otp — email, otp
class VerifyOtpCall {
  Future<ApiCallResponse> call({
    required String email,
    required String otp,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final body = <String, String>{'email': email, 'otp': otp};
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.verifyotp}',
      callType: ApiCallType.POST,
      body: body,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/forgot-password — email
class ForgotPasswordCall {
  Future<ApiCallResponse> call({required String email}) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final body = <String, String>{'email': email};
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.forgetpassword}',
      callType: ApiCallType.POST,
      body: body,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/reset-password — email, otp, password, password_confirmation
class ResetPasswordCall {
  Future<ApiCallResponse> call({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final body = <String, String>{
      'email': email,
      'otp': otp,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.resetpassword}',
      callType: ApiCallType.POST,
      body: body,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/create-home — Authorization: Bearer required; name, address, city, state, zip, country
class CreateHomeCall {
  Future<ApiCallResponse> call({
    required String name,
    required String userid,
    required String is_active,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final body = <String, String>{
      'name': name,
      'user_id': userid,
      'is_active': is_active,
    };
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.createHome}',
      callType: ApiCallType.POST,
      headers: headers,
      body: body,
      returnBody: true,
    );
  }
}

/// POST form-data create-home-with-locations — name, address, user_id, is_active, locations[i][name], locations[i][is_active], locations[i][location_list_id]
class CreateHomeWithLocationsCall {
  Future<ApiCallResponse> call({
    required String name,
    required String address,
    required String userid,
    required String isActive,
    required List<Map<String, String>> locations,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    headers.remove('Content-Type');
    final formData = FormData();
    formData.fields.addAll([
      MapEntry('name', name),
      MapEntry('address', address),
      MapEntry('user_id', userid),
      MapEntry('is_active', isActive),
    ]);
    for (var i = 0; i < locations.length; i++) {
      final loc = locations[i];
      formData.fields.addAll([
        MapEntry('locations[$i][name]', loc['name'] ?? ''),
        MapEntry('locations[$i][is_active]', loc['is_active'] ?? '1'),
        MapEntry('locations[$i][location_list_id]', loc['location_list_id'] ?? ''),
      ]);
      if (loc['photo_path'] != null && loc['photo_path']!.isNotEmpty) {
        formData.fields.add(MapEntry('locations[$i][photo_path]', loc['photo_path']!));
      }
    }
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.createHomeWithLocations}',
      callType: ApiCallType.POST,
      headers: headers,
      body: formData,
      returnBody: true,
    );
  }
}

/// POST BASE_PATH/change-password — Authorization: Bearer required; current_password, password, password_confirmation
class ChangePasswordCall {
  Future<ApiCallResponse> call({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final body = <String, String>{
      'current_password': currentPassword,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.changepassword}',
      callType: ApiCallType.POST,
      headers: headers,
      body: body,
      returnBody: true,
    );
  }
}
