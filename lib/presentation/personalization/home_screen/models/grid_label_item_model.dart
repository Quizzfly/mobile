import 'package:equatable/equatable.dart';
import '../../../../../core/app_export.dart';

/// This class is used in the [grid_label_item_widget] screen.
// ignore_for_file: must_be_immutable
class GridLabelItemModel extends Equatable {
  GridLabelItemModel({this.image, this.label, this.id}) {
    image = image ?? ImageConstant.imgNotFound;
    label = label ?? "Your group";
    id = id ?? "";
  }
  String? image;
  String? label;
  String? id;
  GridLabelItemModel copyWith({
    String? image,
    String? label,
    String? id,
  }) {
    return GridLabelItemModel(
      image: image ?? this.image,
      label: label ?? this.label,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [image, label, id];
}
