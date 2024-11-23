class User {
  final String id;
  final String firstName;
  final String lastName;
  final String? otherName;

  final String email;
  final String profileUrl;
  final String universityID;
  final String facultyID;
  final String departmentID;
  final String levelID;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      this.otherName,
      required this.email,
      required this.profileUrl,
      required this.universityID,
      required this.facultyID,
      required this.departmentID,
      required this.levelID});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "other_name": otherName,
      "email": email,
      "profile_url": profileUrl,
      "university_id": universityID,
      "faculty_id": facultyID,
      "department_id": departmentID,
      "level_id": levelID,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      otherName:
          json['other_name']?.isEmpty ?? true ? null : json['other_name'],
      profileUrl: json['profile_url'] ?? '',
      universityID: json['university_id'] ?? '',
      facultyID: json['faculty_id'] ?? '',
      departmentID: json['department_id'] ?? '',
      levelID: json['level_id'] ?? '',
    );
  }

  static User emptyUser() {
    return User(
      id: "",
      firstName: "",
      lastName: "",
      email: "",
      profileUrl: "",
      universityID: "",
      facultyID: "",
      departmentID: "",
      levelID: "",
    );
  }
}

class Course {
  final String id;
  final String name;

// `json:"course_code"`
  final String courseCode;
// `json:"level_id"`
  final String levelID;
  // `json:"department_id"`
  final String departmentID;
  Course(
      {required this.id,
      required this.name,
      required this.courseCode,
      required this.departmentID,
      required this.levelID});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "course_code": courseCode,
      "department_id": departmentID,
      "level_id": levelID,
    };
  }

  static Course fromJson(Map<String, dynamic> json) {
    return Course(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      courseCode: json["course_code"] ?? "",
      departmentID: json["department_id"] ?? "",
      levelID: json["level_id"] ?? "",
    );
  }

  static List<Course> jsonToList(List<dynamic> json) {
    final courses = <Course>[];
    for (final course in json) {
      courses.add(fromJson(course));
    }
    return courses;
  }
}

class Material {
  final String id;
  final String name;

  final String courseID;
  final String cloudURL;
  Material({
    required this.id,
    required this.name,
    required this.courseID,
    required this.cloudURL,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "course_id": courseID,
      "cloud_ur;": cloudURL,
    };
  }

  static Material fromJson(Map<String, dynamic> json) {
    return Material(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      cloudURL: json["cloud_url"] ?? "",
      courseID: json["course_id"] ?? "",
    );
  }

  static List<Material> jsonToList(List<dynamic> json) {
    final materials = <Material>[];
    for (final material in json) {
      materials.add(fromJson(material));
    }
    return materials;
  }
}
