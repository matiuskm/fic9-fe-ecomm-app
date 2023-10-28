import 'dart:convert';

class ProductResponseModel {
    final List<Product> data;
    final Meta meta;

    ProductResponseModel({
        required this.data,
        required this.meta,
    });

    factory ProductResponseModel.fromJson(String str) => ProductResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
        meta: Meta.fromMap(json["meta"]),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "meta": meta.toMap(),
    };
}

class Product {
    final int id;
    final PurpleAttributes attributes;

    Product({
        required this.id,
        required this.attributes,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        attributes: PurpleAttributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class PurpleAttributes {
    final String name;
    final String description;
    final String price;
    final int stock;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final Images image;
    final Categories categories;

    PurpleAttributes({
        required this.name,
        required this.description,
        required this.price,
        required this.stock,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.image,
        required this.categories,
    });

    factory PurpleAttributes.fromJson(String str) => PurpleAttributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PurpleAttributes.fromMap(Map<String, dynamic> json) => PurpleAttributes(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        image: Images.fromMap(json["image"]),
        categories: Categories.fromMap(json["categories"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "image": image.toMap(),
        "categories": categories.toMap(),
    };
}

class Categories {
    final List<Category> data;

    Categories({
        required this.data,
    });

    factory Categories.fromJson(String str) => Categories.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        data: List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Category {
    final int id;
    final FluffyAttributes attributes;

    Category({
        required this.id,
        required this.attributes,
    });

    factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        attributes: FluffyAttributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class FluffyAttributes {
    final String name;
    final String description;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;

    FluffyAttributes({
        required this.name,
        required this.description,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
    });

    factory FluffyAttributes.fromJson(String str) => FluffyAttributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FluffyAttributes.fromMap(Map<String, dynamic> json) => FluffyAttributes(
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
    };
}

class Images {
    final List<ImagesDatum> data;

    Images({
        required this.data,
    });

    factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Images.fromMap(Map<String, dynamic> json) => Images(
        data: List<ImagesDatum>.from(json["data"].map((x) => ImagesDatum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class ImagesDatum {
    final int id;
    final TentacledAttributes attributes;

    ImagesDatum({
        required this.id,
        required this.attributes,
    });

    factory ImagesDatum.fromJson(String str) => ImagesDatum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ImagesDatum.fromMap(Map<String, dynamic> json) => ImagesDatum(
        id: json["id"],
        attributes: TentacledAttributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class TentacledAttributes {
    final String name;
    final dynamic alternativeText;
    final dynamic caption;
    final int width;
    final int height;
    final Formats formats;
    final String hash;
    final String ext;
    final String mime;
    final double size;
    final String url;
    final dynamic previewUrl;
    final String provider;
    final dynamic providerMetadata;
    final DateTime createdAt;
    final DateTime updatedAt;

    TentacledAttributes({
        required this.name,
        required this.alternativeText,
        required this.caption,
        required this.width,
        required this.height,
        required this.formats,
        required this.hash,
        required this.ext,
        required this.mime,
        required this.size,
        required this.url,
        required this.previewUrl,
        required this.provider,
        required this.providerMetadata,
        required this.createdAt,
        required this.updatedAt,
    });

    factory TentacledAttributes.fromJson(String str) => TentacledAttributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TentacledAttributes.fromMap(Map<String, dynamic> json) => TentacledAttributes(
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromMap(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"]?.toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toMap(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Formats {
    final Large thumbnail;
    final Large medium;
    final Large small;
    final Large large;

    Formats({
        required this.thumbnail,
        required this.medium,
        required this.small,
        required this.large,
    });

    factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Formats.fromMap(Map<String, dynamic> json) => Formats(
        thumbnail: Large.fromMap(json["thumbnail"]),
        medium: Large.fromMap(json["medium"]),
        small: Large.fromMap(json["small"]),
        large: Large.fromMap(json["large"]),
    );

    Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail.toMap(),
        "medium": medium.toMap(),
        "small": small.toMap(),
        "large": large.toMap(),
    };
}

class Large {
    final String name;
    final String hash;
    final String ext;
    final String mime;
    final dynamic path;
    final int width;
    final int height;
    final double size;
    final String url;

    Large({
        required this.name,
        required this.hash,
        required this.ext,
        required this.mime,
        required this.path,
        required this.width,
        required this.height,
        required this.size,
        required this.url,
    });

    factory Large.fromJson(String str) => Large.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Large.fromMap(Map<String, dynamic> json) => Large(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        path: json["path"],
        width: json["width"],
        height: json["height"],
        size: json["size"]?.toDouble(),
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "path": path,
        "width": width,
        "height": height,
        "size": size,
        "url": url,
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
