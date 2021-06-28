part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitialState extends CounterState {}

class CounterPlusState extends CounterState {}

class CounterMinusState extends CounterState {}

