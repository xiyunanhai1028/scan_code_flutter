import 'dart:convert';

CategoryDto categoryDtoFromJson(String str) => CategoryDto.fromJson(json.decode(str));

String categoryDtoToJson(CategoryDto data) => json.encode(data.toJson());

class CategoryDto {
    int? id;
    String? name;
    int? sort;
    int? type;

    CategoryDto({
        this.id,
        this.name,
        this.sort,
        this.type,
    });

    factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
        id: json["id"],
        name: json["name"],
        sort: json["sort"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sort": sort,
        "type": type,
    };
}
