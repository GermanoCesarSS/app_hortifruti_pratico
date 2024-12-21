class StoreModel {
  int id;
  String name;
  String imagem;
  bool isOnline;

  StoreModel({
    required this.id,
    required this.name,
    required this.imagem,
    required this.isOnline,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json['id'],
        name: json['nome'],
        imagem: json['logo'] ?? '',
        isOnline: json['online'],
      );
}
