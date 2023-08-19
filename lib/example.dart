import 'package:flutter/material.dart';

import 'FoodMenu.dart';
import 'widget/MoneyBox.dart';

void main() {
  runApp(MyApp());
}

//สร้าง Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int number = 0;
  //กลุ่มข้อมูล
  List<FoodMenu> menu = [
    FoodMenu("กุ้งเผา", "500", "assets/images/grillshrimp.jpg"),
    FoodMenu("กะเพราไก่", "25", "assets/images/kapraokai.jpg"),
    FoodMenu("ต้มยำกุ้ง", "300", "assets/images/tomyumkung.jpg"),
    FoodMenu("สลัดผัก", "250", "assets/images/saladbowl.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];

    data.add(Text("กดปุ่มเพื่อเพิ่มตัวเลข"));
    data.add(Text(number.toString()));
    data.add(Image(
        image: NetworkImage(
            "https://cdn.pixabay.com/photo/2014/12/10/20/48/laboratory-563423_640.jpg")));

    return Scaffold(
      appBar: AppBar(
        title: Text("บัญชีของฉัน"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            MoneyBox("ยอดคงเหลือ", 10000000, Colors.blue, 100),
            SizedBox(
              height: 10,
            ),
            MoneyBox("รายรับ", 20000, Colors.green, 70),
            SizedBox(
              height: 10,
            ),
            MoneyBox("รายจ่าย", 7000, Colors.red, 70),
            SizedBox(
              height: 10,
            ),
            MoneyBox("ค้างชำระ", 1200, Colors.orange, 70),
          ],
        ),
      ),
    );
  }

  void addNumber() {
    setState(() {
      number++;
    });
  }

  List<Widget> getData(int count) {
    List<Widget> data = [];
    for (var i = 0; i < count; i++) {
      var menu = ListTile(
        title: Text(
          "เมนูทที่ ${i + 1}",
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text("หัวข้อย่อยที่ ${i + 1}"),
      );
      data.add(menu);
    }
    return data;
  }
}
