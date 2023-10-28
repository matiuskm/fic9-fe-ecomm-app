import 'dart:convert';

class BannerResponseModel {
    final List<Banner> data;
    final Meta meta;

    BannerResponseModel({
        required this.data,
        required this.meta,
    });

    factory BannerResponseModel.fromJson(String str) => BannerResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BannerResponseModel.fromMap(Map<String, dynamic> json) => BannerResponseModel(
        data: List<Banner>.from(json["data"].map((x) => Banner.fromMap(x))),
        meta: Meta.fromMap(json["meta"]),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "meta": meta.toMap(),
    };
}

class Banner {
    final int id;
    final BannerAttributes attributes;

    Banner({
        required this.id,
        required this.attributes,
    });

    factory Banner.fromJson(String str) => Banner.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        id: json["id"],
        attributes: BannerAttributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class BannerAttributes {
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final Gambar gambar;

    BannerAttributes({
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.gambar,
    });

    factory BannerAttributes.fromJson(String str) => BannerAttributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BannerAttributes.fromMap(Map<String, dynamic> json) => BannerAttributes(
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        gambar: Gambar.fromMap(json["gambar"]),
    );

    Map<String, dynamic> toMap() => {
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "gambar": gambar.toMap(),
    };
}

class Gambar {
    final Data data;

    Gambar({
        required this.data,
    });

    factory Gambar.fromJson(String str) => Gambar.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Gambar.fromMap(Map<String, dynamic> json) => Gambar(
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data.toMap(),
    };
}

class Data {
    final int id;
    final DataAttributes attributes;

    Data({
        required this.id,
        required this.attributes,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        attributes: DataAttributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class DataAttributes {
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

    DataAttributes({
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

    factory DataAttributes.fromJson(String str) => DataAttributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DataAttributes.fromMap(Map<String, dynamic> json) => DataAttributes(
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
    final Small thumbnail;
    final Small small;

    Formats({
        required this.thumbnail,
        required this.small,
    });

    factory Formats.fromJson(String str) => Formats.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Formats.fromMap(Map<String, dynamic> json) => Formats(
        thumbnail: Small.fromMap(json["thumbnail"]),
        small: Small.fromMap(json["small"]),
    );

    Map<String, dynamic> toMap() => {
        "thumbnail": thumbnail.toMap(),
        "small": small.toMap(),
    };
}

class Small {
    final String name;
    final String hash;
    final String ext;
    final String mime;
    final dynamic path;
    final int width;
    final int height;
    final double size;
    final String url;

    Small({
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

    factory Small.fromJson(String str) => Small.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Small.fromMap(Map<String, dynamic> json) => Small(
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
