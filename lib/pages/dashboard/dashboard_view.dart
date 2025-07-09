import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/components/styles.dart' show loadingSpinWhiteSizeBig;
import 'package:pos/pages/dashboard/dashboard_viewmodel.dart';
import 'package:pos/state_global/state_global.dart';
import 'package:pos/widgets/cart_tem.dart';
import 'package:pos/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:shimmer/shimmer.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedIndex = 0;
  int selectedIndexOption = 0;
  int selectedIndexOptionPayment = 0;
  final List<Map<String, dynamic>> kategoriItems = [
    {"icon": Icons.grid_view, "title": "All"},
    {"icon": Icons.restaurant_menu, "title": "Dinner"},
    {"icon": Icons.lunch_dining, "title": "Lunch"},
    {"icon": Icons.fastfood, "title": "Snack"},
    {"icon": Icons.icecream, "title": "Dessert"},
    {"icon": Icons.ramen_dining, "title": "Side Dish"},
    {"icon": Icons.dining_outlined, "title": "Appetizer"},
    {"icon": Icons.breakfast_dining, "title": "Breakfast"},
    {"icon": Icons.local_cafe, "title": "Beverage"},
    // {"icon": Icons.logout, "title": "Logout"},
  ];

  final List<Map<String, dynamic>> payOption = [
    {"icon": Icons.attach_money, "title": "Cash"},
    {"icon": Icons.credit_card, "title": "Credit/Debit"},
    {"icon": Icons.qr_code_2, "title": "QR Code"},
  ];

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1000) return 9;
    if (width >= 600) return 4;
    return 2;
  }

  final List<String> options = ["Dine In", "Take Away", "Delivery"];

  @override
  Widget build(BuildContext context) {
    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardViewmodel(ctx: context),
      builder: (context, vm, child) {
        return SingleChildScrollView(
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputField(
                              hintText: 'Search Product Here ....',
                              icon: Icons.search,
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "Kategori",
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                        255,
                                        168,
                                        168,
                                        168,
                                      ),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent:
                                        180, // Lebar maksimal per item
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio:
                                        1.1, // Sesuaikan dengan tinggi item kamu
                                  ),
                              itemCount: kategoriItems.length,
                              itemBuilder: (context, index) {
                                return _buildMenuItem(
                                  icon: kategoriItems[index]['icon'],
                                  title: kategoriItems[index]['title'],
                                  isSelected: selectedIndex == index,
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "Produk",
                                    style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(
                                        255,
                                        168,
                                        168,
                                        168,
                                      ),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            vm.isBusy
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(16),
                                    itemCount: 10,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 16,
                                          childAspectRatio: 0.6,
                                        ),
                                    itemBuilder: (context, index) {
                                      return buildShimmerCard();
                                    },
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(16),
                                    itemCount: vm.listAllProduct.length,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 16,
                                          childAspectRatio: 0.6,
                                        ),
                                    itemBuilder: (context, index) {
                                      final item = vm.listAllProduct[index];
                                      return ProductCard(
                                        imageUrl: item.image,
                                        title: item.name,
                                        price: item.price,
                                        isVeg: true,
                                        vm: vm,
                                        product: item,
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: List.generate(options.length, (index) {
                                return Expanded(
                                  child: _buildoptions(
                                    onTap: () {
                                      setState(() {
                                        selectedIndexOption = index;
                                      });
                                    },
                                    options: options,
                                    title: options[index],
                                    isSelected: selectedIndexOption == index,
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.9,
                                width: double.infinity,

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      255,
                                      230,
                                      230,
                                      230,
                                    ),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: vm.items.isNotEmpty
                                    ? SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: List.generate(
                                            vm.items.length,
                                            (index) {
                                              final item = vm.items[index];
                                              return Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: CartItemTile(
                                                  imageUrl: item.product.image,
                                                  title: item.product.name,
                                                  price: item.product.price,
                                                  quantity: item.quantity,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.inbox,
                                              size: 50,
                                              color: const Color.fromARGB(
                                                255,
                                                230,
                                                230,
                                                230,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Belum ada data",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: const Color.fromARGB(
                                                  255,
                                                  230,
                                                  230,
                                                  230,
                                                ),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(115, 238, 238, 238),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sub Total",
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                            255,
                                            145,
                                            145,
                                            145,
                                          ),
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "${formatRupiah.format(vm.subTotal)}",
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                            255,
                                            145,
                                            145,
                                            145,
                                          ),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tax 5%",
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                            255,
                                            145,
                                            145,
                                            145,
                                          ),
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        "${formatRupiah.format(vm.tax)}",
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                            255,
                                            145,
                                            145,
                                            145,
                                          ),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  DottedLine(
                                    dashLength: 6.0,
                                    dashColor: Colors.grey,
                                    lineThickness: 1.5,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sub Total",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                            255,
                                            145,
                                            145,
                                            145,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        "${formatRupiah.format(vm.subTotal + vm.tax)}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                            255,
                                            145,
                                            145,
                                            145,
                                          ),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: List.generate(payOption.length, (index) {
                              return Expanded(
                                child: _buildMenuPay(
                                  onTap: () {
                                    setState(() {
                                      selectedIndexOptionPayment = index;
                                    });
                                  },
                                  icon: payOption[index]['icon'],
                                  title: options[index],
                                  isSelected:
                                      selectedIndexOptionPayment == index,
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.blue,
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Place Order",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildInputField({
  required String hintText,
  required IconData icon,
  bool obscureText = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // warna lebih gelap
          blurRadius: 15, // lebih lembut
          spreadRadius: 1, // sedikit menyebar
          offset: Offset(0, 8), // posisi lebih ke bawah
        ),
      ],
    ),
    child: TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    ),
  );
}

Widget _buildMenuItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isSelected = false,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(30),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // warna lebih gelap
            blurRadius: 15, // lebih lembut
            spreadRadius: 1, // sedikit menyebar
            offset: Offset(0, 8), // posisi lebih ke bawah
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              size: 30,
              icon,
              color: isSelected
                  ? Colors.white
                  : const Color.fromARGB(255, 72, 168, 247),
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '255 items',
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 10,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildMenuPay({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
  bool isSelected = false,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(30),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? Colors.white : Colors.black,
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildoptions({
  required VoidCallback onTap,
  required String title,
  required List<String> options,
  bool isSelected = false,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildShimmerCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Shimmer Gambar
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 12,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            SizedBox(height: 8),

            // Harga & badge shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 10, width: 80, color: Colors.grey.shade300),
                  Container(height: 10, width: 50, color: Colors.grey.shade300),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Tombol shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 36,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
