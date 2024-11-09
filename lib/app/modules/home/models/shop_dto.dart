/*
 * @Author: dfh
 * @Date: 2024-10-24 08:52:52
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
class ShopDTO {
  int id;
  String name;
  String address;
  int status;
  String image;
  String description;
  String beginTime;
  String endTime;

  ShopDTO({
    required this.id,
    required this.name,
    required this.address,
    required this.status,
    required this.image,
    required this.description,
    required this.beginTime,
    required this.endTime,
  });
}
