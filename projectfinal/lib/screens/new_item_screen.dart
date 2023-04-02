import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectfinal/services/item_service.dart';
import 'package:logger/logger.dart';
import 'package:flutter/services.dart';

class NewItemScreen extends StatefulWidget {
  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  final _itemName = TextEditingController();
  final _itemOld = TextEditingController();
  final _itemWeight = TextEditingController();
  final _itemHigh = TextEditingController();
  final _itemCond = TextEditingController();
  final _itemPhone = TextEditingController();
  final _itemAdd = TextEditingController();
  final _itemGender = TextEditingController();

  final ItemService _itemService = ItemService();

  final List<String> _prefixes = ['นาย', 'นาง', 'นางสาว'];
  String _selectedPrefix = '';

  @override
  void initState() {
    super.initState();
    _selectedPrefix = _prefixes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มข้อมูลคนไข้"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedPrefix,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPrefix = newValue!;
                    });
                  },
                  items:
                      _prefixes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: TextField(
                    controller: _itemName,
                    decoration: InputDecoration(label: Text("ชื่อ-นามสกุล")),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _itemOld,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(label: Text("อายุ")),
            ),
            TextField(
              controller: _itemWeight,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(label: Text("น้ำหนัก")),
            ),
            TextField(
              controller: _itemHigh,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(label: Text("ส่วนสูง")),
            ),
            TextField(
              controller: _itemCond,
              decoration: InputDecoration(label: Text("โรคประจำตัว")),
            ),
            TextField(
              controller: _itemGender,
              decoration: InputDecoration(label: Text("เพศ")),
            ),
            TextField(
              controller: _itemPhone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(label: Text("เบอร์โทร")),
            ),
            TextField(
              controller: _itemAdd,
              decoration: InputDecoration(label: Text("ที่อยู่")),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: _addItem, child: const Text("บันทึกข้อมูล"))
          ],
        ),
      ),
    );
  }

  _addItem() {
    String fullName = '$_selectedPrefix${_itemName.text}';
    _itemService.addItem2Firebase(_itemName.text, {
      "name": fullName,
      "old": _itemOld.text,
      "weight": _itemWeight.text,
      "high": _itemHigh.text,
      "Cond": _itemCond.text,
      "phonenumber": _itemPhone.text,
      "address": _itemAdd.text,
      "gender": _itemGender.text,
    });
  }
}
