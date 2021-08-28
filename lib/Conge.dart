class Conge{
  int Id;
  int? Id_User;
  String? Raison;
  DateTime? Date_Debut;
  DateTime? Date_Fin;
  int? Nature;
  int? IsConfirmed;
  int? NbreJour;

  Conge(this.Id, this.Id_User, this.Raison, this.Date_Debut, this.Date_Fin,
      this.IsConfirmed);
  //from Json to Conge
  Conge.fromJson(Map<String, dynamic> json)
      : Id = json['Conge_Id'],
        Nature= json['Conge_Nature'],
        Id_User = int.parse(json['Perso_Matricule']),
        Raison = json['Conge_Commentaire'],
        Date_Debut = DateTime.parse(json['Conge_DateDebut'].toString()),
        Date_Fin = DateTime.parse(json['Conge_DateFin'].toString()),
        IsConfirmed = json['Conge_Etat'],
        NbreJour = json['Conge_NbrJour']
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