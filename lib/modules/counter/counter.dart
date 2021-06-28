import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/counter_cubit.dart';

// ignore: must_be_immutable
class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: new Text("Number Count")),
            body: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                        fontSize: 60.0,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        CounterCubit.get(context).add();
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
