/*
 * @Author: dfh
 * @Date: 2024-09-21 14:53:32
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
class HttpOptions {
  //拦截服务器超时时间
  static const int CONNECT_TIMEOUT = 60 * 1000;
  //接收超时时间
  static const int RECEIVE_TIMEOUT = 60 * 1000;
  //服务器地址
  // static String BASE_URL = "https://685709d3.r19.cpolar.top/admin";
  static String BASE_URL = "http://10.10.32.78:8081/admin";
  // static String BASE_URL = "http://192.168.3.7:8081/admin";
  // static String BASE_URL = "http://192.168.10.17:8081/admin";
  //图片地址
  static String BASE_IMAGE_URL = "${HttpOptions.BASE_URL}/common/download?name";
  //服务器websocket地址
  // static String WEB_SCOKET_URL = "ws://685709d3.r19.cpolar.top/ws";
  static String WEB_SCOKET_URL = "ws://10.10.32.78:8081/ws";
}
