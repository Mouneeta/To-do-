class TODOModel {
  String title;
  bool isCompleted;

  TODOModel({required this.title, required this.isCompleted});

  void toggleCompleted(){
    isCompleted = !isCompleted;
  }

}