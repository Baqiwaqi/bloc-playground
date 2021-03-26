part of 'todos_bloc.dart';

// The three states we will implement are:

// TodosLoadInProgress - the state while our application is fetching todos from the repository.
// TodosLoadSuccess - the state of our application after the todos have successfully been loaded.
// TodosLoadFailure - the state of our application if the todos were not successfully loaded.

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}


class TodosLoadInProgress extends TodosState {}

class TodosLoadIsSuccess extends TodosState {
  final List<Todo> todos;

  const TodosLoadIsSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodosLoadFailure extends TodosState {}