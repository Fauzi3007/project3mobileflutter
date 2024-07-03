class Pegawai {
  int? idPegawai;
  String namaLengkap;
  String jenisKelamin;
  String tglLahir;
  String telepon;
  String alamat;
  String statusNikah;
  int jumlahAnak;
  int kantorCabang;
  int jabatan;
  double gajiPokok;
  String foto;
  int idUser;

  Pegawai({
    this.idPegawai,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.tglLahir,
    required this.telepon,
    required this.alamat,
    required this.statusNikah,
    required this.jumlahAnak,
    required this.kantorCabang,
    required this.jabatan,
    required this.gajiPokok,
    required this.foto,
    required this.idUser,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'],
      namaLengkap: json['nama_lengkap'],
      jenisKelamin: json['jenis_kelamin'],
      tglLahir: json['tgl_lahir'],
      telepon: json['telepon'],
      alamat: json['alamat'],
      statusNikah: json['status_nikah'],
      jumlahAnak: json['jumlah_anak'],
      kantorCabang: json['kantor_cabang'],
      jabatan: json['jabatan'],
      gajiPokok: json['gaji_pokok'],
      foto: json['foto'],
      idUser: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pegawai': idPegawai,
      'nama_lengkap': namaLengkap,
      'jenis_kelamin': jenisKelamin,
      'tgl_lahir': tglLahir,
      'telepon': telepon,
      'alamat': alamat,
      'status_nikah': statusNikah,
      'jumlah_anak': jumlahAnak,
      'kantor_cabang': kantorCabang,
      'jabatan': jabatan,
      'gaji_pokok': gajiPokok,
      'foto': foto,
      'id_user': idUser,
    };
  }
}
