class Course {
  final String? name;
  final String? description;
  final String? image;
  final String? instructor;
  final String? duration;
  final String? level;
  final String? students;
  final List<String>? chapters;
  final String? video_count;
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
    this.video_count,
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
      video_count: json['video_count'],
      quizzes: json['quizzes'],
      price: json['price'],
      rating: json['rating'],
      reviews: json['reviews'],
      discount: json['discount'],
    );
  }

  @override
  String toString() {
    return 'Course(name: $name, description: $description, image: $image, instructor: $instructor, duration: $duration, level: $level, students: $students, chapters: $chapters, quizzes: $quizzes, price: $price, rating: $rating, reviews: $reviews, discount: $discount)';
  }

  static List<Course> getSampleCourses() {
    return [
      Course(
        name: 'Flutter Development',
        description: 'Learn Flutter Development from scratch',
        image: 'assets/images/course_bg1.jpg',
        instructor: 'John Doe',
        duration: '2 months',
        level: 'Beginner',
        students: '1000',
        chapters: [
          'Introduction',
          'Widgets',
          'State Management',
          'API Integration'
        ],
        video_count: '40',
        quizzes: '10',
        price: '100',
        rating: '4.5',
        reviews: '100',
        discount: '20',
      ),
      Course(
        name: 'Dart Programming',
        description: 'Learn Dart Programming from scratch',
        image: 'assets/images/course_bg2.jpg',
        instructor: 'Jane Doe',
        duration: '1 month',
        level: 'Beginner',
        students: '500',
        chapters: ['Introduction', 'Variables', 'Functions', 'Classes'],
        video_count: '21',
        quizzes: '5',
        price: '50',
        rating: '4.0',
        reviews: '50',
        discount: '10',
      ),
      Course(
        name: 'Firebase Integration',
        description: 'Learn Firebase Integration with Flutter',
        image: 'assets/images/course_bg3.jpg',
        instructor: 'John Doe',
        duration: '1 month',
        level: 'Intermediate',
        students: '750',
        chapters: ['Introduction', 'Authentication', 'Firestore', 'Storage'],
        video_count: '32',
        quizzes: '7',
        price: '75',
        rating: '4.2',
        reviews: '75',
        discount: '15',
      ),
      Course(
        name: 'Flutter UI Design Flutter UI Design',
        description: 'Learn Flutter UI Design from scratch',
        image: 'assets/images/course_bg4.jpg',
        instructor: 'Jane Doe',
        duration: '1 month',
        level: 'Intermediate',
        students: '800',
        chapters: ['Introduction', 'Widgets', 'Layouts', 'Animations'],
        video_count: '44',
        quizzes: '8',
        price: '80',
        rating: '4.3',
        reviews: '80',
        discount: '18',
      ),
    ];
  }
}
