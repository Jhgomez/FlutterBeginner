import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

}

/* Code to display a simple dialog */
enum Answers{YES, NO, MAYBE}

class _MyAppState extends State<MyApp> {
  String _text = 'Hello';
  String _input = '';

  void setNewText() {
    setState(() =>_text = DateTime.now().toString());
  }

  void onChange(String value) {
    setState(() => _input = 'Change: $value' );
  }

  void onSubmit(String value) {
    setState(() => _input = 'Submit: $value' );
  }

  bool? _selected = false;

  void toggleSelectionState(bool? isSelected) => setState(() => _selected = isSelected);

  bool? _isTileSelected = false;

  void toggleTileState(bool? isSelected) => setState(() => _isTileSelected = isSelected);

  int? _selectedRadio = 0;

  void setSelectedRadio(int? selected) => setState(() => _selectedRadio = selected);

  Widget makeRadios() {
    List<Widget> radios = <Widget>[];
    for(int i = 0; i<3 ; i++) {
      radios.add(
        Radio(value: i, groupValue: _selectedRadio, onChanged: setSelectedRadio)
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: radios,
    );
  }

  int? _selectedTileRadio = 0;

  void setSelectedTileRadio(int? selected) => setState(() => _selectedTileRadio = selected);

  Widget makeTileRadios() {
    List<Widget> radios = <Widget>[];
    for(int i = 0; i<3 ; i++) {
      radios.add(
        RadioListTile(
          value: i,
          groupValue: _selectedTileRadio,
          onChanged: setSelectedTileRadio,
          activeColor: Colors.green,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('Item: $i'),
          subtitle: const Text('sub title')
          )
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: radios,
    );
  }

  bool isSwitchOn = false;

  void toggleSwitch(bool isSelected) => setState(() => isSwitchOn = isSelected);

  bool isTileSwitchOn = false;

  void toggleTileSwitch(bool isSelected) => setState(() => isTileSwitchOn = isSelected);

  double _sliderProgress = 0;

  void setSliderProgress(double progress) => setState(() => _sliderProgress = progress);

  String date = '';
  
  Future selectedDate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      firstDate: DateTime(2020), 
      lastDate: DateTime(2024, 12, 31),
      initialDate: DateTime.now()
      );
    
    if (picked != null) setState(() => date = picked.toString());
  }

  late List<NavigationDestination> navigationItems;

  @override
  void initState() {
    super.initState();
    navigationItems = <NavigationDestination>[];
    navigationItems.add(const NavigationDestination(icon: Icon(Icons.people), label: 'People'));
    navigationItems.add(const NavigationDestination(icon: Icon(Icons.weekend), label: 'Weekend'));
    navigationItems.add(const NavigationDestination(icon: Icon(Icons.message), label: 'Message'));
  }

  int _navigationIndex = 0;

/* This function can show a bottom sheet **/
  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (myContext) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Some info here",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold
                  )
                ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close")
                )
            ],
          ),
        );
      }
      );
  }

  /* Global keys can be accessed anywhere in the application, and we previously needed
  them to display a snack bar but not any more */
  // final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  /* Code use to show a snack bar*/
  void showSnackBar() {
    // Previously we needed a scaffold state key to display a snack bar
    // _scaffoldState.currentState.showSnackBar(SnackBar(content: content));

    ScaffoldMessenger
      .of(context)
      .showSnackBar(
       SnackBar(
          content: const Text('My first snack bar'),
          action: SnackBarAction(
            label: 'Undo', 
            onPressed: () {}
            ),
          )
        );
  }

  /* Code used to show alert dialog */
  Future showAlert(BuildContext context, String message) async {
    return showDialog(
      context: context, 
      builder: ((context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('Ok'))
          ],
        );
      }
      )
    );
  }

  /* Code to display a simple dialog in a practical context*/

  String answer = '';

  void setAnswer(String choice) => setState(() => answer = choice);

  Future askUser() async {
    switch(
      await showDialog(
        context: context,
        builder: (context) {
          return  SimpleDialog(
            title: Text('Do you like flutter?'),
            children: <Widget>[
               SimpleDialogOption(
                child: Text('Yes !!!'),
                onPressed: () => {
                  Navigator.pop(context, Answers.YES)
                },
              ),
              SimpleDialogOption(
                child: Text('NO !!!'),
                onPressed: () => {
                  Navigator.pop(context, Answers.NO)
                },
              ),
              SimpleDialogOption(
                child: Text('Maybe !!!'),
                onPressed: () => {
                  Navigator.pop(context, Answers.MAYBE)
                },
              )
            ],
          );
        }
        )
    ) {
      case Answers.YES: 
        setAnswer(Answers.YES.name);
        break;
      case Answers.NO: 
        setAnswer(Answers.NO.name);
        break;
      case Answers.MAYBE: 
        setAnswer(Answers.MAYBE.name);
        break;
    }
  }

  /* This is how to capture input "the easy way" */
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("My First Text"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: <Widget>[
        IconButton(onPressed: () {}, icon: Icon(Icons.add))
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      mini: true,
      backgroundColor: Colors.red,
      child: Icon(Icons.add),
    ),
    drawer: Drawer(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            const Text('Hello Drawer'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
               child: const Text("Close")
               )
          ]
          ),
      ),
    ),
    body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(_text),
                ElevatedButton(
                  onPressed: () => setNewText(),
                  child: const Text('Change')
                  ),
                  IconButton(icon: Icon(Icons.add), onPressed: setNewText),
                  Text(_input),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Hello',
                      hintText: 'Hint',
                      icon: Icon(Icons.people)
                    ),
                    autocorrect: true,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: onChange,
                    onSubmitted: onSubmit,
                  ),
                  Checkbox(value: _selected, onChanged: toggleSelectionState),
                  CheckboxListTile(
                    value: _isTileSelected,
                    onChanged: toggleTileState,
                    title: const Text('Toggle it'),
                    controlAffinity: ListTileControlAffinity.trailing,
                    subtitle: const Text("Me again"),
                    secondary: Icon(Icons.archive),
                    activeColor: Colors.blue,
                    ),
                    makeRadios(),
                    makeTileRadios(),
                    Switch(value: isSwitchOn, onChanged: toggleSwitch),
                    SwitchListTile(
                      value: isTileSwitchOn,
                      onChanged: toggleTileSwitch,
                      title: const Text(
                        'Meow', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                           color: 
                           Colors.purple
                           ),
                           ),
                           controlAffinity: ListTileControlAffinity.leading,
                      ),
                      Slider(value: _sliderProgress, onChanged: setSliderProgress),
                      Text(date),
                      ElevatedButton(onPressed: selectedDate, child: const Text('Display Calendar')),
                      ElevatedButton(onPressed: showBottom, child: const Text('Show Buttom Sheet')),
                      ElevatedButton(onPressed: showSnackBar, child: const Text('Show Snack Bar')),
                      ElevatedButton(onPressed: () => showAlert(context, 'Alert test'), child: const Text('Show Alert')),
                      Text(answer),
                      ElevatedButton(onPressed: askUser, child: const Text('Survey dialog')),
                      Row(
                        children: <Widget>[
                          const Text('Password:'),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0 , 0 , 0),
                              child: TextField(
                                controller: _password,
                                obscureText: true
                                )
                              ), 
                            ),
                        ],
                      )
                ]
              ),
            ) 
          ),
        ),
        persistentFooterButtons: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.timer)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.watch)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month))
        ],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _navigationIndex,
          destinations: navigationItems,
          onDestinationSelected: (int itemIndex) {
            setState(() {
              _navigationIndex = itemIndex;              
            });
          })
          
  );

}
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
