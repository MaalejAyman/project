class Conge{
  int Id;
  int Id_User;
  String Raison;
  DateTime? Date_Debut;
  DateTime? Date_Fin;
  int IsConfirmed;

  Conge(this.Id, this.Id_User, this.Raison, this.Date_Debut, this.Date_Fin,
      this.IsConfirmed);
  //from Json to Conge
  Conge.fromJson(Map<String, dynamic> json)
      : Id = json['Id'],
        Id_User = json['Id_User'],
        Raison = json['Raison'],
        Date_Debut = DateTime.parse(json['DateDebut'].toString()),
        Date_Fin = DateTime.parse(json['DateFin'].toString()),
        IsConfirmed = json['IsConfirmed']
  ;
  //from Conge to Json
  Map<String, dynamic> toJson() => {
    'Id': Id,
    'Id_User': Id_User,
    'Raison': Raison,
    'DateDebut': Date_Debut,
    'DateFin': Date_Fin,
    'IsConfirmed': IsConfirmed
  };

  @override
  String toString() {
    return 'Conge{Id: $Id, Id_User: $Id_User, Raison: $Raison, Date_Debut: $Date_Debut, Date_Fin: $Date_Fin, IsConfirmed: $IsConfirmed}';
  }
}