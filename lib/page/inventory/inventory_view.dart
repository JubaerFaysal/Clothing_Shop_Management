import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/components/delete_aleart.dart';
import 'package:tailor_shop/page/inventory/product_view.dart';

Container inventoryView() {
  return Container(
     padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        )
      ],
    ),
    child: Column(
     // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4DD0E1), Color(0xFF00796B)],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Available Products",
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('Inventory').snapshots(),
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
                children: inventoryItems.map((item) {
                  return Material(
                    elevation: 6,
                    shadowColor: Colors.black26,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color.fromARGB(255, 230, 230, 230),
                         boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(2, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14)),
                            child: Image.network(
                              item['imageUrl'],
                              //height: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['Inventory_Name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => deleteAleart(item, context),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  tooltip: "Delete Item",
                                )
                              ],
                            ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           ProductView(uniqueId: item.id,)),
                                );
                              },
                              icon: const Icon(Icons.view_carousel),
                              label: Text(
                                "Visite",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
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
      ],
    ),
  );
}
