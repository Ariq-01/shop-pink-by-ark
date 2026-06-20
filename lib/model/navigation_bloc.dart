import 'package:flutter_bloc/flutter_bloc.dart';

// Navigation Events
abstract class NavigationEvent {}

class NavigationTabChanged extends NavigationEvent {
  final int index;
  NavigationTabChanged(this.index);
}

// Navigation States
class NavigationState {
  final int selectedIndex;
  NavigationState(this.selectedIndex);
}

// Navigation Bloc
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(0)) { // Default to Home page (index 0)
    on<NavigationTabChanged>((event, emit) {
      emit(NavigationState(event.index));
    });
  }
}
