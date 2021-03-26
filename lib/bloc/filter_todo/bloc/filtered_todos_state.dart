part of 'filtered_todos_bloc.dart';

// FilteredTodosLoadInProgress - the state while we are fetching todos
// FilteredTodosLoadSuccess - the state when we are no longer fetching todos

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();
  
  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  const FilteredTodosLoadSuccess(
    this.filteredTodos, 
    this.activeFilter
  );

  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;
  
  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filtered: $filteredTodos, activeFilter $activeFilter ';
  }
}
