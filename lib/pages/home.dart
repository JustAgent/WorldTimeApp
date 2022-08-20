import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data =  data.isNotEmpty? data : ModalRoute.of(context)?.settings.arguments as Map;
    String bgImage = data['isDaytime'] ? 'day.jpeg' : 'night1.jpeg';
    var textColor = data['isDaytime'] ? Colors.black : Colors.white;
    var bgColor = data['isDaytime'] ? Colors.lightBlue[500] : Colors.black;
    print('data = $data');

    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDaytime': result['isDaytime'],
                        };
                      });
                      },

                    icon:  Icon(Icons.edit_location, color: textColor),
                    label: Text('Edit location',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style:  TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                        color: textColor,
                      ),
                    )
                  ],
                ),
              SizedBox(height: 20),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 60,
                  color: textColor,
                ),
              ),
              ],
            ),
          ),
        )
      )
    );
  }
}
