import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:direct_navigation/bloc/bloc.dart';

import 'package:direct_navigation/models/models.dart';
import 'package:direct_navigation/models/visibility_filter.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  FilteredTodosBloc(this.todosBloc)
      : super(
          todosBloc.state is TodosLoadSuccess // TodosLoadIsSucces
              ? FilteredTodosLoadSuccess(
                  (todosBloc.state as TodosLoadIsSuccess).todos,
                  VisibilityFilter.all)
              : FilteredTodosLoadInProgress(),
        ) {
    todosSubscribtion = todosBloc.stream.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadIsSuccess).todos));
      }
    });
  }

  final TodosBloc todosBloc;
  StreamSubscription todosSubscribtion;

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    }
  }

  @override
  Stream<FilteredTodosState> _mapUpdateFilterToState(
      FilterUpdated event) async* {
    if (todosBloc.state is TodosLoadSuccess) {
      yield FilteredTodosLoadSuccess(
          _mapTodosToFilteredTodos(
            (todosBloc.state as TodosLoadIsSuccess).todos,
            event.filter,
          ),
          event.filter);
    }
  }

  Stream<FilteredTodosState> _mapTodosUpdateToState(
      TodosUpdated event) async* {
        final VisibilityFilter = state is FilteredTodosLoadSuccess
        ? 
      }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }
}
