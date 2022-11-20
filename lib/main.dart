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
      title: 'Scroll Problem',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorSchemeSeed: Colors.blue),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Scroll Problem'),
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
  int index = 0;
  final int maxTabNumber = 15;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: maxTabNumber,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
              title: Text(widget.title),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Theme.of(context).colorScheme.surfaceTint,
                labelColor: Theme.of(context).colorScheme.primary,
                tabs: buildTabs(),
              )),
          body: SafeArea(
            bottom: false,
            child: TabBarView(children: buildTabViews(context)),
          ),
        );
      }),
    );
  }

  List<Tab> buildTabs() {
    final tabs = <Tab>[];
    for (int i = 0; i < maxTabNumber; i++) {
      tabs.add(Tab(
        text: 'No. ${i + 1}',
      ));
    }
    return tabs;
  }

  List<Widget> buildTabViews(BuildContext context) {
    final tabVs = <Widget>[];
    for (int i = 0; i < maxTabNumber; i++) {
      tabVs.add(Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Tab-${i + 1}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  var c = DefaultTabController.of(context);
                  if (c == null) return;
                  int index = c.index;
                  if (index == maxTabNumber - 1) return;
                  c.animateTo(index + 1);
                },
                child: const Text('Next'),
              ),
              TextButton(
                  onPressed: () {
                    var c = DefaultTabController.of(context);
                    if (c == null) return;
                    int index = c.index;
                    if (index == 0) return;
                    c.animateTo(index - 1);
                  },
                  child: const Text('Back')),
            ],
          ),
        ],
      )));
    }
    return tabVs;
  }
}
