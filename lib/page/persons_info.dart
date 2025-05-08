// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Components/my_dialog_box.dart';
import '../../Methods/select_date.dart';
import '../components/my_aleart_dialog.dart';
import '../components/my_button.dart';
import '../components/my_custom_text.dart';
import '../components/my_text_form.dart';
import 'new_order.dart';

final formKey = GlobalKey<FormState>();

Future<void> personsInfo(BuildContext context) async {
  Future<void> addCustomer(
      String name, String phone, String email, String dob) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference customersRef = firestore.collection('Customers');

    try {
      // Get the total number of documents (count of customers)
      QuerySnapshot querySnapshot = await customersRef.get();
      int newId = querySnapshot.size + 1; // Next document ID
      String id=newId.toString();
      // Add new customer with incremented document ID
      await customersRef.doc(id).set({
        'id': newId, 
        'name': name,
        'phone': phone,
        'email': email,
        'DoB': dob,
      });
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  NewOrder(id: id,)),
      );
    } catch (e) {
      myAleartDialog('Error: $e', context);
    }
  }

  //String docId;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
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
                      text: "Add Customer Information",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 88, 230),
                    ),
                    const SizedBox(height: 15),
                    MyTextForm(
                        labeltext: "*Name",
                        controller: name,
                        icon: const Icon(Icons.person)),
                    const SizedBox(height: 10),
                    MyTextForm(
                      labeltext: "*Phone",
                      controller: phone,
                      inputType: TextInputType.number,
                      icon: const Icon(Icons.call),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        suffixIcon: Icon(Icons.email),
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dob,
                      readOnly: true,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 2.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        suffixIcon: Icon(Icons.calendar_month),
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      onTap: () => selectDate(context, dob),
                     
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: MyCustomText(
                            text: "Cancel",
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const MyDialogBox());
                              addCustomer(
                                  name.text, phone.text, email.text, dob.text);
                             
                            }
                          },
                          height: 40,
                          width: 100,
                          text: "Save",
                          fontsize: 16,
                          textcolor: Colors.white,
                          color: Colors.cyan,
                          icon: Icons.save,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
