import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatelessWidget {
  final dynamic eachproduct;
  const ProductDetails({super.key, required this.eachproduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 400,
      constraints: const BoxConstraints(maxHeight: 700),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Details for ${eachproduct['Product']}",
              style: GoogleFonts.poppins(
                color: Colors.teal.shade700,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                eachproduct['imageUrl'],
                width: 270,
                height: 270,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Enjoy your shopping with FQ's. \nTailor's App makes our shopping easy and peaceful.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.teal.shade300),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoTile(
                    Icons.label_important, "Brand", "N/A"),
                _buildInfoTile(
                    Icons.line_weight, "Weight", "N/A"),
                _buildInfoTile(Icons.category, "Materials", "N/A"),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price:",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹ ${eachproduct['Price']}",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              label: const Text("Close"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.teal, size: 30),
        const SizedBox(height: 6),
        Text(label,
            style:
                GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600)),
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800])),
      ],
    );
  }
}
