class PractiseTest {
  final String? name;
  final String? chapter;
  final String? uploadDate;
  final String? dueDate;
  final String? status;

  PractiseTest(
      {this.name, this.chapter, this.uploadDate, this.dueDate, this.status});

  static List<PractiseTest> getSampleTests() {
    return [
      PractiseTest(
          name: "Test on Photosynthesis Test on Photosynthesis",
          chapter: "Chapter 1",
          uploadDate: "22/10/2024",
          dueDate: "22/10/2024",
          status: "Incomplete"),
      PractiseTest(
          name: "Draw Diagram 1",
          chapter: "Chapter 3",
          uploadDate: "22/10/2024",
          dueDate: "22/10/2024",
          status: "Complete"),
    ];
  }
}
