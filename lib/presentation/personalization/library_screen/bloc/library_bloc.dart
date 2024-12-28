import 'dart:async';
import 'package:equatable/equatable.dart';
import '../../../../data/models/library_quizzfly/get_library_quizzfly_resp.dart';
import '../../../../core/app_export.dart';
import '../../../../data/repository/repository.dart';
import '../models/library_model.dart';
import '../models/library_list_item_model.dart';
part 'library_event.dart';
part 'library_state.dart';

/// A bloc that manages the state of a Library according to the event that is dispatched to it.
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final _repository = Repository();
  var getLibraryResp = GetLibraryQuizzflyResp();

  LibraryBloc(super.initialState) {
    on<LibraryInitialEvent>(_onInitialize);
    on<CreateGetLibraryEvent>(_callGetLibrary);
    on<DeleteQuizzflyEvent>(_callDeleteQuizzflyApi);
  }

  Future<void> _onInitialize(
    LibraryInitialEvent event,
    Emitter<LibraryState> emit,
  ) async {
    try {
      add(CreateGetLibraryEvent(
        onGetLibrarySuccess: () {
        },
      ));

      emit(state.copyWith(
        libraryModelObj: state.libraryModelObj?.copyWith(
          libraryListItemList: [],
        ),
      ));
    } catch (e) {
      print('Error initializing library data: $e');
    }
  }

  FutureOr<void> _callGetLibrary(
    CreateGetLibraryEvent event,
    Emitter<LibraryState> emit,
  ) async {
    try {
      String? accessToken = PrefUtils().getAccessToken();

      await _repository.getLibraryQuizzfly(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ).then((value) async {
        getLibraryResp = value;
        _onGetLibrarySuccess(value, emit);
        event.onGetLibrarySuccess?.call();
      }).onError((error, stackTrace) {
        _onGetLibraryError();
        event.onGetLibraryError?.call();
      });
    } catch (e) {
      print('Error loading library: $e');
      _onGetLibraryError();
      event.onGetLibraryError?.call();
    }
  }

  void _onGetLibrarySuccess(
    GetLibraryQuizzflyResp resp,
    Emitter<LibraryState> emit,
  ) {
    final libraryItems = resp.data?.map((item) {
          final formattedDate = _formatDate(item.createdAt ?? "");
          return LibraryListItemModel.fromQuizzflyData(
            json: item.toJson(),
            formattedDate: formattedDate,
          );
        }).toList() ??
        [];

    emit(state.copyWith(
      libraryModelObj: state.libraryModelObj?.copyWith(
        libraryListItemList: libraryItems,
      ),
    ));
  }

  void _onGetLibraryError() {
    // Handle error state here
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return "Today";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
      } else {
        final months = (difference.inDays / 30).floor();
        return "$months ${months == 1 ? 'month' : 'months'} ago";
      }
    } catch (e) {
      return dateStr;
    }
  }

  FutureOr<void> _callDeleteQuizzflyApi(
    DeleteQuizzflyEvent event,
    Emitter<LibraryState> emit,
  ) async {
    String? accessToken = PrefUtils().getAccessToken();

    try {
      bool success = await _repository.deleteQuizzfly(
          headers: {'Authorization': 'Bearer $accessToken '}, id: event.id);
      if (success) {
        event.onDeleteQuizzflyEventSuccess?.call();
      } else {
        event.onDeleteQuizzflyEventError?.call();
      }
    } catch (error) {
      event.onDeleteQuizzflyEventError?.call();
    }
  }
}
