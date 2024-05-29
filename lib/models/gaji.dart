class Gaji {
  int? idGaji;
  late int idPegawai;
  late double gajiPokok;
  late double tunjanganJabatan;
  late double tunjanganAnak;
  late double tunjanganNikah;
  late double potongan;
  late double pajak;
  late double totalGaji;
  late DateTime tanggal;

  Gaji({
    this.idGaji,
    required this.idPegawai,
    required this.gajiPokok,
    required this.tunjanganJabatan,
    required this.tunjanganAnak,
    required this.tunjanganNikah,
    required this.potongan,
    required this.pajak,
    required this.totalGaji,
    required this.tanggal,
  });

  factory Gaji.fromJson(Map<String, dynamic> json) {
    return Gaji(
      idGaji: json['id_gaji'],
      idPegawai: json['id_pegawai'],
      gajiPokok: json['gaji_pokok'],
      tunjanganJabatan: json['tunjangan_jabatan'],
      tunjanganAnak: json['tunjangan_anak'],
      tunjanganNikah: json['tunjangan_nikah'],
      potongan: json['potongan'],
      pajak: json['pajak'],
      totalGaji: json['total_gaji'],
      tanggal: DateTime.parse(json['tanggal']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_gaji': idGaji,
      'id_pegawai': idPegawai,
      'gaji_pokok': gajiPokok,
      'tunjangan_jabatan': tunjanganJabatan,
      'tunjangan_anak': tunjanganAnak,
      'tunjangan_nikah': tunjanganNikah,
      'potongan': potongan,
      'pajak': pajak,
      'total_gaji': totalGaji,
      'tanggal': tanggal.toIso8601String(),
    };
  }
}
