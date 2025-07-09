import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/pages/dashboard/dashboard_view.dart';
import 'package:pos/pages/kategori/kategori_view.dart';
import 'package:pos/pages/laporan/laporan_view.dart';
import 'package:pos/pages/pengaturan/pengaturan_view.dart';
import 'package:pos/pages/pengguna/pengguna_view.dart';
import 'package:pos/pages/produk/produk_view.dart';
import 'package:pos/pages/transaksi/transaksi_view.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool isCollapsed = false;
  int selectedIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.restaurant_menu, "title": "Menu"},
    {"icon": Icons.point_of_sale, "title": "Transaksi"},
    {"icon": Icons.history_rounded, "title": "Riwayat Transaksi"},
    {"icon": Icons.inventory_2, "title": "Produk"},
    {"icon": Icons.category_sharp, "title": "Kategori"},
    {"icon": Icons.person_2, "title": "Pengguna"},
    {"icon": Icons.library_books_rounded, "title": "Laporan"},
    {"icon": Icons.settings, "title": "Pengaturan"},
    // {"icon": Icons.logout, "title": "Logout"},
  ];

  final List<Widget> contentWidgets = const [
    DashboardView(),
    TransaksiView(),
    ProdukView(),
    KategoriView(),
    PenggunaView(),
    LaporanView(),
    PengaturanView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(69, 224, 224, 224),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar
            AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              duration: const Duration(milliseconds: 300),
              width: isCollapsed ? 70 : 250,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      isCollapsed
                          ? IconButton(
                              icon: Icon(
                                isCollapsed
                                    ? Icons.list_rounded
                                    : Icons.list_rounded,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(() {
                                  isCollapsed = !isCollapsed;
                                });
                              },
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 55),
                                  Image.asset(
                                    'assets/component/pos.png',
                                    fit: BoxFit.fill,
                                    width: 100,
                                  ),
                                  SizedBox(width: 50),
                                  IconButton(
                                    icon: Icon(
                                      isCollapsed
                                          ? Icons.list_rounded
                                          : Icons.list_rounded,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isCollapsed = !isCollapsed;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(height: 10),
                      ...List.generate(menuItems.length, (index) {
                        return _buildMenuItem(
                          icon: menuItems[index]['icon'],
                          title: menuItems[index]['title'],
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                  _buildMenuItem(
                    icon: Icons.logout,
                    onTap: () {},
                    title: 'Logout',
                  ),
                ],
              ),
            ),
            // Content Area
            SizedBox(width: 15),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: contentWidgets[selectedIndex],
              ),
            ),
          ],
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : const Color.fromARGB(255, 72, 168, 247),
            ),
            if (!isCollapsed) ...[
              // const SizedBox(width: 12),
              // ⬇️ Fade-in animation when expanding
              Expanded(
                flex: 2,
                child: AnimatedOpacity(
                  opacity: isCollapsed ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Text(
                    title,
                    style: GoogleFonts.lato(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 15,
                    ),

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
