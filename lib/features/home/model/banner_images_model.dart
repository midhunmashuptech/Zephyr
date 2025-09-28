class BannerImagesModel {
  String? type;
  List<Banners>? banners;

  BannerImagesModel({this.type, this.banners});

  BannerImagesModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int? id;
  String? title;
  String? caption;
  String? image;
  Null? url;
  String? status;
  Null? createdAt;
  Null? updatedAt;

  Banners(
      {this.id,
      this.title,
      this.caption,
      this.image,
      this.url,
      this.status,
      this.createdAt,
      this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    caption = json['caption'];
    image = json['image'];
    url = json['url'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['caption'] = this.caption;
    data['image'] = this.image;
    data['url'] = this.url;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
