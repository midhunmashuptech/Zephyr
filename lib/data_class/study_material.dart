class StudyMaterial {
  final String? name;
  final String? chapter;
  final String? uploadDate;
  final String? type;

  StudyMaterial({this.name, this.chapter, this.uploadDate, this.type});

  static List<StudyMaterial> getSampleFiles() {
    return [
      StudyMaterial(
          name: "Note on Photosynthesis Note on Photosynthesis",
          chapter: "Chapter 1",
          uploadDate: "22/10/2024",
          type: "pdf"),
      StudyMaterial(
          name: "Note on Biomolecules",
          chapter: "Chapter 2",
          uploadDate: "22/10/2024",
          type: "pdf"),
      StudyMaterial(
          name: "Diagram 1",
          chapter: "Chapter 3",
          uploadDate: "22/10/2024",
          type: "image"),
      StudyMaterial(
          name: "Note on Pollination",
          chapter: "Chapter 4",
          uploadDate: "22/10/2024",
          type: "pdf"),
    ];
  }
}
