class DisasterGuideModel {
  final String mainTopic;
  final String subTopic;
  final List<Map<String, dynamic>> whatTodo;
  bool showSubTopic;

  DisasterGuideModel({
    required this.mainTopic,
    required this.subTopic,
    required this.whatTodo,
    this.showSubTopic = false,
  });
}
