/*
 * @Author: dfh
 * @Date: 2024-09-21 14:34:11
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:dio/dio.dart';

class HttpException implements Exception {
  final int code;
  final String msg;

  HttpException({this.code = 500, this.msg = '未知异常,请联系管理员'});

  String toString() {
    return msg;
  }

  factory HttpException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return HttpException(code: -1, msg: "请求取消");
      case DioErrorType.connectTimeout:
        return HttpException(code: -1, msg: "连接超时");
      case DioErrorType.sendTimeout:
        return HttpException(code: -1, msg: "请求超时");
      case DioErrorType.receiveTimeout:
        return HttpException(code: -1, msg: '响应超时');
      case DioErrorType.response:
        //服务器异常
        int statusCode = error.response!.statusCode ?? 500;
        switch (statusCode) {
          case 400:
            return HttpException(code: statusCode, msg: '请求语法错误');
          case 401:
            return HttpException(code: statusCode, msg: "没有权限");
          case 403:
            return HttpException(code: statusCode, msg: "服务器拒绝执行");
          case 404:
            return HttpException(code: statusCode, msg: "无法连接服务器");
          case 500:
            return HttpException(code: statusCode, msg: "服务器内部错误");
          case 502:
            return HttpException(code: statusCode, msg: "无效的请求");
          case 503:
            return HttpException(code: statusCode, msg: "服务器挂了");
          case 505:
            return HttpException(code: statusCode, msg: "不支持HTTP协议请求");
          default:
            return HttpException(
                code: statusCode, msg: error.response!.statusMessage ?? '未知错误');
        }
      default:
        return HttpException(code: 500, msg: "无法连接服务器");
    }
  }
}
