import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void deleteAleart(DocumentSnapshot eachItem, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text(
        'Delete Item ',
        style: TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      content: Text("Are You sure!",
        style: GoogleFonts.poppins(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.red),
      ),
      actions: [
        TextButton(
          onPressed: () {
            eachItem.reference.delete();
            Navigator.pop(context);
          },
          child: Text(
            'OK',
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
