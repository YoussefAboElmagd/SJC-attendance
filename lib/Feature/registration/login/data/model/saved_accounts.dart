// Model for saved account
class SavedAccount {
  final String email;
  final String password;

  SavedAccount({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  factory SavedAccount.fromJson(Map<String, dynamic> json) {
    return SavedAccount(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
}