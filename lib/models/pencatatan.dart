class Pencatatan {
  int? idPencatatan;
  late int idPelanggan;
  late int meteranLama;
  late int meteranBaru;
  late DateTime tanggal;
  late String fotoMeteran;
  late int idPegawai;

  Pencatatan({
    this.idPencatatan,
    required this.idPelanggan,
    required this.meteranLama,
    required this.meteranBaru,
    required this.tanggal,
    required this.fotoMeteran,
    required this.idPegawai,
  });

  factory Pencatatan.fromJson(Map<String, dynamic> json) {
    return Pencatatan(
      idPencatatan: json['id_pencatatan'],
      idPelanggan: json['id_pelanggan'],
      meteranLama: json['meteran_lama'],
      meteranBaru: json['meteran_baru'],
      tanggal: DateTime.parse(json['tanggal']),
      fotoMeteran: json['foto_meteran'],
      idPegawai: json['id_pegawai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pencatatan': idPencatatan,
      'id_pelanggan': idPelanggan,
      'meteran_lama': meteranLama,
      'meteran_baru': meteranBaru,
      'tanggal': tanggal.toIso8601String(),
      'foto_meteran': fotoMeteran,
      'id_pegawai': idPegawai,
    };
  }
}
