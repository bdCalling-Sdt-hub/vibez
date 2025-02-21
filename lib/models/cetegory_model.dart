// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String? id;
  final String? name;
  final String? image;
  final List<Filter>? filters;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.filters,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"]!.map((x) => Filter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "filters": filters == null ? [] : List<dynamic>.from(filters!.map((x) => x.toJson())),
  };
}

class Filter {
  final String? id;
  final String? name;
  final List<Subfilter>? subfilters;

  Filter({
    this.id,
    this.name,
    this.subfilters,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    id: json["_id"],
    name: json["name"],
    subfilters: json["subfilters"] == null ? [] : List<Subfilter>.from(json["subfilters"]!.map((x) => Subfilter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "subfilters": subfilters == null ? [] : List<dynamic>.from(subfilters!.map((x) => x.toJson())),
  };
}

class Subfilter {
  final String? id;
  final String? value;

  Subfilter({
    this.id,
    this.value,
  });

  factory Subfilter.fromJson(Map<String, dynamic> json) => Subfilter(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}
