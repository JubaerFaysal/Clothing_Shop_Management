import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/components/delete_aleart.dart';
import 'package:tailor_shop/page/inventory/product_view.dart';

Column mycolumn() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 154, 154, 240),
              Colors.teal
            ]),
            borderRadius: BorderRadius.circular(12)),
        child: Text("Available Products-",
            style: GoogleFonts.poppins(
                fontSize: 20,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold)),
      ),
      const SizedBox(
        height: 15,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Inventory').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading inventory'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No inventory found.'));
            }
        
            final inventoryItems = snapshot.data!.docs;
        
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: inventoryItems.map((item) {
                  return Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                       // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: Image.network(
                              item['imageUrl'],
                             // height: 160,
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const SizedBox(
                                  height: 160,
                                  child:
                                      Center(child: CircularProgressIndicator()),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox(
                                  height: 160,
                                  child: Center(
                                      child: Icon(Icons.broken_image, size: 40)),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['Inventory_Name'] ?? 'Unnamed',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => deleteAleart(item, context),
                                  icon:
                                      const Icon(Icons.delete, color: Colors.red),
                                  tooltip: "Delete Item",
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ProductView()),
                                );
                              },
                              label: Text(
                                "View",
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              icon: const Icon(Icons.visibility),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: const Size.fromHeight(40),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      )
    ],
  );
}
