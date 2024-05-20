
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/src/ui/categories.dart';
import 'package:todo_list/src/ui/login_screen.dart';
import 'package:todo_list/src/ui/task.dart';
import 'package:todo_list/src/utils/add_alert_dialog.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({required this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text('HomeScreen', style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: (){
              Logout();

            },
                icon: Icon(Icons.logout,
                  color: Colors.white,
                )
            )
          ],
          // centerTitle: true,
        ),

        body:PageView(
          controller: pageController,
          children: const <Widget>[
            Center(
              child: Tasks(),
            ),
            Center(
              child: Categories(),
            ),
          ],
        ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog();
            },
          );
        },
        child: const Icon(Icons.add,
          color: Colors.white,
        ),
      ),

    );
  }

  Future<dynamic> Logout() async {

    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}