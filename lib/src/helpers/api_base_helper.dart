import 'package:dio/dio.dart';
import 'package:ob_admin_panel/src/configs/config.dart';
import 'dart:io';

import 'app_exception.dart';

class ApiBaseHelper {
  Dio _dio = Dio(BaseOptions(
      connectTimeout: Config.CONNECTION_TIME_OUT,
      receiveTimeout: Config.READ_TIME_OUT));

  ApiBaseHelper() {
    _dio.interceptors.add(LogInterceptor(requestBody: true));
  }

  Future<Response> post(
      {String url,
      Map<String, dynamic> headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {}}) async {
    Response responseMap;

    try {
      final Response response = await _dio.post(url,
          queryParameters: parameters,
          options: Options(headers: headers),
          data: data);

      responseMap = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on DioError catch (error) {
      String exceptionText = _handleError(error);
      throw FetchDataException(exceptionText);
    }

    return responseMap;
  }

  Future<Response> put(
      {String url,
      Map<String, dynamic> headers,
      Map<String, dynamic> parameters = const {},
      dynamic data = const {}}) async {
    Response responseMap;

    try {
      final Response response = await _dio.put(url,
          queryParameters: parameters,
          options: Options(headers: headers),
          data: data);

      responseMap = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on DioError catch (error) {
      String exceptionText = _handleError(error);
      throw FetchDataException(exceptionText);
    }

    return responseMap;
  }

  Future<dynamic> get({
    String url,
    Map<String, dynamic> headers,
    Map<String, dynamic> parameters = const {},
  }) async {
    Response responseMap;

    try {
      final Response response = await _dio.get(
        url,
        queryParameters: parameters,
        options: Options(headers: headers),
      );

      responseMap = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet connection");
    } on DioError catch (error) {
      String exceptionText = _handleError(error);
      throw FetchDataException(exceptionText);
    }

    return responseMap;
  }

  Response _returnResponse(Response response) {
    if (response.statusCode != 200) {
      throw BadRequestException(response.data['message']);
    }
    return response;
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send time out";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
