import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _hcontroller = TextEditingController();
  final TextEditingController _wcontroller = TextEditingController();
  double a = 0.0, h = 0.0, w = 0.0, bmr = 0.0, calories = 0.0;
  String genderDropdown = 'Female';
  String activityDropdown = 'Little or no exercise';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('BMR Calculator'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/BMR.png',scale: 3.5,),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Container(
                child: Text('Choose your gender:'),
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: DropdownButton<String>(
                value: genderDropdown,
                icon: Icon(Icons.arrow_drop_down,
                color: Color.fromRGBO(0, 156, 171, 1),),
                iconSize: 30,
                elevation: 20,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    genderDropdown = newValue;
                  });
                },
                items: <String>['Female', 'Male']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                controller: _acontroller,
                decoration: InputDecoration(
                  hintText: "Age",
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
             Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                controller: _hcontroller,
                decoration: InputDecoration(
                  hintText: "Height (cm)",
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
             Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextField(
                controller: _wcontroller,
                decoration: InputDecoration(
                  hintText: "Weight (kg)",
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
            Container(
              child: Text('Choose your activity level:'),
              alignment: Alignment.center,
            ),
            DropdownButton<String>(
              value: activityDropdown,
              icon: Icon(Icons.arrow_drop_down,
              color: Color.fromRGBO(0, 156, 171, 1),),
              iconSize: 30,
              elevation: 20,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String newValue) {
                setState(() {
                  activityDropdown = newValue;
                });
              },
              items: <String>[
                'Little or no exercise',
                'Lightly active (light exercise 1 - 3 days a week)',
                'Moderately active (moderate exercise 3 - 5 days a week)',
                'Very active (hard exercise 6 - 7 days a week)',
                'Super active (very hard exercise and a physical job)',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
             MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                  ),
              minWidth: 200,
              height: 35,
              child: Text('Calculate My BMR'),
              color: Color.fromRGBO(0, 156, 171, 1),
              textColor: Colors.black,
              elevation: 5,
              onPressed: _onPress,
            ),
            Text("Your BMR is $bmr and your "),
            Text("maintenance calories per day is $calories"),
          ],
        ),
      ),
    );
  }

  void _onPress() {
    setState(() {
      a = double.parse(_acontroller.text);
      h = double.parse(_hcontroller.text);
      w = double.parse(_wcontroller.text);

      bmr = (10 * w) + (6.25 * h) - (5 * a);

      if (genderDropdown == 'Female') {
        bmr = bmr - 161;
      } else if (genderDropdown == 'Male') {
        bmr = bmr + 5;
      }

      if (activityDropdown == 'Little or no exercise') {
        calories = bmr * 1.2;
      } else if (activityDropdown ==
          'Lightly active (light exercise 1 - 3 days a week)') {
        calories = bmr * 1.375;
      } else if (activityDropdown ==
          'Moderately active (moderate exercise 3 - 5 days a week)') {
        calories = bmr * 1.55;
      } else if (activityDropdown ==
          'Very active (hard exercise 6 - 7 days a week)') {
        calories = bmr * 1.725;
      } else {
        calories = bmr * 1.9;
      }
      calories = calories.roundToDouble();
    });
  }
}
