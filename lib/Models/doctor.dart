class Doctor {
  final int? id;
  final String fullName;
  final String email;
  final String specialization;
  final String experience;
  final String password;

  Doctor({
    this.id,
    required this.fullName,
    required this.email,
    required this.specialization,
    required this.experience,
    required this.password,
  });

  // Convert a Doctor into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'specialization': specialization,
      'experience': experience,
      'password': password,
    };
  }

  // Convert a Map into a Doctor
  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      specialization: map['specialization'],
      experience: map['experience'],
      password: map['password'],
    );
  }
}
