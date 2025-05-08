// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_aleart_dialog.dart';
import 'my_dialog_box.dart';
import 'my_text_field.dart';

void deliveryAlert(DocumentSnapshot eachItem, BuildContext context,
    TextEditingController dueController) {
  Future<void> deliveryTheItem(
    String orderId,
    Map<String, dynamic> orderData,
  ) async {
    try {
      showDialog(context: context, builder: (context) => const MyDialogBox());
      await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .update({
        "Status": 'Delivered',
        "Due": 0.0,
      });
    
      Navigator.pop(context);
    } catch (e) {
      myAleartDialog("Error moving order: $e", context);
    }
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text(
        'Confirm Delivery',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Enter Due Amount",
            style: GoogleFonts.poppins(
                fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(
            height: 8,
          ),
          MyTextfield(
              hintText: eachItem['Due'].toString(),
              obscureText: false,
              controller: dueController)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (dueController.text == eachItem['Due'].toString()) {
              try {
               
                await deliveryTheItem(
                  eachItem.id,
                  Map<String, dynamic>.from(eachItem.data() as Map),
                );
                Navigator.pop(context);
              } catch (e) {
                myAleartDialog('Error: $e', context);
              }
            }
          },
          child: Text(
            'Delivery',
            style: GoogleFonts.poppins(
                fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        )
      ],
    ),
  );
}
