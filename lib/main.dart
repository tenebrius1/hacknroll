import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/create': (context) => CreateRoom(),
        '/join': (context) => JoinRoom(),
        '/player': (context) => CreatePlayer(),
        '/lobby': (context) => Lobby(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        ),
      ),
    );
  }
}

class Data {
  String name;
  double amount;
  String roomName;
  String password;

  Data({this.amount, this.name, this.roomName, this.password});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chips'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: width,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/create');
                },
                child: const Text('Create New Room',
                    style: TextStyle(fontSize: 20)),
              ),
            ),
            ButtonTheme(
              minWidth: width,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/join');
                },
                child: const Text('Join Room', style: TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoom createState() => _CreateRoom();
}

class _CreateRoom extends State<CreateRoom> {
  final textController = TextEditingController();
  final textController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Room!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Room Name'),
              autofocus: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: textController1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ButtonTheme(
                minWidth: 200,
                child: RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () {
                    if (textController.text.isEmpty ||
                        textController1.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Please enter a room name 🥺'),
                          );
                        },
                      );
                    } else {
                      final data = Data(
                        roomName: textController.text,
                        password: textController1.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePlayer(
                                  data: data,
                                )),
                      );
                    }
                  },
                  child: const Text('Create', style: TextStyle(fontSize: 20)),
                )),
          ],
        ),
      ),
    );
  }
}

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoom createState() => _JoinRoom();
}

class _JoinRoom extends State<JoinRoom> {
  final textController = TextEditingController();
  final textController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join a room!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Room Name'),
              autofocus: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: textController1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ButtonTheme(
                minWidth: 200,
                child: RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () {
                    if (textController.text.isEmpty ||
                        textController1.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Please enter a room name 🥺'),
                          );
                        },
                      );
                    } else {
                      final data = Data(
                        roomName: textController.text,
                        password: textController1.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePlayer(
                                  data: data,
                                )),
                      );
                    }
                  },
                  child: const Text('Join!', style: TextStyle(fontSize: 20)),
                )),
          ],
        ),
      ),
    );
  }
}

class CreatePlayer extends StatelessWidget {
  final Data data;
  CreatePlayer({this.data});

  final textController = TextEditingController();
  final textController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.roomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
              autofocus: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: textController1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
            SizedBox(height: 30),
            ButtonTheme(
                minWidth: 200,
                child: RaisedButton(
                  onPressed: () {
                    if (textController.text.isEmpty ||
                        textController1.text.isEmpty ||
                        double.tryParse == null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                'Please fill up the name/amount correctly 🥺'),
                          );
                        },
                      );
                    } else {
                      FirebaseFirestore.instance.collection('players').add({
                        'Amount': double.parse(textController1.text),
                        'name': textController.text
                      });
                      Navigator.pushNamed(context, '/lobby');
                    }
                  },
                  child: const Text('Join!', style: TextStyle(fontSize: 20)),
                )),
          ],
        ),
      ),
    );
  }
}

class Lobby extends StatefulWidget {
  @override
  _Lobby createState() {
    return _Lobby();
  }
}

class _Lobby extends State<Lobby> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pressed = !pressed;
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('players').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.Amount.toString()),
            onTap: () => pressed
                ? null
                : record.reference.update({'Amount': FieldValue.increment(1)}),
            onLongPress: () => pressed
                ? null
                : record.reference
                    .update({'Amount': FieldValue.increment(-record.Amount)})),
      ),
    );
  }
}

class Record {
  final String name;
  final double Amount;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['Amount'] != null),
        name = map['name'],
        Amount = map['Amount'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$Amount>";
}
