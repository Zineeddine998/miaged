// activite.dart


class Activite {
  final String id; 
  final String titre;
  final String lieu;
  final int prix;
  final String imageURL;
  final String categorie;
  final int nombreMinimumPersonnes;

  Activite(this.id, this.titre, this.lieu, this.prix, this.imageURL, this.categorie, this.nombreMinimumPersonnes);
}
