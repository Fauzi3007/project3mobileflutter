class Absensi {
  int? idAbsensi;
  late DateTime tanggal;
  late DateTime waktuMasuk;
  late DateTime waktuKeluar;
  late String status;
  late String keterangan;
  late int idPegawai;

  Absensi({
    this.idAbsensi,
    required this.tanggal,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.status,
    required this.keterangan,
    required this.idPegawai,
  });

  factory Absensi.fromJson(Map<String, dynamic> json) {
    return Absensi(
      idAbsensi: json['id_absensi'],
      tanggal: DateTime.parse(json['tanggal']),
      waktuMasuk: DateTime.parse(json['waktu_masuk']),
      waktuKeluar: DateTime.parse(json['waktu_keluar']),
      status: json['status'],
      keterangan: json['keterangan'],
      idPegawai: json['id_pegawai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_absensi': idAbsensi,
      'tanggal': tanggal.toIso8601String(),
      'waktu_masuk': waktuMasuk.toIso8601String(),
      'waktu_keluar': waktuKeluar.toIso8601String(),
      'status': status,
      'keterangan': keterangan,
      'id_pegawai': idPegawai,
    };
  }
}
