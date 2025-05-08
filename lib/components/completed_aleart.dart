// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_aleart_dialog.dart';
import 'my_dialog_box.dart';

void completedAleart(DocumentSnapshot eachItem, BuildContext context) {
  Future<void> moveOrderToNewCollection(
      String orderId, Map<String, dynamic> orderData) async {
    try {
      showDialog(context: context, builder: (context) => const MyDialogBox());

      await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .update({"Status": 'Completed'});
    
      Navigator.pop(context);
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
        'Complete Order',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      content: Text(
        "Are you Sure?",
        style: GoogleFonts.poppins(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await moveOrderToNewCollection(
                eachItem.id, Map<String, dynamic>.from(eachItem.data() as Map));
            Navigator.pop(context);
          },
          child: Text(
            'Yes',
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
