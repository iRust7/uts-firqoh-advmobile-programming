class User {
  const User({
    required this.name,
    required this.nis,
    required this.className,
    required this.email,
    required this.program,
    required this.semester,
  });

  final String name;
  final String nis;
  final String className;
  final String email;
  final String program;
  final int semester;
}

/// Dummy hardcoded user that mimics a future data source.
const dummyUser = User(
  name: 'Ariel Hartanto',
  nis: '123456',
  className: 'XII IPA 2',
  email: 'ariel@edulearn.com',
  program: 'Informatika',
  semester: 5,
);
