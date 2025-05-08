
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tailor_shop/Methods/timer.dart';
import 'package:tailor_shop/components/my_button.dart';

import 'my_custom_text.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const[
              BoxShadow(
                color: Color.fromARGB(255, 31, 70, 122),
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(1, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (measurement != null) Product(),
              const SizedBox(height: 8),
              if (token != null) rowText("Token:", token!),
              if (productName != null) rowText("Product Name:", productName!),
              if (fabric != null) rowText("Fabric:", fabric!),
              if (quantity != null) rowText("Quantity:", quantity!),
              if (unitPrice != null) rowText("Unit Price:", unitPrice!),
              if (totalPrice != null)
                rowText("Total Price:", totalPrice!.toString()),
              if (advance != null) rowText("Advance:", advance!),
              //const Divider(thickness: 2,height: 0,color: Colors.black,),
              if (due != null) rowText("Due:", due!.toString()),

              if (orderDate != null) rowText("Order Date:", orderDate!),
              if (deliveryDate != null)
                rowText("Delivery Date:", deliveryDate!),
              const Divider(
                color: Colors.blue,
                thickness: 0.5,
              ),
              // Using Wrap to handle responsiveness
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: [
                  if (Neck_Circumference != null)
                    rowText("Neck_Circumference:", Neck_Circumference!),
                  if (Shoulder_Width != null)
                    rowText("Shoulder_Width:", Shoulder_Width!),
                  if (Chest_Bust != null) rowText("Chest_Bust:", Chest_Bust!),
                  if (waist != null) rowText("waist:", waist!),
                  if (Sleeve_Length != null)
                    rowText("Sleeve_Length:", Sleeve_Length!),
                  if (Arm_Hole != null) rowText("Arm_Hole:", Arm_Hole!),
                  if (bicep != null) rowText("bicep:", bicep!),
                  if (Cuff_Circumference != null)
                    rowText("Cuff_Circumference:", Cuff_Circumference!),
                  if (Shirt_Length != null)
                    rowText("Shirt_Length:", Shirt_Length!),
                  if (Hip != null) rowText("Hip:", Hip!),
                  if (Front_Rise != null) rowText("Front_Rise:", Front_Rise!),
                  if (Crotch_Depth != null)
                    rowText("Crotch_Depth:", Crotch_Depth!),
                  if (Back_Rise != null) rowText("Back_Rise:", Back_Rise!),
                  if (Inseam != null) rowText("Inseam:", Inseam!),
                  if (Outseam != null) rowText("Outseam:", Outseam!),
                  if (Thigh != null) rowText("Thigh:", Thigh!),
                  if (Knee != null) rowText("Knee:", Knee!),
                  if (Leg_Opening != null)
                    rowText("Leg_Opening:", Leg_Opening!),
                  if (hem != null) rowText("Hem:", hem!),
                  if (neckOpening != null)
                    rowText("neckOpening:", neckOpening!),
                ],
              ),
              const SizedBox(height: 8),

              DeadlineTimer(orderId: id),
              const Divider(
                color: Colors.blue,
                thickness: 0.5,
              ),
              // Buttons section
              if (onPressed != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: MyButton(
                    text: "View Details",
                    onPressed: onPressed,
                    icon: Icons.visibility,
                    color: Colors.teal,
                    //fontsize: 16,
                  ),
                ),
              if (modify != null || newItem != null || delete != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (modify != null)
                      MyButton(
                        text: "Edit",
                        onPressed: modify,
                        icon: Icons.edit,
                        color: Colors.blueAccent,
                      ),
                    if (newItem != null)
                      MyButton(
                        text: "New Item",
                        onPressed: newItem,
                        icon: Icons.add_card,
                        color: Colors.blue,
                      ),
                    if (delete != null)
                      MyButton(
                        text: "Delete",
                        onPressed: delete,
                        icon: Icons.delete,
                        color: Colors.red,
                      ),
                  ],
                ),
              if (completed != null)
                Align(
                  alignment: Alignment.center,
                  child: MyButton(
                    icon: Icons.done,
                    text: "Mark as Completed!",
                    color: Colors.orange,
                    onPressed: completed,
                  ),
                ),
              if (deliveried != null)
                Align(
                  alignment: Alignment.center,
                  child: MyButton(
                    icon: Icons.delivery_dining,
                    text: "Deliver the Item!",
                    color: Colors.orange,
                    onPressed: deliveried,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget Product() {
    return Container(
      padding: const EdgeInsets.all(9),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MyCustomText(
        text: "$measurement",
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget rowText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyCustomText(
            text: label,
            // fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          MyCustomText(
            text: value,
            //textAlign: TextAlign.right,
            // fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
