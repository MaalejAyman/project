class User {
  int Id;
  String Login;
  String? Password;
  String Nom;
  String Prenom;
  int? Id_Chef;
  int Nb_conge_rest;

  User(this.Id, this.Login, this.Password, this.Nom, this.Prenom, this.Id_Chef,
      this.Nb_conge_rest);

  @override
  String toString() {
    return 'user{Nom: $Nom, Prenom: $Prenom}';
  }

  //from Json to User
  User.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Login = json['Login'],
        Password = json['Password'],
        Nom = json['Nom'],
        Prenom = json['Prenom'],
        Id_Chef = json['Id_Chef'],
        Nb_conge_rest = json['Nb_conge_rest'];

  //from User to Json
  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Login': Login,
      };
}
