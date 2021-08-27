class DiverSys{
  int Id;
  String Titre;
  DiverSys(this.Id, this.Titre);
  DiverSys.fromJson(Map<String, dynamic> json):
        Id = json['DiverSys_Id'],
        Titre = json['DiverSys_Titre'];

  @override
  String toString() {
    return '$Titre';
  }
}