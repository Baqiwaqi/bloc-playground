import 'package:direct_navigation/bloc/bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CounterBloc', () {
    CounterBloc counterBloc;

    // Let's start by creating an instance of our CounterBloc
    setUp(() {
      counterBloc = CounterBloc();
    });

    // ow we can start writing our individual tests.    
    test('initial state is 0', () {
      expect(counterBloc.state, 0);
    });

    //bloc test
    blocTest(
      'emits [1] when increment is added', 
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterEvent.increment),
      expect: () => [1],
    );

    blocTest(
      'emits [-1] decrement is added',
       build: () => counterBloc,
       act: (bloc) => bloc.add(CounterEvent.decrement),
       expect: () => [-1],
    );
    
  });
}