import 'dart:convert';

class OrderDetailResponseModel {
  final List<Datum> data;
  final Meta meta;

  OrderDetailResponseModel({
    required this.data,
    required this.meta,
  });

  factory OrderDetailResponseModel.fromRawJson(String str) =>
      OrderDetailResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponseModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  final int id;
  final Attributes attributes;

  Datum({
    required this.id,
    required this.attributes,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  final List<Item> items;
  final int total;
  final String shippingAddress;
  final String shippingCourier;
  final int shippingFee;
  final String status;
  final String orderNumber;
  dynamic paymentRef;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;

  Attributes({
    required this.items,
    required this.total,
    required this.shippingAddress,
    required this.shippingCourier,
    required this.shippingFee,
    required this.status,
    required this.orderNumber,
    this.paymentRef,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
        shippingAddress: json["shipping_address"],
        shippingCourier: json["shipping_courier"],
        shippingFee: json["shipping_fee"],
        status: json["status"],
        orderNumber: json["order_number"],
        paymentRef: json["payment_ref"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        publishedAt: json["publishedAt"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
        "shipping_address": shippingAddress,
        "shipping_courier": shippingCourier,
        "shipping_fee": shippingFee,
        "status": status,
        "order_number": orderNumber,
        "payment_ref": paymentRef,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "publishedAt": publishedAt,
      };
}

class Item {
  final int id;
  final String productName;
  final int price;
  final int qty;

  Item({
    required this.id,
    required this.productName,
    required this.price,
    required this.qty,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "price": price,
        "qty": qty,
      };
}

class Meta {
  final Pagination pagination;

  Meta({
    required this.pagination,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  final int page;
  final int pageSize;
  final int pageCount;
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
      };
}
