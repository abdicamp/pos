import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos/model/product_models.dart';
import 'package:pos/pages/dashboard/dashboard_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Recipe? product;
  final DashboardViewmodel? vm;
  final String imageUrl;
  final String title;
  final double price;
  final bool isVeg; // true = Veg, false = Non-Veg

  const ProductCard({
    super.key,
    this.product,
    this.vm,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.isVeg,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final colorBadge = widget.isVeg ? Colors.blue : Colors.red;
    final viewModel = Provider.of<DashboardViewmodel>(context);
    var quantity = viewModel.getQuantity(widget.product!);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: quantity > 0 ? Colors.blue : Colors.transparent,
          width: 1.5,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Gambar
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
              bottom: Radius.circular(16),
            ),
            child: Image.network(
              widget.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Isi bawah
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4),

                // Harga dan badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${formatRupiah.format(widget.price)}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: colorBadge),
                        SizedBox(width: 4),
                        Text(
                          widget.isVeg ? 'Veg' : 'Non Veg',
                          style: TextStyle(fontSize: 10, color: colorBadge),
                        ),
                      ],
                    ),
                  ],
                ),

                // Add Button or Counter
                quantity == 0
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              quantity = 1;
                              viewModel.addToCart(widget.product!);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Add to Dish",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) quantity--;

                                viewModel.decreaseQuantity(widget.product!);
                              });
                            },
                            icon: Icon(Icons.remove_circle, color: Colors.blue),
                          ),
                          Text(
                            '$quantity',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                                viewModel.addToCart(widget.product!);
                              });
                            },
                            icon: Icon(Icons.add_circle, color: Colors.blue),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
