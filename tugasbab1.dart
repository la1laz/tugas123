import 'dart:async';

enum Role { Admin, Customer }

class Product {
  String productName;
  double price;
  bool inStock;

  Product(
      {required this.productName, required this.price, required this.inStock});
}

class User {
  late String name;
  late int age;
  Map<String, Product> products = {};
  Role? role;

  User({required this.name, required this.age, this.role});

  // tmbh produk
  void addProduct(Product product) {
    if (!product.inStock)
      throw Exception(
          "Produk '${product.productName}' tidak tersedia di stok!");
    products[product.productName] = product;
    print("Produk '${product.productName}' berhasil ditambahkan.");
  }

  //  dftr produk
  void displayProducts() {
    if (products.isEmpty) {
      print("Tidak ada produk dalam daftar.");
    } else {
      print("Daftar Produk:");
      products.forEach((key, value) =>
          print("- ${value.productName} | Harga: ${value.price}"));
    }
  }

  Future<void> fetchProductDetails(String productName) async {
    print("\nMemulai pengambilan data produk '$productName'...");
    await Future.delayed(Duration(seconds: 2));
    if (products[productName] != null) {
      print(
          "Detail Produk: ${products[productName]!.productName} - Harga: ${products[productName]!.price}");
    } else {
      print("Produk '$productName' tidak ditemukan.");
    }
  }
}

class AdminUser extends User {
  AdminUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Admin);

  void removeProduct(String productName) {
    if (products.containsKey(productName)) {
      products.remove(productName);
      print("Produk '$productName' berhasil dihapus.");
    } else {
      print("Produk '$productName' tidak ditemukan.");
    }
  }
}

class CustomerUser extends User {
  CustomerUser({required String name, required int age})
      : super(name: name, age: age, role: Role.Customer);

  @override
  void addProduct(Product product) =>
      print("Customer tidak memiliki izin untuk menambah produk.");
}

void main() {
  var product1 = Product(productName: "Laptop", price: 1000.0, inStock: true);
  var product2 =
      Product(productName: "Smartphone", price: 500.0, inStock: false);

  // Membuat pengguna admin
  var admin = AdminUser(name: "Admin", age: 30);
  print("\nMenambahkan produk untuk Admin:");

  admin.addProduct(product1);
  try {
    admin.addProduct(product2);
  } catch (e) {
    print("Error: ${e.toString()}");
  }

  print("\nMenampilkan daftar produk untuk Admin:");
  admin.displayProducts();

  print("\nMenghapus produk untuk Admin:");
  admin.removeProduct("Laptop");
  admin.displayProducts();

  var customer = CustomerUser(name: "Customer", age: 25);
  print("\nCustomer mencoba menambah produk:");
  customer.addProduct(product1);

  print("\nCustomer mengambil detail produk 'Laptop':");
  customer.fetchProductDetails("Laptop");
}
