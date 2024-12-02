import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../library_collections_screen/models/library_collections_model.dart';
import '../models/library_collections_grid_item_model.dart';
part 'library_collections_event.dart';
part 'library_collections_state.dart';

/// A bloc that manages the state of a LibraryCollections according to the event that is dispatched to it.
class LibraryCollectionsBloc
    extends Bloc<LibraryCollectionsEvent, LibraryCollectionsState> {
  LibraryCollectionsBloc(super.initialState) {
    on<LibraryCollectionsInitialEvent>(_onInitialize);
  }
  _onInitialize(
    LibraryCollectionsInitialEvent event,
    Emitter<LibraryCollectionsState> emit,
  ) async {
    emit(
      state.copyWith(
        libraryCollectionsModelObj: state.libraryCollectionsModelObj?.copyWith(
          libraryCollectionsGridItemList: fillLibraryCollectionsGridItemList(),
        ),
      ),
    );
  }

  List<LibraryCollectionsGridItemModel> fillLibraryCollectionsGridItemList() {
    return [
      LibraryCollectionsGridItemModel(educationTwo: "Education"),
      LibraryCollectionsGridItemModel(educationTwo: "Education"),
      LibraryCollectionsGridItemModel(educationTwo: "Education"),
      LibraryCollectionsGridItemModel(educationTwo: "Education"),
      LibraryCollectionsGridItemModel(educationTwo: "Education"),
      LibraryCollectionsGridItemModel(educationTwo: "Education"),
      LibraryCollectionsGridItemModel(educationTwo: "Education")
    ];
  }
}
