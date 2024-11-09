/*
 * @Author: dfh
 * @Date: 2024-10-20 00:17:55
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';
import 'package:flutter_pc_manager/network/http.dart';
import 'package:flutter_pc_manager/network/http_options.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddImageWidget extends StatefulWidget {
  final String label;
  final Function callback;
  final String initialImage;

  const AddImageWidget(
      {super.key,
      required this.label,
      required this.callback,
      required this.initialImage});

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  String image = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialImage.isNotEmpty) {
      setState(() {
        image =
            '${HttpOptions.BASE_URL}/common/download?name=${widget.initialImage}';
      });
    }
  }

  void uploadFile(String filePath) async {
    dynamic result = await Http.postForm('/common/upload', filePath: filePath);
    int code = result['code'];
    if (code == 1) {
      String imageTail = result['data'];
      setState(() {
        image = '${HttpOptions.BASE_URL}/common/download?name=$imageTail';
        widget.callback(imageTail);
      });
    } else {
      String msg = result['msg'];
      Get.snackbar('错误', msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.star,
          color: Colors.red,
          size: 12,
        ),
        Text(
          "${widget.label}图片:",
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final imageFile =
                await picker.getImage(source: ImageSource.gallery);
            if (imageFile != null && imageFile.path.isNotEmpty) {
              uploadFile(imageFile.path);
            }
          },
          child: Container(
            width: 160,
            height: 160,
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                border: Border.all(color: GlobalColor.bgColor),
                borderRadius: BorderRadius.circular(10)),
            child: image.isNotEmpty
                ? Image.network(
                    image,
                    fit: BoxFit.contain,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: Colors.grey[600],
                        size: 40,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '上传图片',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
