// // class LiveClassModal {
// //   String? type;
// //   LiveClasses? liveClasses;
// //   String? message;

// //   LiveClassModal({this.type, this.liveClasses, this.message});

// //   LiveClassModal.fromJson(Map<String, dynamic> json) {
// //     type = json['type'];
// //     liveClasses = json['data'] != null
// //         ? new LiveClasses.fromJson(json['data'])
// //         : null;
// //     message = json['message'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['type'] = this.type;
// //     if (this.liveClasses != null) {
// //       data['data'] = this.liveClasses!.toJson();
// //     }
// //     data['message'] = this.message;
// //     return data;
// //   }
// // }

// // class LiveClasses {
// //   List<Ongoing>? ongoing;
// //   List<Upcoming>? upcoming;
// //   List<Completed>? completed;

// //   LiveClasses({this.ongoing, this.upcoming, this.completed});

// //   LiveClasses.fromJson(Map<String, dynamic> json) {
// //     if (json['ongoing'] != null) {
// //       ongoing = <Ongoing>[];
// //       json['ongoing'].forEach((v) {
// //         ongoing!.add(new Ongoing.fromJson(v));
// //       });
// //     }
// //     if (json['upcoming'] != null) {
// //       upcoming = <Upcoming>[];
// //       json['upcoming'].forEach((v) {
// //         upcoming!.add(new Upcoming.fromJson(v));
// //       });
// //     }
// //     if (json['completed'] != null) {
// //       completed = <Completed>[];
// //       json['completed'].forEach((v) {
// //         completed!.add(new Completed.fromJson(v));
// //       });
// //     }
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     if (this.ongoing != null) {
// //       data['ongoing'] = this.ongoing!.map((v) => v.toJson()).toList();
// //     }
// //     if (this.upcoming != null) {
// //       data['upcoming'] = this.upcoming!.map((v) => v.toJson()).toList();
// //     }
// //     if (this.completed != null) {
// //       data['completed'] = this.completed!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }

// // class Ongoing {
// //   String? id;
// //   String? title;
// //   String? start;
// //   String? end;
// //   String? faculty;
// //   String? avatar;
// //   String? alias;
// //   String? hls;
// //   String? url;
// //   String? source;

// //   Ongoing(
// //       {this.id,
// //       this.title,
// //       this.start,
// //       this.end,
// //       this.faculty,
// //       this.avatar,
// //       this.alias,
// //       this.hls,
// //       this.url,
// //       this.source});

// //   Ongoing.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     title = json['title'];
// //     start = json['start'];
// //     end = json['end'];
// //     faculty = json['faculty'];
// //     avatar = json['avatar'];
// //     alias = json['alias'];
// //     hls = json['hls'];
// //     url = json['url'];
// //     source = json['source'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['title'] = this.title;
// //     data['start'] = this.start;
// //     data['end'] = this.end;
// //     data['faculty'] = this.faculty;
// //     data['avatar'] = this.avatar;
// //     data['alias'] = this.alias;
// //     data['hls'] = this.hls;
// //     data['url'] = this.url;
// //     data['source'] = this.source;
// //     return data;
// //   }
// // }

// // class Completed {
// //   String? name;
// //   List<Months>? months;

// //   Completed({this.name, this.months});

// //   Completed.fromJson(Map<String, dynamic> json) {
// //     name = json['name'];
// //     if (json['months'] != null) {
// //       months = <Months>[];
// //       json['months'].forEach((v) {
// //         months!.add(new Months.fromJson(v));
// //       });
// //     }
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['name'] = this.name;
// //     if (this.months != null) {
// //       data['months'] = this.months!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }

// // class Months {
// //   String? name;
// //   List<Data>? data;

// //   Months({this.name, this.data});

// //   Months.fromJson(Map<String, dynamic> json) {
// //     name = json['name'];
// //     if (json['data'] != null) {
// //       data = <Data>[];
// //       json['data'].forEach((v) {
// //         data!.add(new Data.fromJson(v));
// //       });
// //     }
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['name'] = this.name;
// //     if (this.data != null) {
// //       data['data'] = this.data!.map((v) => v.toJson()).toList();
// //     }
// //     return data;
// //   }
// // }

// // class Data {
// //   String? id;
// //   String? title;
// //   String? start;
// //   String? end;
// //   String? faculty;
// //   String? avatar;
// //   String? alias;
// //   String? hls;
// //   String? url;
// //   String? source;

// //   Data(
// //       {this.id,
// //       this.title,
// //       this.start,
// //       this.end,
// //       this.faculty,
// //       this.avatar,
// //       this.alias,
// //       this.hls,
// //       this.url,
// //       this.source});

// //   Data.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     title = json['title'];
// //     start = json['start'];
// //     end = json['end'];
// //     faculty = json['faculty'];
// //     avatar = json['avatar'];
// //     alias = json['alias'];
// //     hls = json['hls'];
// //     url = json['url'];
// //     source = json['source'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['id'] = this.id;
// //     data['title'] = this.title;
// //     data['start'] = this.start;
// //     data['end'] = this.end;
// //     data['faculty'] = this.faculty;
// //     data['avatar'] = this.avatar;
// //     data['alias'] = this.alias;
// //     data['hls'] = this.hls;
// //     data['url'] = this.url;
// //     data['source'] = this.source;
// //     return data;
// //   }
// // }









// import 'package:flutter/material.dart';
// import 'package:zephyr/features/test_series/widgets/weekly_test_card.dart';

// class Testetutor extends StatefulWidget {
//   const Testetutor({super.key});

//   @override
//   State<Testetutor> createState() => _TestetutorState();
// }

// class _TestetutorState extends State<Testetutor> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SafeArea(child: 
//       Column(
//         children: [
//           WeeklyTestCard(),
//           SizedBox(height: 20,),
//           WeeklyTestCard(),

//         ],
//       )
//       ),
//     );
//   }
// }