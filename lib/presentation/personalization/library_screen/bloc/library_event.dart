part of 'library_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// Library widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class LibraryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Library widget is first created.
class LibraryInitialEvent extends LibraryEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched to fetch library data
// ignore: must_be_immutable
class CreateGetLibraryEvent extends LibraryEvent {
  CreateGetLibraryEvent({
    this.id,
    this.onGetLibrarySuccess,
    this.onGetLibraryError,
  });

  Function? onGetLibrarySuccess;
  Function? onGetLibraryError;
  String? id;
  @override
  List<Object?> get props => [onGetLibrarySuccess, onGetLibraryError, id];
}

// ignore: must_be_immutable
class DeleteQuizzflyEvent extends LibraryEvent {
  DeleteQuizzflyEvent({
    this.id,
    this.onDeleteQuizzflyEventSuccess,
    this.onDeleteQuizzflyEventError,
  });

  Function? onDeleteQuizzflyEventSuccess;
  Function? onDeleteQuizzflyEventError;
  String? id;
  @override
  List<Object?> get props =>
      [onDeleteQuizzflyEventSuccess, onDeleteQuizzflyEventError, id];
}
