import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_coutup/data/count_data.dart';
import 'package:riverpod_coutup/provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print('MyHomePage rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ref.watch(titleProvider),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(
                messageProvider,
              ),
            ),
            Text(
              ref.watch(countDataPrivider).count.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    CountData countData = ref.read(countDataPrivider);
                    ref.read(countDataPrivider.state).update((state) {
                      return countData.copyWith(
                        count: countData.count + 1,
                        countUp: countData.countUp + 1,
                      );
                    });
                  },
                  tooltip: 'Increment',
                  child: const Icon(CupertinoIcons.plus),
                ),
                FloatingActionButton(
                  onPressed: () {
                    CountData countData = ref.read(countDataPrivider);
                    ref.read(countDataPrivider.state).update((state) {
                      return countData.copyWith(
                        count: countData.count - 1,
                        countDown: countData.countDown + 1,
                      );
                    });
                  },
                  tooltip: 'Increment',
                  child: const Icon(CupertinoIcons.minus),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(ref.watch(countDataPrivider).countUp.toString()),
                Text(ref.watch(countDataPrivider).countDown.toString()),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countDataPrivider.state).update((state) {
            return const CountData(count: 0, countUp: 0, countDown: 0);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
