// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/Methods/product_method.dart';
import 'package:tailor_shop/components/my_appbar.dart';
import 'package:tailor_shop/components/my_button.dart';
import 'package:tailor_shop/page/inventory/product_details.dart';

class ProductView extends StatefulWidget {
  final String uniqueId;
  const ProductView({super.key, required this.uniqueId});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final cloudinary = CloudinaryPublic('duoqdpodl', 'Mudi_upload');
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final products = _firestore.collection('Inventory').doc(widget.uniqueId);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 232, 235),
      appBar: const MyAppbar(name: "Products"),
      body: StreamBuilder<QuerySnapshot>(
        stream: products.collection('Products').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final productList = snapshot.data!.docs;

          if (productList.isEmpty) {
            return const Center(
              child: Text(
                'No Products uploaded yet.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: MasonryGridView.count(
              crossAxisCount: 5,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                var product = productList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to detail page
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 212, 250, 236),
                          Color(0xFFffffff)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                product['imageUrl'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            product['Product'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child:
                                          ProductDetails(eachproduct: product),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.visibility),
                                label: Text("View Details",
                                    style: GoogleFonts.poppins()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1ABC9C),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                              Text(
                                "₹ ${product['Price']}",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                                label: Text("Modify",
                                    style: GoogleFonts.poppins()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3498DB),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.delete),
                                label: Text("Delete",
                                    style: GoogleFonts.poppins()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrangeAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: MyButton(
        text: "Add Product",
        icon: Icons.add,
        fontsize: 18,
        onPressed: () {
          ProductMethod.addProduct(context, widget.uniqueId);
        },
        color: Colors.teal,
      ),
    );
  }
}
