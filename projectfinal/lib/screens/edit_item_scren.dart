import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/item_service.dart';

class EditItemScreen extends StatefulWidget {
  final String documentId;
  final _itemName = TextEditingController();
  final _itemOld = TextEditingController();
  final _itemWeight = TextEditingController();
  final _itemHigh = TextEditingController();
  final _itemCond = TextEditingController();
  final _itemPhone = TextEditingController();
  final _itemAdd = TextEditingController();
  final _itemGender = TextEditingController();

  EditItemScreen(
    this.documentId,
    String itemName,
    String itemOld,
    String itemWeight,
    String itemHigh,
    String itemCond,
    String itemPhone,
    String itemAdd,
    String itemGender,
  ) {
    _itemName.text = itemName;
    _itemOld.text = itemOld;
    _itemWeight.text = itemWeight;
    _itemHigh.text = itemHigh;
    _itemCond.text = itemCond;
    _itemPhone.text = itemPhone;
    _itemAdd.text = itemAdd;
    _itemGender.text = itemGender;
  }

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final ItemService _itemService = ItemService();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    return Scaffold(
      appBar: AppBar(
        title: const Text("แก้ไขประวัติ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: widget._itemName,
              decoration: const InputDecoration(label: Text("ชื่อ-นามสุกล")),
            ),
            TextField(
              controller: widget._itemOld,
              decoration: const InputDecoration(label: Text("อายุ")),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: widget._itemWeight,
              decoration: const InputDecoration(label: Text("น้ำหนัก")),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: widget._itemHigh,
              decoration: const InputDecoration(label: Text("ส่วนสูง")),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: widget._itemCond,
              decoration: const InputDecoration(label: Text("โรคประจำตัว")),
            ),
            TextField(
              controller: widget._itemGender,
              decoration: const InputDecoration(label: Text("เพศ")),
            ),
            TextField(
              controller: widget._itemPhone,
              decoration: const InputDecoration(label: Text("เบอร์โทร")),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: widget._itemAdd,
              decoration: const InputDecoration(label: Text("ที่อยู่")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: style, onPressed: _deleteItem, child: const Text("ลบ")),
            const SizedBox(height: 10),
            ElevatedButton(
                style: style,
                onPressed: _editItem,
                child: const Text("อัพเดท")),
          ],
        ),
      ),
    );
  }

  void _editItem() {
    final String newName = widget._itemName.text;

    final String newOld = widget._itemOld.text;
    final String newHigh = widget._itemHigh.text;
    final String newWeight = widget._itemWeight.text;
    final String newCond = widget._itemCond.text;
    final String newPhone = widget._itemPhone.text;
    final String newAdd = widget._itemAdd.text;
    final String newGender = widget._itemGender.text;

    if (newName.isNotEmpty && newOld.isNotEmpty) {
      _itemService.updateItem(widget.documentId, {
        'name': newName,
        'old': newOld,
        'weight': newWeight,
        'high': newHigh,
        'Cond': newCond,
        'phonenumber': newPhone,
        'address': newAdd,
        'gender': newGender,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      });
    }
  }

  void _deleteItem() {
    _itemService.deleteItem(widget.documentId).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    });
  }
}
