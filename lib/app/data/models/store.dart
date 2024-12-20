class StoreModel {
  int id;
  String nome;
  String logo;
  bool online;

  StoreModel({
    required this.id,
    required this.nome,
    required this.logo,
    required this.online,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json['id'],
        nome: json['nome'],
        logo: json['logo'] ?? '', 
        online: (json['online'] == 1),
      );
}
