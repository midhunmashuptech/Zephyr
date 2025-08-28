class User {
  int? id;
  String? name;
  String? countryCode;
  String? phone;
  String? secondaryPhone;
  String? email;
  String? gender;
  String? dob;
  String? school;
  String? classStudying;
  int? syllabusId;
  String? address;
  String? district;
  String? state;
  String? country;
  String? pinCode;
  String? image;
  bool? status;
  String? remarks;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.countryCode,
      this.phone,
      this.secondaryPhone,
      this.email,
      this.gender,
      this.dob,
      this.school,
      this.classStudying,
      this.syllabusId,
      this.address,
      this.district,
      this.state,
      this.country,
      this.pinCode,
      this.image,
      this.status,
      this.remarks,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    phone = json['phone'];
    secondaryPhone = json['secondary_phone'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    school = json['school'];
    classStudying = json['class_studying'];
    syllabusId = json['syllabus_id'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    pinCode = json['pin_code'];
    image = json['image'];
    status = json['status'];
    remarks = json['remarks'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['secondary_phone'] = this.secondaryPhone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['school'] = this.school;
    data['class_studying'] = this.classStudying;
    data['syllabus_id'] = this.syllabusId;
    data['address'] = this.address;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pin_code'] = this.pinCode;
    data['image'] = this.image;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
