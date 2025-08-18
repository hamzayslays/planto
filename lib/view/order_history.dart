import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  final OrderModel order;

  const OrderHistoryScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: Colors.green.shade500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Image
            Center(
              child: Image.network(
                order.plant.image,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            Text(
              "Plant: ${order.plant.plantName}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Quantity: ${order.quantity}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Status: ${order.status}", style: TextStyle(
              fontSize: 16,
              color: order.status.toLowerCase() == "pending" ? Colors.orange :
              order.status.toLowerCase() == "delivered" ? Colors.green :
              Colors.red,
            )),
          ],
        ),
      ),
    );
  }
}
