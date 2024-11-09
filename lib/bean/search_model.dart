/*
 * @Author: dfh
 * @Date: 2024-10-21 10:01:51
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
class SearchModel {
  int? page;
  int? pageSize;
  String? name;
  String? status;
  String? categoryId;
  int? type;
  int? number;

  SearchModel(
      {this.page,
      this.pageSize,
      this.name,
      this.status,
      this.categoryId,
      this.type,
      this.number //订单号
      });
}
