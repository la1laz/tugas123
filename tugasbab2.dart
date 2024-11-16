enum Kategori { DataManagement, NetworkAutomation }

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

mixin Kinerja {
  int produktivitas = 100; //

  void updateProduktivitas() {
    if (produktivitas < 100) {
      produktivitas += 10;
    }
    if (produktivitas > 100) {
      produktivitas = 100;
    }
  }

  void cekProduktivitas() {
    print('Produktivitas: $produktivitas');
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, this.umur, this.peran);

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, int umur, String peran) : super(nama, umur, peran);

  @override
  void bekerja() {
    print('$nama yang berperan sebagai $peran bekerja dengan jam reguler.');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, int umur, String peran)
      : super(nama, umur, peran);

  @override
  void bekerja() {
    print('$nama yang berperan sebagai $peran bekerja pada proyek spesifik.');
  }
}

class Manager extends Karyawan with Kinerja {
  Manager(String nama, int umur, String peran) : super(nama, umur, peran);

  @override
  void bekerja() {
    print('$nama, Manager, sedang mengelola tim.');
  }
}

class ProdukDigital {
  String namaProduk;
  double harga;
  Kategori kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  // Metode untuk menerapkan diskon pada produk NetworkAutomation
  void terapkanDiskon() {
    if (kategori == Kategori.NetworkAutomation && harga >= 200000) {
      harga = harga * 0.85; // Diskon 15%
      if (harga < 200000) {
        harga = 200000; // Tidak boleh kurang dari 200000
      }
    }
  }
}

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  List<Karyawan> timProyek = [];

  void ubahFase(FaseProyek faseBaru) {
    if (fase == FaseProyek.Perencanaan &&
        faseBaru == FaseProyek.Pengembangan &&
        timProyek.length >= 5) {
      fase = faseBaru;
      print('Proyek berpindah ke fase Pengembangan.');
    } else if (fase == FaseProyek.Pengembangan &&
        faseBaru == FaseProyek.Evaluasi) {
      fase = faseBaru;
      print('Proyek berpindah ke fase Evaluasi.');
    } else {
      print('Tidak memenuhi syarat untuk transisi fase.');
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int batasKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print('${karyawan.nama} ditambahkan sebagai karyawan aktif.');
    } else {
      print('Batas karyawan aktif tercapai.');
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
      print('${karyawan.nama} resign dan sekarang menjadi karyawan non-aktif.');
    }
  }
}

void main() {
  // Membuat produk
  ProdukDigital produk1 = ProdukDigital(
      'Sistem Otomasi Jaringan', 250000, Kategori.NetworkAutomation);
  produk1.terapkanDiskon();
  print('Harga setelah diskon: ${produk1.harga}');

  Karyawan karyawan1 = KaryawanTetap("Nur", 30, "Developer");
  Karyawan karyawan2 = KaryawanKontrak("Sila", 25, "Network Engineer");
  Manager manager1 = Manager("Sani", 21, "Manager");

  manager1.updateProduktivitas();
  manager1.cekProduktivitas();

  Perusahaan perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawan1);
  perusahaan.tambahKaryawan(karyawan2);
  perusahaan.tambahKaryawan(manager1);

  Proyek proyek1 = Proyek();
  proyek1.timProyek = [karyawan1, karyawan2, manager1];
  proyek1.ubahFase(FaseProyek.Pengembangan);
}
