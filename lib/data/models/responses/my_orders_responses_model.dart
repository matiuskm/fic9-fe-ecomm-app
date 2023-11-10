import 'dart:convert';

class MyOrdersResponseModel {
    final List<MyOrder> data;
    final Meta meta;

    MyOrdersResponseModel({
        required this.data,
        required this.meta,
    });

    factory MyOrdersResponseModel.fromJson(String str) => MyOrdersResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MyOrdersResponseModel.fromMap(Map<String, dynamic> json) => MyOrdersResponseModel(
        data: List<MyOrder>.from(json["data"].map((x) => MyOrder.fromMap(x))),
        meta: Meta.fromMap(json["meta"]),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "meta": meta.toMap(),
    };
}

class MyOrder {
    final int id;
    final Attributes attributes;

    MyOrder({
        required this.id,
        required this.attributes,
    });

    factory MyOrder.fromJson(String str) => MyOrder.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory MyOrder.fromMap(Map<String, dynamic> json) => MyOrder(
        id: json["id"],
        attributes: Attributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
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
    final String paymentRef;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final String userId;
    final String shippingReceiver;
    final String awb;

    Attributes({
        required this.items,
        required this.total,
        required this.shippingAddress,
        required this.shippingCourier,
        required this.shippingFee,
        required this.status,
        required this.orderNumber,
        required this.paymentRef,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.userId,
        required this.shippingReceiver,
        required this.awb,
    });

    factory Attributes.fromJson(String str) => Attributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Attributes.fromMap(Map<String, dynamic> json) => Attributes(
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        total: json["total"],
        shippingAddress: json["shipping_address"],
        shippingCourier: json["shipping_courier"],
        shippingFee: json["shipping_fee"],
        status: json["status"],
        orderNumber: json["order_number"],
        paymentRef: json["payment_ref"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        userId: json["user_id"],
        shippingReceiver: json["shipping_receiver"],
        awb: json["awb"] ?? '',
    );

    Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "total": total,
        "shipping_address": shippingAddress,
        "shipping_courier": shippingCourier,
        "shipping_fee": shippingFee,
        "status": status,
        "order_number": orderNumber,
        "payment_ref": paymentRef,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "user_id": userId,
        "shipping_receiver": shippingReceiver,
        "awb": awb,
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

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["product_name"],
        price: json["price"],
        qty: json["qty"],
    );

    Map<String, dynamic> toMap() => {
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

    factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromMap(json["pagination"]),
    );

    Map<String, dynamic> toMap() => {
        "pagination": pagination.toMap(),
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

    factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
    };
}
