class PractiseTest {
  final String? name;
  final String? chapter;
  final String? upload_date;
  final String? due_date;
  final String? status;

  PractiseTest({this.name, this.chapter, this.upload_date, this.due_date, this.status});

  static List<PractiseTest> getSampleTests() {
    return [
      PractiseTest(
          name: "Test on Photosynthesis",
          chapter: "Chapter 1",
          upload_date: "22/10/2024",
          due_date: "22/10/2024",
          status: "Incomplete"),
      PractiseTest(
          name: "Draw Diagram 1",
          chapter: "Chapter 3",
          upload_date: "22/10/2024",
          due_date: "22/10/2024",
          status: "Complete"),
    ];
  }
}
