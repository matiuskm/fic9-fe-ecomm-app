import 'dart:convert';

class OrderRequestModel {
    final Data data;

    OrderRequestModel({
        required this.data,
    });

    factory OrderRequestModel.fromRawJson(String str) => OrderRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderRequestModel.fromJson(Map<String, dynamic> json) => OrderRequestModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    final List<Item> items;
    final int total;
    final String shippingAddress;
    final String shippingCourier;
    final int shippingFee;
    final String status;
    final String orderNumber;

    Data({
        required this.items,
        required this.total,
        required this.shippingAddress,
        required this.shippingCourier,
        required this.shippingFee,
        required this.status,
        required this.orderNumber,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        total: json["total"],
        shippingAddress: json["shipping_address"],
        shippingCourier: json["shipping_courier"],
        shippingFee: json["shipping_fee"],
        status: json["status"],
        orderNumber: json["order_number"],
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total": total,
        "shipping_address": shippingAddress,
        "shipping_courier": shippingCourier,
        "shipping_fee": shippingFee,
        "status": status,
        "order_number": orderNumber,
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