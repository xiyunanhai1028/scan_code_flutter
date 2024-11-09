/*
 * @Author: dfh
 * @Date: 2024-09-21 14:49:44
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:dio/dio.dart';
import 'package:flutter_pc_manager/network/http_interceptor.dart';
import 'package:flutter_pc_manager/network/http_options.dart';

class HttpRequest {
  //工厂构造方法
  factory HttpRequest() => _instance;
  //初始化一个单列实例
  static final HttpRequest _instance = HttpRequest._internal();

  //dio实例
  Dio? dio;

  //内部构造方法
  HttpRequest._internal() {
    if (dio == null) {
      BaseOptions baseOptions = BaseOptions(
          baseUrl: HttpOptions.BASE_URL,
          connectTimeout: HttpOptions.CONNECT_TIMEOUT,
          receiveTimeout: HttpOptions.RECEIVE_TIMEOUT,
          headers: {
          });
      //没有实例 则创建
      dio = Dio(baseOptions);
      //添加拦截器
      dio!.interceptors.add(HttpInterceptor());
    }
  }

  //初始化公共属性，如果需要覆盖原配置项，就调用它
  void init(
      {required String baseUrl,
      required int connectTimeout,
      required int receiveTimeout,
      required Map<String, dynamic> headers,
      required List<Interceptor> interceptors}) {
    dio!.options.baseUrl = baseUrl;
    dio!.options.connectTimeout = connectTimeout;
    dio!.options.receiveTimeout = receiveTimeout;
    dio!.options.headers = headers;
    if (interceptors.isNotEmpty) {
      dio!.interceptors.addAll(interceptors);
    }
  }

  //设置请求头
  void setHeaders(Map<String, dynamic> headers) {
    dio!.options.headers.addAll(headers);
  }

  //取消请求
  //同一个cancel token可以用于多个请求
  //当一个cancel token取消时,所有使用该cancel token请求被取消
  //所有参数可选
  final CancelToken _cancelToken = CancelToken();
  void cancelRequests(CancelToken token) {
    _cancelToken.cancel("cancelled");
  }

  //设置鉴权请求头
  Options setAuthorizationHeader(Options requestOptions) {
    return requestOptions;
  }

  //restful get
  Future get(String path,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken}) async {
    Options requestOptions = (options ?? Options());
    Response response = await dio!.get(path,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  //restful post
  Future post(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      Options? options,
      CancelToken? cancelToken}) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());
    Response response = await dio!.post(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

  //restful post form
  Future postForm(String path,
      {required String filePath,
      Options? options,
      CancelToken? cancelToken}) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());
    Response response = await dio!.post(path,
        data:
            FormData.fromMap({"file": await MultipartFile.fromFile(filePath)}),
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

   //restful delete
  Future delete(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      Options? options,
      CancelToken? cancelToken}) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());
    Response response = await dio!.delete(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }

     //restful put
  Future put(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      Options? options,
      CancelToken? cancelToken}) async {
    Options requestOptions = setAuthorizationHeader(options ?? Options());
    Response response = await dio!.put(path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken);
    return response.data;
  }
}
