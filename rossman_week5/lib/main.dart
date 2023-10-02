import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rossman Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDB = false;

  List<Customer> customers = [
    Customer('Julian', 'Jule', 100, 'Frequent'),
    Customer('Mary', 'Rose', 101, 'Occasional'),
    Customer('Scott', 'Phil', 102, 'Frequent'),
    Customer('Sara', 'Jil', 103, 'Spender'),
    Customer('Jimmy', 'Dean', 104, 'Occasional'),
    Customer('Rosemary', 'West', 105, 'Saver'),
    Customer('Bobby', 'Theo', 106, 'Spender'),
    Customer('Dorthy', 'Reed', 107, 'Spender'),
    Customer('William', 'Ned', 108, 'Frequent'),
    Customer('Sally', 'Barry', 109, 'Saver'),
  ];

  void _handleButtonPress(){
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDB = true;
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoadingItemsFromDB = false;
      });
    });
  }

  void _handleClear(){
    setState(() {
      pageFirstLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad ? 
        ElevatedButton(
          onPressed: _handleButtonPress,
          child: Text("Load Items From Database"),
        )
        : isLoadingItemsFromDB ? const Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Please wait")
          ],
        )
        : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: customers.map((customer) {
              return Padding(padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text('${customer.FirstName} ${customer.LastName}', style: TextStyle(fontSize: 20),), 
                  Text('ID: ${customer.CustomerID}'), 
                  Text('Customer Type: ${customer.Type}'),
                  Divider(),
                ],
              ),
            );
          },).toList(),
          ),
        ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if(!pageFirstLoad && !isLoadingItemsFromDB)
            FloatingActionButton(
              onPressed: _handleClear,
              tooltip: 'Clear Items',
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
  }
}

class Customer {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Customer(this.FirstName, this.LastName, this.CustomerID, this.Type);
}