class Student {
  final String id;
  String name;
  String program;
  List<String> courses;
  Map<String, double> grades;

  Student({
    required this.id,
    required this.name,
    required this.program,
    this.courses = const [],
    this.grades = const {},
  });

  double get gpa {
    if (grades.isEmpty) return 0.0;

    double total = 0.0;
    for (var grade in grades.values) {
      if (grade >= 85)
        total += 4.0;
      else if (grade >= 75)
        total += 3.0;
      else if (grade >= 65)
        total += 2.0;
      else if (grade >= 50)
        total += 1.0;
      else
        total += 0.0;
    }

    return total / grades.length;
  }
}

class ActiveStudent extends Student {
  ActiveStudent({
    required String id,
    required String name,
    required String program,
  }) : super(id: id, name: name, program: program);
}

class GraduatedStudent extends Student {
  GraduatedStudent({
    required String id,
    required String name,
    required String program,
  }) : super(id: id, name: name, program: program);
}
