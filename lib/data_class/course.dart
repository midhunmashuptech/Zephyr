class Course {
  final String? name;
  final String? description;
  final String? image;
  final String? instructor;
  final String? duration;
  final String? level;
  final String? students;
  final List<String>? chapters;
  final String? quizzes;
  final String? price;
  final String? rating;
  final String? reviews;
  final String? discount;

  Course({
    this.name,
    this.description,
    this.image,
    this.instructor,
    this.duration,
    this.level,
    this.students,
    this.chapters,
    this.quizzes,
    this.price,
    this.rating,
    this.reviews,
    this.discount,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      instructor: json['instructor'],
      duration: json['duration'],
      level: json['level'],
      students: json['students'],
      chapters: json['lessons'],
      quizzes: json['quizzes'],
      price: json['price'],
      rating: json['rating'],
      reviews: json['reviews'],
      discount: json['discount'],
    );
  }
}