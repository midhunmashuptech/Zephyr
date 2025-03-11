class StudyMaterial {
  final String? name;
  final String? chapter;
  final String? upload_date;
  final String? type;

  StudyMaterial({this.name, this.chapter, this.upload_date, this.type});

  static List<StudyMaterial> getSampleFiles() {
    return [
      StudyMaterial(
        name: "Note on Photosynthesis", 
        chapter: "Chapter 1",
        upload_date: "22/10/2024",
        type: "pdf"
      ),
      StudyMaterial(
        name: "Note on Biomolecules", 
        chapter: "Chapter 2",
        upload_date: "22/10/2024",
        type: "pdf"
      ),
      StudyMaterial(
        name: "Diagram 1", 
        chapter: "Chapter 3",
        upload_date: "22/10/2024",
        type: "image"
      ),
      StudyMaterial(
        name: "Note on Pollination", 
        chapter: "Chapter 4",
        upload_date: "22/10/2024",
        type: "pdf"
      ),
    ];
  }
}
