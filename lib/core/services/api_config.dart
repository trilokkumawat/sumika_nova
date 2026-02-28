import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:sumikanova/core/utils/app_logger.dart';
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

  static String getBaseUrl() {
    final base = dotenv.env['BASE_URL']?.trim() ?? '';
    if (base.isEmpty) return '';
    return base.endsWith('/') ? base : '$base/';
  }

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
  static final GetUserHomeListCall getUserHomeListCall = GetUserHomeListCall();
  static final GetHomeByIdLocationCall getHomeByIdLocationCall =
      GetHomeByIdLocationCall();
  static final EditProfileCall editProfileCall = EditProfileCall();
  static final DeleteCall deleteCall = DeleteCall();
  static final UpdateHomeCall updateHomeCall = UpdateHomeCall();
  static final DeleteLocationCall deleteLocationCall = DeleteLocationCall();
  static final UpdateLocationCall updateLocationCall = UpdateLocationCall();
  static final CreateMultipleLocationsCall createMultipleLocationsCall =
      CreateMultipleLocationsCall();
  static final GetSunWeatherCall getSunWeatherCall = GetSunWeatherCall();
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
    final body = <String, String>{'email': email, 'password': password};
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
        MapEntry(
          'locations[$i][location_list_id]',
          loc['location_list_id'] ?? '',
        ),
      ]);
      if (loc['photo_path'] != null && loc['photo_path']!.isNotEmpty) {
        formData.fields.add(
          MapEntry('locations[$i][photo_path]', loc['photo_path']!),
        );
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

/// GET BASE_PATH/user-home-list/{userId} — Authorization: Bearer required
class GetUserHomeListCall {
  Future<ApiCallResponse> call({required String userId}) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final apiUrl = '${baseUrl}${ApiName.getuserhomelist}/$userId';
    AppLogger.d('apiUrl: $apiUrl');
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.GET,
      headers: headers,
      returnBody: true,
    );
  }
}

class GetHomeByIdLocationCall {
  Future<ApiCallResponse> call({required String homeid}) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final apiUrl = '${baseUrl}${ApiName.gethomebylocationid}/$homeid';
    AppLogger.d('apiUrl: $apiUrl');
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.GET,
      headers: headers,
      returnBody: true,
    );
  }
}

class GetSunWeatherCall {
  /// GET current weather from Open-Meteo (no auth).
  /// Example: https://api.open-meteo.com/v1/forecast?latitude=23.79&longitude=68.65&current_weather=true&timezone=auto
  Future<ApiCallResponse> call({
    required String latitude,
    required String longitude,
  }) async {
    const baseUrl = 'https://api.open-meteo.com/v1/forecast';

    AppLogger.d(
      'apiUrl: $baseUrl?latitude=$latitude&longitude=$longitude&current_weather=true&timezone=auto',
    );
    return makeApiCall(
      apiUrl: baseUrl,
      callType: ApiCallType.GET,
      params: {
        'latitude': latitude,
        'longitude': longitude,
        'current_weather': 'true',
        'timezone': 'auto',
      },
      returnBody: true,
    );
  }
}

/// POST edit-profile — Authorization: Bearer required; body: name (key-value).
/// User is identified by the Bearer token, not by userId in the path.
class EditProfileCall {
  Future<ApiCallResponse> call({required String name}) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final apiUrl = '${baseUrl}${ApiName.editprofile}';
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.POST,
      headers: headers,
      body: {'name': name},
      returnBody: true,
    );
  }
}

/// POST delete-home — Authorization: Bearer required; home_id
class DeleteCall {
  Future<ApiCallResponse> call({
    required String endpoint,
    required String id,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final apiUrl = '${baseUrl}${endpoint}/$id';
    AppLogger.d('apiUrl: $apiUrl');
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.DELETE,
      headers: headers,
      returnBody: true,
    );
  }
}

/// PUT update-home/{id} — name, address, is_active
class UpdateHomeCall {
  Future<ApiCallResponse> call({
    required String homeId,
    required String name,
    required String address,
    int isActive = 1,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final apiUrl = '${baseUrl}${ApiName.updateHome}/$homeId';
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.PUT,
      headers: headers,
      body: {'name': name, 'address': address, 'is_active': isActive},
      returnBody: true,
    );
  }
}

/// DELETE delete-location/{id}
class DeleteLocationCall {
  Future<ApiCallResponse> call({required String locationId}) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    final apiUrl = '${baseUrl}${ApiName.deleteLocation}/$locationId';
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.DELETE,
      headers: headers,
      returnBody: true,
    );
  }
}

/// POST locations/create-multiple — form: home_id, user_id, locations[i][location_list_id], locations[i][name], locations[i][is_active], optional locations[i][photo_path] (file)
class CreateMultipleLocationsCall {
  Future<ApiCallResponse> call({
    required String homeId,
    required String userId,
    required List<Map<String, String>> locations,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    headers.remove('Content-Type');
    final formData = FormData();
    formData.fields.addAll([
      MapEntry('home_id', homeId),
      MapEntry('user_id', userId),
    ]);
    for (var i = 0; i < locations.length; i++) {
      final loc = locations[i];
      formData.fields.addAll([
        MapEntry(
          'locations[$i][location_list_id]',
          loc['location_list_id'] ?? '',
        ),
        MapEntry('locations[$i][name]', loc['name'] ?? ''),
        MapEntry('locations[$i][is_active]', loc['is_active'] ?? '1'),
      ]);
      formData.files.add(
        MapEntry(
          'locations[$i][photo_path]',
          (loc['photo_path'] != null && loc['photo_path']!.isNotEmpty)
              ? await MultipartFile.fromFile(
                  loc['photo_path']!,
                  filename: 'room_$i.jpg',
                )
              : MultipartFile.fromBytes([], filename: null),
        ),
      );
    }
    AppLogger.d('formData fields: ${formData.fields}');
    AppLogger.d('formData files: ${formData.files}');
    return makeApiCall(
      apiUrl: '${baseUrl}${ApiName.createMultipleLocations}',
      callType: ApiCallType.POST,
      headers: headers,
      body: formData,
      returnBody: true,
    );
  }
}

/// PUT update-location/{id} — form: name, is_active, location_list_id, optional photo_path (file)
class UpdateLocationCall {
  Future<ApiCallResponse> call({
    required String locationId,
    required String name,
    required String isActive,
    required String locationListId,
    String? photoFilePath,
  }) async {
    final baseUrl = SumikiNovaApi.getBaseUrl();
    final headers = await buildApiHeaders();
    headers.remove('Content-Type');
    final apiUrl = '${baseUrl}${ApiName.updateLocation}/$locationId';
    final formData = FormData();
    formData.fields.addAll([
      MapEntry('name', name),
      MapEntry('is_active', isActive),
      MapEntry('location_list_id', locationListId),
      MapEntry('location_id', locationId),
    ]);
    if (photoFilePath != null && photoFilePath.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'photo_path',
          await MultipartFile.fromFile(
            photoFilePath,
            filename: 'room_$locationId.jpg',
          ),
        ),
      );
    }
    return makeApiCall(
      apiUrl: apiUrl,
      callType: ApiCallType.POST,
      headers: headers,
      body: formData,
      returnBody: true,
    );
  }
}
