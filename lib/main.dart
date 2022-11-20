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
        colorSchemeSeed: Colors.blue,
      ),
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
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              labelColor: Theme.of(context).colorScheme.primary,
              tabs: buildTabs(),
            )),
        body: SafeArea(
          bottom: false,
          child: TabBarView(children: buildTabViews()),
        ),
      ),
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

  List<Widget> buildTabViews() {
    final tabVs = <Widget>[];
    for (int i = 0; i < maxTabNumber; i++) {
      tabVs.add(Center(child: Text('Tab-${i + 1}')));
    }
    return tabVs;
  }

  List<Step> buildSteps() {
    final steps = <Step>[];
    for (int i = 0; i < maxTabNumber; i++) {
      steps.add(
        Step(
          title: Text('Number ${i + 1} item'),
          subtitle: Text(
              'This is number ${i + 1} item. tap one! Check if Scroll works good. '),
          content: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Item ${i + 1} - 0'),
                Text('Item ${i + 1} - 1'),
                Text('Item ${i + 1} - 2'),
              ],
            ),
          ),
          isActive: index == i,
          state: (index == i)
              ? StepState.editing
              : (i > index)
                  ? StepState.indexed
                  : StepState.complete,
        ),
      );
    }
    return steps;
  }
}
