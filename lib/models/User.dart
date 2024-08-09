class User {
  final String name;
  final String surname;
  final String username;
  final String email;
  final String dateOfBirth;
  final String occasion;
  final int monthlyExpenseLimit;
  final int monthlyIncome;

  User(
      {required this.name,
      required this.surname,
      required this.username,
      required this.email,
      required this.dateOfBirth,
      required this.occasion,
      required this.monthlyExpenseLimit,
      required this.monthlyIncome});

  factory User.fromJson(Map<String, dynamic> json) {
    return

        // User(
        //   name: json['name'],
        //   surname: json['surname'],
        //   username: json['username'],
        //   email: json['email'],
        //   dateOfBirth: DateTime.parse(json['dateOfBirth']),
        //   occasion: json['occasion'],
        //   monthlyExpenseLimit: json['monthlyExpenseLimit'].toDouble(),
        //   monthlyIncome: json['monthlyIncome'].toDouble(),
        // );

        User(
            name: 'XXX',
            surname: 'Kıran',
            username: 'egekiran',
            email: 'ege.kiran@gmail.com',
            dateOfBirth: '08.04.2001',
            occasion: 'Öğrenci',
            monthlyExpenseLimit: 10000,
            monthlyIncome: 5000);
  }
}
