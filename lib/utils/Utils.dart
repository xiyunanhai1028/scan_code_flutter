/*
 * @Author: dfh
 * @Date: 2024-10-21 09:57:39
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import '../bean/search_model.dart';

class Utils {
  static String resoveOptions(SearchModel? options) {
    String params = "pageSize=10";
    if (options != null && options.page != null) {
      params += "&page=${options.page}";
    } else {
      params += "&page=1";
    }
    if (options != null && options.name != null) {
      params += "&name=${options.name}";
    }
    if (options != null && options.status != null) {
      params += "&status=${options.status}";
    }
    if (options != null && options.categoryId != null) {
      params += "&categoryId=${options.categoryId}";
    }
    if (options != null && options.type != null) {
      params += "&type=${options.type}";
    }
    if (options != null && options.number != null) {
      params += "&number=${options.number}";
    }
    return params;
  }
}
