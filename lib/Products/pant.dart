// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tailor_shop/components/my_aleart_dialog.dart';
import 'package:tailor_shop/components/my_custom_text.dart';
import 'package:tailor_shop/components/my_text_form.dart';

import '../Components/my_dialog_box.dart';
import '../Methods/select_date.dart';

final formKey = GlobalKey<FormState>();

Future<void> pant(BuildContext context, String id, String name) async {
  final screenWidth = MediaQuery.of(context).size.width;
  TextEditingController fabric = TextEditingController();
  TextEditingController advance = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController waist = TextEditingController();
  TextEditingController Hip = TextEditingController();
  TextEditingController Front_Rise = TextEditingController();
  TextEditingController Back_Rise = TextEditingController();
  TextEditingController Inseam = TextEditingController();
  TextEditingController Outseam = TextEditingController();
  TextEditingController Thigh = TextEditingController();
  TextEditingController Knee = TextEditingController();
  TextEditingController Leg_Opening = TextEditingController();
  TextEditingController Crotch_Depth = TextEditingController();

  //dialog box to input product categori
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyCustomText(
                    text: name,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 115, 255),
                  ),
                  const SizedBox(height: 15),
                  MyTextForm(
                    labeltext: "*Fabric",
                    controller: fabric,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Quantity",
                          controller: quantity,
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Unit Price",
                          controller: price,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextForm(
                    labeltext: "*Advance",
                    controller: advance,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: date,
                    readOnly: true,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      suffixIcon: Icon(Icons.calendar_month),
                      labelText: "Delivery Date",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    onTap: () => selectDate(context, date),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the Delivery Date";
                      }
                      return null;
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  MyTextForm(
                    labeltext: "*waist",
                    controller: waist,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextForm(
                    labeltext: "*Hip",
                    controller: Hip,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Front_Rise",
                          controller: Front_Rise,
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Crotch_Depth",
                          controller: Crotch_Depth,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Back_Rise",
                          controller: Back_Rise,
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Inseam",
                          controller: Inseam,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Outseam",
                          controller: Outseam,
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Thigh",
                          controller: Thigh,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Knee",
                          controller: Knee,
                          inputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextForm(
                          labeltext: "*Leg_Opening",
                          controller: Leg_Opening,
                          inputType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: MyCustomText(
                          text: "Cancel",
                          color: Colors.red,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            double? amount = double.tryParse(quantity.text);
                            double? value = double.tryParse(price.text);
                            double? advnc = double.tryParse(advance.text);

                            if (amount != null && value != null) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const MyDialogBox());
                              double totalPrice = amount * value;
                              double due = totalPrice - advnc!;
                              DateTime parsedDate =
                                  DateFormat("yyyy-MM-dd").parse(date.text);
                              String orderDate =
                                  DateFormat('yy-MM-dd').format(DateTime.now());
                              try {
                                await FirebaseFirestore.instance
                                    .collection('Orders')
                                    .add({
                                  "Token": id,
                                  "Delivery_Date":
                                      Timestamp.fromDate(parsedDate),
                                  "Order_Date": orderDate,
                                  "Status": "Pending",
                                  "Fabric": fabric.text,
                                  "Advance": advance.text,
                                  "Due": due,
                                  "Measurement": name,
                                  "Quantity": quantity.text,
                                  "Unit_Price": price.text,
                                  "waist": waist.text,
                                  "Hip":Hip.text,
                                  "Front_Rise":Front_Rise.text,
                                  "Crotch_Depth":Crotch_Depth.text,
                                  "Back_Rise":Back_Rise.text,
                                  "Inseam":Inseam.text,
                                  "Outseam":Outseam.text,
                                  "Thigh":Thigh.text,
                                  "Knee":Knee.text,
                                  "Leg_Opening":Leg_Opening.text,
                                  "Total_Price": totalPrice
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: MyCustomText(
                                      text: "Upload Successfully!",
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    backgroundColor: Colors.blue,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              } catch (e) {
                                myAleartDialog('Error: $e', context);
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              myAleartDialog(
                                  'Please enter valid Price Or Quantity',
                                  context);
                            }
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
