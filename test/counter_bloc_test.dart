import 'package:direct_navigation/bloc/bloc.dart';
import 'package:direct_navigation/cubit/counter_cubit.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CounterBloc', () {
    CounterCubit counterCubit;

    // Let's start by creating an instance of our CounterBloc
    setUp(() {
      counterCubit = CounterCubit();
    });

    // ow we can start writing our individual tests.    
    test('initial state is 0', () {
      expect(counterCubit.state, 0);
    });

    //bloc test
    blocTest(
      'emits [1] when increment is added', 
      build: () => counterCubit,
      act: (bloc) => bloc.add(CounterCubit().increment),
      expect: () => [1],
    );

    blocTest(
      'emits [-1] decrement is added',
       build: () => counterCubit,
       act: (bloc) => bloc.add(CounterCubit().decrement),
       expect: () => [-1],
    );
    
  });
}