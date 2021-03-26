part of 'filtered_todos_bloc.dart';

// FilterUpdated - which notifies the bloc that the visibility filter has changed
// TodosUpdated - which notifies the bloc that the list of todos has changed

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class FilterUpdated extends FilteredTodosEvent {
  const FilterUpdated(this.filter);
  final VisibilityFilter filter;

  @override
  List<Object> get props => [filter];

  @override
  String toString() {
    return 'Updatedfilter { updatedfilter: $filter ';
  }
}

class TodosUpdated extends FilteredTodosEvent {
  const TodosUpdated(this.todos);
  final List<Todo> todos;

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'Updated Todos : { updated todos $todos } ';
}
