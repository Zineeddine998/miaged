// panier_manager.dart

import 'Panier.dart';

class PanierManager {
  static final List<PanierItem> _panier = [];

  List<PanierItem> get panier => _panier;

  // Ajouter un élément au panier
  static void ajouterAuPanier(PanierItem item) {
    _panier.add(item);
  }

  // Retirer un élément du panier
  static List<PanierItem> retirerDuPanier(PanierItem item) {
    _panier.remove(item);
    return _panier;
  }

  // Calculer le total du panier
  static double calculerTotalPanier() {
    if(_panier.isEmpty) return 0;
    return _panier.fold(0.0, (total, item) => total + double.parse(item.activite.prix.toString()));
  }
}
