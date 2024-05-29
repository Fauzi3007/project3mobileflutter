class Pelanggan {
  int? idPelanggan;
  late String nomorPelanggan;
  late String namaPelanggan;
  late String alamat;
  late double latitude;
  late double longitude;
  late int lingkupCabang;

  Pelanggan({
    this.idPelanggan,
    required this.nomorPelanggan,
    required this.namaPelanggan,
    required this.alamat,
    required this.latitude,
    required this.longitude,
    required this.lingkupCabang,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      idPelanggan: json['id_pelanggan'],
      nomorPelanggan: json['nomor_pelanggan'],
      namaPelanggan: json['nama_pelanggan'],
      alamat: json['alamat'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      lingkupCabang: json['lingkup_cabang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pelanggan': idPelanggan,
      'nomor_pelanggan': nomorPelanggan,
      'nama_pelanggan': namaPelanggan,
      'alamat': alamat,
      'latitude': latitude,
      'longitude': longitude,
      'lingkup_cabang': lingkupCabang,
    };
  }
}
