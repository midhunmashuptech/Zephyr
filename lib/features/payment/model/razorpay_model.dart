class RazorpayModel {
  String? key;
  bool? isActive;

  RazorpayModel({this.key, this.isActive});

  RazorpayModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['is_active'] = this.isActive;
    return data;
  }
}
