import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(text: 'one'),
    Tab(text: 'two'),
  ];

  int _tabIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    DefaultTabController(
                      length: 2,
                      child: TabBar(
                        labelColor: Colors.redAccent,
                        tabs: myTabs,
                        onTap: (value) {
                          setState(() {
                            _tabIndex=value;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: [
                        Text('First tab'),
                        Column(
                          children:
                              List.generate(20, (index) => Text('line: $index',style: TextStyle(fontSize: 30),))
                                  .toList(),
                        ),
                      ][_tabIndex],
                    ),
                  ],
                ),
              ),
              Container(child: Text('another component')),
            ],
          ),
        ),
      ),
    );
  }
}
