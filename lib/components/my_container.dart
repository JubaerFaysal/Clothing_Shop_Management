
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/Methods/timer.dart';
import 'package:tailor_shop/components/my_button.dart';


class MyContainer extends StatelessWidget {
  final String id;
  final String? measurement;
  final String? token;
  final String? productName;
  final String? quantity;
  final String? unitPrice;
  final double? totalPrice;
  final String? deliveryDate;
  final String? orderDate;
  final String? fabric;
  final String? advance;
  final double? due;
  final String? Neck_Circumference;
  final String? Shoulder_Width;
  final String? Chest_Bust;
  final String? waist;
  final String? Sleeve_Length;
  final String? Arm_Hole;
  final String? bicep;
  final String? Cuff_Circumference;
  final String? Shirt_Length;
  final String? Hip;
  final String? Front_Rise;
  final String? Crotch_Depth;
  final String? Back_Rise;
  final String? Inseam;
  final String? Outseam;
  final String? Thigh;
  final String? Knee;
  final String? Leg_Opening;
  final String? hem;
  final String? neckOpening;

  final VoidCallback? onPressed;
  final VoidCallback? delete;
  final VoidCallback? modify;
  final VoidCallback? newItem;
  final VoidCallback? completed;
  final VoidCallback? deliveried;

  const MyContainer({
    super.key,
    required this.id,
    this.measurement,
    this.token,
    this.productName,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.deliveryDate,
    this.onPressed,
    this.delete,
    this.modify,
    this.newItem,
    this.completed,
    this.deliveried,
    this.orderDate,
    this.fabric,
    this.advance,
    this.due,
    this.Neck_Circumference,
    this.Shoulder_Width,
    this.Chest_Bust,
    this.waist,
    this.Sleeve_Length,
    this.Arm_Hole,
    this.bicep,
    this.Cuff_Circumference,
    this.Shirt_Length,
    this.Hip,
    this.Front_Rise,
    this.Crotch_Depth,
    this.Back_Rise,
    this.Inseam,
    this.Outseam,
    this.Thigh,
    this.Knee,
    this.Leg_Opening,
    this.hem,
    this.neckOpening,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: const EdgeInsets.all(14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFe0f7fa), Color(0xFFffffff)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.teal.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (measurement != null) _highlightTitle(measurement!),
            const SizedBox(height: 10),

            // Order Info Section
            _section("Order Details", [
              if (token != null) _rowText("Token", token!),
              if (productName != null) _rowText("Product", productName!),
              if (fabric != null) _rowText("Fabric", fabric!),
              if (quantity != null) _rowText("Quantity", quantity!),
              if (unitPrice != null) _rowText("Unit Price", unitPrice!),
              if (totalPrice != null)
                _rowText("Total Price", "₹ ${totalPrice!.toStringAsFixed(2)}"),
              if (advance != null) _rowText("Advance", "₹ $advance"),
              if (due != null) _rowText("Due", "₹ ${due!.toStringAsFixed(2)}"),
              if (orderDate != null) _rowText("Ordered On", orderDate!),
              if (deliveryDate != null) _rowText("Delivery By", deliveryDate!),
            ]),

            const Divider(thickness: 1, color: Colors.teal),

            // Measurement Info in Responsive Wrap
            if (_hasMeasurements())
              _section("Measurements", [
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: _buildMeasurementChips(),
                )
              ]),

            const SizedBox(height: 10),
            DeadlineTimer(orderId: id),

            const Divider(thickness: 1, color: Colors.teal),

            // Buttons Section
            _buildActions(),
          ],
        ),
      );
    });
  }

  Widget _highlightTitle(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _rowText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
        const SizedBox(height: 6),
        ...children,
      ],
    );
  }

  List<Widget> _buildMeasurementChips() {
    final dataMap = {
      "Neck": Neck_Circumference,
      "Shoulder": Shoulder_Width,
      "Chest": Chest_Bust,
      "Waist": waist,
      "Sleeve": Sleeve_Length,
      "Arm Hole": Arm_Hole,
      "Bicep": bicep,
      "Cuff": Cuff_Circumference,
      "Shirt Length": Shirt_Length,
      "Hip": Hip,
      "Front Rise": Front_Rise,
      "Crotch": Crotch_Depth,
      "Back Rise": Back_Rise,
      "Inseam": Inseam,
      "Outseam": Outseam,
      "Thigh": Thigh,
      "Knee": Knee,
      "Leg Opening": Leg_Opening,
      "Hem": hem,
      "Neck Opening": neckOpening,
    };

    return dataMap.entries
        .where((entry) => entry.value != null)
        .map((entry) => Chip(
              label: Text(
                "${entry.key}:   ${entry.value}",
                style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w700),
              ),
              backgroundColor: Colors.teal.shade100,
              
            ))
        .toList();
  }

  Widget _buildActions() {
    return Column(
      children: [
        if (onPressed != null)
          Align(
            alignment: Alignment.centerRight,
            child: MyButton(
              text: "View Details",
              onPressed: onPressed,
              icon: Icons.visibility,
              color: Colors.teal,
            ),
          ),
        if (modify != null || newItem != null || delete != null)
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (modify != null)
                MyButton(
                  text: "Edit",
                  fontsize: 16,
                  onPressed: modify,
                  icon: Icons.edit,
                  color: Colors.blueAccent,
                ),
              if (newItem != null)
                MyButton(
                  text: "Add Item",
                  fontsize: 16,
                  onPressed: newItem,
                  icon: Icons.add_circle,
                  color: Colors.indigo,
                ),
              if (delete != null)
                MyButton(
                  text: "Delete",
                  fontsize: 16,
                  onPressed: delete,
                  icon: Icons.delete,
                  color: Colors.redAccent,
                ),
            ],
          ),
        const SizedBox(height: 10),
        if (completed != null)
          MyButton(
            icon: Icons.check_circle,
            text: "Mark as Completed",
            color: const Color.fromARGB(255, 255, 160, 64),
            onPressed: completed,
            fontsize: 16,
          ),
        if (deliveried != null)
          MyButton(
            icon: Icons.delivery_dining,
            text: "Deliver Item",
            fontsize: 16,
            color: Colors.green,
            onPressed: deliveried,
          ),
      ],
    );
  }

  bool _hasMeasurements() {
    return [
      Neck_Circumference,
      Shoulder_Width,
      Chest_Bust,
      waist,
      Sleeve_Length,
      Arm_Hole,
      bicep,
      Cuff_Circumference,
      Shirt_Length,
      Hip,
      Front_Rise,
      Crotch_Depth,
      Back_Rise,
      Inseam,
      Outseam,
      Thigh,
      Knee,
      Leg_Opening,
      hem,
      neckOpening,
    ].any((element) => element != null);
  }
}
