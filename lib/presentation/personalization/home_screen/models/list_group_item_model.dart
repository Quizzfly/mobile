import 'package:equatable/equatable.dart';
import '../../../../../core/app_export.dart';

/// This class is used in the [list_group_item_widget] screen.
// ignore_for_file: must_be_immutable
class ListGroupItemModel extends Equatable {
  ListGroupItemModel({this.image, this.title, this.id, this.role}) {
    image = image ?? ImageConstant.imgNotFound;
    title = title ?? "Your group";
    id = id ?? "";
    role = role ?? "";
  }
  String? image;
  String? title;
  String? id;
  String? role;
  ListGroupItemModel copyWith({
    String? image,
    String? title,
    String? id,
    String? role,
  }) {
    return ListGroupItemModel(
      image: image ?? this.image,
      title: title ?? this.title,
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [image, title, id, role];
}
