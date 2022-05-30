// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.date,
    required this.dataHeaders,
    required this.data,
  });

  late DateTime date;
  late List<DataHeader> dataHeaders;
  late List<Datum> data;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        date: DateTime.parse(json["date"]),
        dataHeaders: List<DataHeader>.from(
            json["dataHeaders"].map((x) => DataHeader.fromJson(x))),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "dataHeaders": List<dynamic>.from(dataHeaders.map((x) => x.toJson())),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.vegetableName,
    required this.price,
    required this.units,
    required this.id,
    required this.shopingMallPrice,
    required this.retailPrice,
    required this.table,
  });

  late String vegetableName;
  late String price;
  late Units? units;
  late String id;
  late String shopingMallPrice;
  late String retailPrice;
  late Table table;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        vegetableName: json["vegetableName"],
        price: json["price"],
        units: unitsValues.map[json["units"]],
        id: json["id"],
        shopingMallPrice: json["shopingMallPrice"],
        retailPrice: json["retailPrice"],
        table: Table.fromJson(json["table"]),
      );

  Map<String, dynamic> toJson() => {
        "vegetableName": vegetableName,
        "price": price,
        "units": unitsValues.reverse[units],
        "id": id,
        "shopingMallPrice": shopingMallPrice,
        "retailPrice": retailPrice,
        "table": table.toJson(),
      };
}

class Table {
  Table({
    required this.imageUrl,
    required this.imageSize,
    required this.heightRatio,
  });

  String imageUrl;
  double imageSize;
  double heightRatio;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        imageUrl: json["imageUrl"],
        imageSize: json["imageSize"].toDouble(),
        heightRatio: json["heightRatio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": "https://vegetablemarketprice.com/" + imageUrl,
        "imageSize": imageSize,
        "heightRatio": heightRatio,
      };
}

enum Units { THE_1_KG }

final unitsValues = EnumValues({"1kg": Units.THE_1_KG});

class DataHeader {
  DataHeader({
    required this.name,
    required this.value,
    required this.type,
  });

  late String name;
  late String value;
  late String? type;

  factory DataHeader.fromJson(Map<String, dynamic> json) => DataHeader(
        name: json["name"],
        value: json["value"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "type": type == null ? null : type,
      };
}

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
