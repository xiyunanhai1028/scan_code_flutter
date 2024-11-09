/*
 * @Author: dfh
 * @Date: 2024-09-21 14:28:43
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:dio/dio.dart';
import 'http_exception.dart';

class HttpInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler)  {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //覆盖异常为自己定义的异常类
    HttpException httpException = HttpException.create(err);
    err.error = httpException;
    super.onError(err, handler);
  }
}
