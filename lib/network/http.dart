/*
 * @Author: dfh
 * @Date: 2024-09-21 14:23:43
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:dio/dio.dart';
import 'package:flutter_pc_manager/network/http_request.dart';

class Http {
  //覆盖初始化公共属性
  static void init(
      {required String baseUrl,
      required int connectTimeout,
      required int receiveTimeout,
      required Map<String, dynamic> headers,
      required List<Interceptor> interceptors}) {
    HttpRequest().init(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: headers,
        interceptors: interceptors);
  }

  //设置请求头
  static void setHeaders(Map<String, dynamic> headers) {
    HttpRequest().setHeaders(headers);
  }

  //取消请求
  static void cancelRequests({required CancelToken token}) {
    HttpRequest().cancelRequests(token);
  }

  //get
  static Future get(String path,
      {Map<String, dynamic>? params,
      Options? options,
      CancelToken? cancelToken}) async {
    return await HttpRequest()
        .get(path, params: params, options: options, cancelToken: cancelToken);
  }

  //post
  static Future post(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      Options? options,
      CancelToken? cancelToken}) async {
    return await HttpRequest().post(path,
        params: params, data: data, options: options, cancelToken: cancelToken);
  }

  //post form
  static Future postForm(String path,
      {required String filePath,
      Options? options,
      CancelToken? cancelToken}) async {
    return await HttpRequest().postForm(path,
        filePath: filePath, options: options, cancelToken: cancelToken);
  }

   //delete
  static Future delete(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      Options? options,
      CancelToken? cancelToken}) async {
    return await HttpRequest().delete(path,
        params: params, data: data, options: options, cancelToken: cancelToken);
  }

   //put
  static Future put(String path,
      {Map<String, dynamic>? params,
      dynamic data,
      Options? options,
      CancelToken? cancelToken}) async {
    return await HttpRequest().put(path,
        params: params, data: data, options: options, cancelToken: cancelToken);
  }
}
