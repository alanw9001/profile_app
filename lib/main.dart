import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Pages { summary, name, phone, email, bio }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Application Profile',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: const ProfilePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var currentPage = Pages.summary;
  var name = 'Barry Bluejeans';
  var phone = '(123) 456-7890';
  var email = 'barry@blue.jeans';
  var bio = 'It\'sa me, Barry!';

  void updatePage(newPage) {
    currentPage = newPage;
    notifyListeners();
  }
  void updateName(text) {
    name = text;
    notifyListeners();
  }
  void updatePhone(text) {
    phone = text;
    notifyListeners();
  }
  void updateEmail(text) {
    email = text;
    notifyListeners();
  }
  void updateBio(text) {
    bio = text;
    notifyListeners();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    Widget page;
    switch (appState.currentPage) {
      case Pages.summary:
        page = SummaryPage();
      case Pages.name:
        page = NamePage();
      case Pages.phone:
        page = PhonePage();
      case Pages.email:
        page = EmailPage();
      case Pages.bio:
        page = BioPage();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
              color: Colors.white,
              child: page,
            ),
        );
      }
    );
  }
}

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SafeArea(
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Theme.of(context).primaryColorDark
              ),
            ),
          ),
          const SizedBox(height: 12),
          CircleAvatar(
            radius: 60,
            backgroundColor: Theme.of(context).primaryColorDark,
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/blank_profile_image.webp'),
              radius: 54,
            ),
          ),
          InkWell(
            child: ItemSection(title: 'Name', itemText: appState.name),
            onTap: () {
              appState.updatePage(Pages.name);
            },
          ),
          Divider(
            color: Colors.grey[250],
            indent: 30, endIndent: 30,
          ),
          InkWell(
            child: ItemSection(title: 'Phone', itemText: appState.phone),
            onTap: () {
              appState.updatePage(Pages.phone);
            },
          ),
          Divider(
            color: Colors.grey[250],
            indent: 30, endIndent: 30,
          ),
          InkWell(
            child: ItemSection(title: 'Email', itemText: appState.email),
            onTap: () {
              appState.updatePage(Pages.email);
            },
          ),
          Divider(
            color: Colors.grey[250],
            indent: 30, endIndent: 30,
          ),
          InkWell(
            child: ItemSection(title: 'Bio', itemText: appState.bio),
            onTap: () {
              appState.updatePage(Pages.bio);
            },
          ),
          Divider(
            color: Colors.grey[250],
            indent: 30, endIndent: 30,
          ),
        ],
      ),
    );
  }

}

class ItemSection extends StatelessWidget {
  const ItemSection({
    super.key,
    required this.title,
    required this.itemText
  });

  final String title;
  final String itemText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Text(
                  itemText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_sharp,
            color: Colors.grey[500],
          ),
        ],
      ),
    );
  }
}

class NamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var nameArray = appState.name.split(' ');
    var newName = List.filled(2, '');
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => appState.updatePage(Pages.summary),
              icon: const Icon(Icons.arrow_back),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'What\'s your name?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text('First Name'),
                        hintText: nameArray[0],
                      ),
                      onChanged: (val) => newName[0] = val,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text('Last Name'),
                        hintText: nameArray[1],
                      ),
                      onChanged: (val) => newName[1] = val,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: kToolbarHeight*2),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
                    shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                  ),
                  onPressed: () {
                    if (newName[0].isEmpty) newName[0] = nameArray[0];
                    if (newName[1].isEmpty) newName[1] = nameArray[1];
                    appState.updateName(newName.join(' '));
                    appState.updatePage(Pages.summary);
                  },
                  child: Text('Update')
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var newNumber = '';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => appState.updatePage(Pages.summary),
              icon: const Icon(Icons.arrow_back),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'What\'s your phone number?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text('Your phone number'),
                        hintText: appState.phone,
                      ),
                      onChanged: (val) => newNumber = val,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: kToolbarHeight*2),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                    ),
                    onPressed: () {
                      if (newNumber.isEmpty) newNumber = appState.phone;
                      appState.updatePhone(newNumber);
                      appState.updatePage(Pages.summary);
                    },
                    child: Text('Update')
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var newEmail = '';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => appState.updatePage(Pages.summary),
              icon: const Icon(Icons.arrow_back),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'What\'s your email?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text('Your email'),
                        hintText: appState.email,
                      ),
                      onChanged: (val) => newEmail = val,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: kToolbarHeight*2),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                    ),
                    onPressed: () {
                      if (newEmail.isEmpty) newEmail = appState.email;
                      appState.updateEmail(newEmail);
                      appState.updatePage(Pages.summary);
                    },
                    child: Text('Update')
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var newBio = '';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => appState.updatePage(Pages.summary),
              icon: const Icon(Icons.arrow_back),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Tell us about yourself. What made you want to apply here? What do you hope to find?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        label: Text('About you'),
                        hintText: appState.bio,
                      ),
                      onChanged: (val) => newBio = val,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: kToolbarHeight),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColorLight),
                      shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                    ),
                    onPressed: () {
                      if (newBio.isEmpty) newBio = appState.bio;
                      appState.updateBio(newBio);
                      appState.updatePage(Pages.summary);
                    },
                    child: Text('Update')
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}