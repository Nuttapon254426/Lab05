// ignore: unused_import
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  //Form
  final GlobalKey<FormState> _formkey = GlobalKey();

//TextField
  TextEditingController _high = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _text3 = TextEditingController();
  int gender = 0;
  double? _bmi;
  bool Checkb = false;
  List<Fruit> fruits = [];
   final List<ListItem> _dropdownItems = [
    ListItem(1, 'คณะศึกษาศาสตร์'),
    ListItem(2, 'คณะมนุษยศาสตร์และสังคมศาสตร์'),
    ListItem(3, 'คณะศิลปกรรมศาสตร์'),
    ListItem(4, 'คณะเศรษฐศาสตร์และบริหารธุรกิจ'),
    ListItem(5, 'คณะนิติศาสตร์'),
    ListItem(6, 'คณะวิทยาศาสตร์'),
    ListItem(7, 'คณะวิทยาการสุขภาพและการกีฬา'),
    ListItem(8, 'วิทยาลัยการจัดการเพื่อการพัฒนา'),
    ListItem(9, 'คณะเทคโนโลยีและการพัฒนาชุมชน'),
    ListItem(10, 'คณะวิศวกรรมศาสตร์'),
    ListItem(11, 'คณะพยาบาลศาสตร์'),
    ListItem(12, 'คณะอุตสาหกรรมเกษตรและชีวภาพ'),
  ];

  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem? _selectedItem;
  String _message = 'Please enter your height an weight';

  void _calculate() {
      double weight = double.parse(_weight.text);
     double height = double.parse(_high.text) / 100;

    //  double? height = double.tryParse(_high.value.text)/100;
    //  double? weight = double.tryParse(_weight.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weigh must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmi = weight / (height *height);
      if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'You body is fine';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
      } else {
        _message = 'You are obese';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fruits = Fruit.getFruit();
    print(fruits[0].engName);
    _dropdownMenuItems = buildDropdownMenuItem(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }
  List<DropdownMenuItem<ListItem>> buildDropdownMenuItem(
      List<ListItem> dropdownItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in dropdownItems) {
      items.add(DropdownMenuItem(
        child: Text(listItem.name),
        value: listItem,
      ));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names

    return Scaffold(
      appBar: AppBar(
        title: const Text("Input"),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _high,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixText: "cm",
                  labelText: "ส่วนสูง",
                ),
                // onChanged: (value) {
                //   setState(() {});
                // }
              ),
              TextFormField(
                controller: _weight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixText: "Kg",
                  labelText: "น้ำหนัก",

                ),
                //  onChanged: (value) {
                //   setState(() {});
                // }
              ),
              // TextField(
              //   keyboardType:
              //       const TextInputType.numberWithOptions(decimal: true),
              //   decoration: const InputDecoration(labelText: 'Height (m)'),
              //   controller: _high,
              // ),
              // TextField(
              //   keyboardType:
              //       const TextInputType.numberWithOptions(decimal: true),
              //   decoration: const InputDecoration(
              //     labelText: 'Weight (kg)',
              //   ),
              //   controller: _weight,
              // ),

              ElevatedButton(
                onPressed: _calculate,
                child: const Text('Calculate'),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _bmi == null ? 'No Result' : _bmi!.toStringAsFixed(2),
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _message,
                textAlign: TextAlign.center,
              ),

              const Text("Gender"),
              RadioListTile(
                title: Text("Male"),
                value: 1,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text("Female"),
                value: 2,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text("Other"),
                value: 3,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              RadioListTile(
                title: Text("Not Specify"),
                value: 4,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              Column(
                children: createFruitCheckbox(),
              ),
               DropdownButton(
              value: _selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
                print(_selectedItem!.name);
                print(_selectedItem!.value);
              },
            ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createFruitCheckbox() {
    List<Widget> myfruit = [];

    for (Fruit fruit in fruits) {
      print(fruit.thName);
      myfruit.add(
        CheckboxListTile(
          title: Text(fruit.engName),
          subtitle: Text(fruit.thName),
          value: fruit.isCheck,
          onChanged: (value) {
            setState(() {
              fruit.isCheck = value!;
            });
          },
        ),
      );
    }

    return myfruit;
  }
}

class Fruit {
  String engName;
  String thName;
  bool isCheck;

  Fruit(this.engName, this.thName, this.isCheck);

  static List<Fruit> getFruit() {
    return <Fruit>[
      Fruit("Apple", "แอปเปิ้ล", false),
      Fruit("Banana", "กล้วย", false),
      Fruit("Orange", "ส้ม", true),
      Fruit("Papaya", "มะละกอ", false),
      Fruit("Coconut", "มะพร้าว", false),
      Fruit("Pineapple", "สับปะรด", false),
    ];
  }
  
}
class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}