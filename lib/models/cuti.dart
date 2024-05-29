class Cuti {
  int? idCuti;
  late int idPegawai;
  late DateTime tanggalMulai;
  late DateTime tanggalSelesai;
  late String keterangan;
  late String status;

  Cuti({
    this.idCuti,
    required this.idPegawai,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.keterangan,
    required this.status,
  });

  factory Cuti.fromJson(Map<String, dynamic> json) {
    return Cuti(
      idCuti: json['id_cuti'],
      idPegawai: json['id_pegawai'],
      tanggalMulai: DateTime.parse(json['tanggal_mulai']),
      tanggalSelesai: DateTime.parse(json['tanggal_selesai']),
      keterangan: json['keterangan'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cuti': idCuti,
      'id_pegawai': idPegawai,
      'tanggal_mulai': tanggalMulai.toIso8601String(),
      'tanggal_selesai': tanggalSelesai.toIso8601String(),
      'keterangan': keterangan,
      'status': status,
    };
  }
}
