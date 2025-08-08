import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/cart_item_model.dart';

class CartItemTileWidget extends StatelessWidget {
  final CartItemModel item;
  final Function(String userId, String plantId) onDelete;
  final bool isSelected;
  final Function(bool?) onCheckboxChanged;

  const CartItemTileWidget({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.isSelected,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Slidable(
        key: ValueKey(item.plantId),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(8.r),
              onPressed: (_) => onDelete(item.userId, item.plantId),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Card(
          color: Colors.green.shade50,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(

            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
             Checkbox(value: isSelected, onChanged: onCheckboxChanged,visualDensity: VisualDensity.compact,activeColor: Colors.green,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(item.imageUrl, width: 60.w, height: 60.h,fit: BoxFit.cover,),
                ),
            ],),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Quantity: ${item.quantity}"),
                Text("Rs = ${item.price * item.quantity}"),
              ],
            ),



          ),
        ),
      ),
    );
  }
}
