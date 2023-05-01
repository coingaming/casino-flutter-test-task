import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  const GetTestDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class RetryDataFetchOnMainPageEvent extends MainPageEvent {
  final BuildContext context;

  RetryDataFetchOnMainPageEvent(this.context);

  @override
  List<Object?> get props => [context];
}
