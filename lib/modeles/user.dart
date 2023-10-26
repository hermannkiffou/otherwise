class User {
  String? id;
  late String name;
  late String email;
  bool? admin = false;
  String? adresse;
  String? avatar;
  String? city;
  String? country;
  late String login;
  late String password;
  String? phone;
  int? redevance;
  int? solde;

  User(
      {this.id,
      required this.name,
      required this.email,
      this.admin,
      this.adresse,
      this.avatar,
      this.city,
      this.country,
      required this.login,
      required this.password,
      this.phone,
      this.redevance,
      this.solde});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    admin = json['admin'];
    adresse = json['adresse'];
    avatar = json['avatar'];
    city = json['city'];
    country = json['country'];
    login = json['login'];
    password = json['password'];
    phone = json['phone'];
    redevance = json['redevance'];
    solde = json['solde'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['admin'] = this.admin;
    data['adresse'] = this.adresse;
    data['avatar'] = this.avatar;
    data['city'] = this.city;
    data['country'] = this.country;
    data['login'] = this.login;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['redevance'] = this.redevance;
    data['solde'] = this.solde;
    return data;
  }
}
