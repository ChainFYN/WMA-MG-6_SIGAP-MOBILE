class ReportPhoto {
  final String fileName;
  final String size;
  final String tag;
  final String time;

  ReportPhoto({
    required this.fileName,
    required this.size,
    required this.tag,
    required this.time,
  });
}

class ReportModel {
  final String id;
  final String kecamatan;
  final String desa;
  final String jalanPatokan;
  final String koordinat;
  final String kategori;
  final String tingkatBahaya;
  final String deskripsi;
  final List<ReportPhoto> photos;
  final DateTime createdAt;

  ReportModel({
    required this.id,
    required this.kecamatan,
    required this.desa,
    required this.jalanPatokan,
    required this.koordinat,
    required this.kategori,
    required this.tingkatBahaya,
    required this.deskripsi,
    required this.photos,
    required this.createdAt,
  });
}
