import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:direct_navigation/models/models.dart'; //models
import 'package:equatable/equatable.dart';

import 'package:todos_repository_simple/todos_repository_simple.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc({@required this.todosRepository}) : super(TodosLoadInProgress());

  final TodosRepositoryFlutter todosRepository;

// The events we will need to handle in our TodosBloc are:

// TodosLoadSuccess - tells the bloc that it needs to load the todos from the TodosRepository.
// TodoAdded - tells the bloc that it needs to add a new todo to the list of todos.
// TodoUpdated - tells the bloc that it needs to update an existing todo.
// TodoDeleted - tells the bloc that it needs to remove an existing todo.
// ClearCompleted - tells the bloc that it needs to remove all completed todos.
// ToggleAll - tells the bloc that it needs to toggle the completed state of all todos.

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is TodosLoadSuccess) {
      yield* _mapTodosLoadedToState();
    } 
    else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    }
    else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    }
    else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    }
    else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    }
    else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  //loadSucces
  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await this.todosRepository.loadTodos();
      yield TodosLoadIsSuccess(
        todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      yield TodosLoadFailure();
    }
  }

  //todoAdded
  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadIsSuccess) {
      final List<Todo> updatedTodos =
          List.from((state as TodosLoadIsSuccess).todos)..add(event.todo);
      yield TodosLoadIsSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  //Update
  Stream<TodosState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodosLoadIsSuccess) {
      final List<Todo> updatedTodos =
          (state as TodosLoadIsSuccess).todos.map((todo) {
        // return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      yield TodosLoadIsSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  //deleted
  Stream<TodosState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodosLoadIsSuccess) {
      final updatedTodos = (state as TodosLoadIsSuccess)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoadIsSuccess(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  //toggleAll
  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoadIsSuccess) {
      final allComplete =
        (state as TodosLoadIsSuccess).todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = (state as TodosLoadIsSuccess)
        .todos
        .map((todo) => todo.copyWith(complete: !allComplete))
        .toList();
      yield TodosLoadIsSuccess(updatedTodos);
      _saveTodos(updatedTodos);    
    }
  }

  //clear completed
  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoadIsSuccess) {
      final List<Todo> updateTodos = (state as TodosLoadIsSuccess)
        .todos
        .where((todo) => !todo.complete)
        .toList();
      yield TodosLoadIsSuccess(updateTodos);
  	  _saveTodos(updateTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(todos.map((todo) {
      return todo.toEntity();
    }).toList());
  }
}
