import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';
import '../models/notification_model.dart';
import '../bloc/home_bloc.dart';

class NotificationPopup extends StatelessWidget {
  final VoidCallback? onReadAll;
  final VoidCallback? onSeeMore;
  final Function(NotificationModel)? onNotificationTap;

  const NotificationPopup({
    super.key,
    this.onReadAll,
    this.onSeeMore,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      constraints: const BoxConstraints(maxHeight: 600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const Divider(height: 1),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final notifications =
                  state.homeInitialModelObj?.notificationItemList ?? [];
              return _buildNotificationList(notifications);
            },
          ),
          const Divider(height: 1),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Notification',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: onReadAll,
            child: Text(
              'Read all',
              style: TextStyle(
                color: appTheme.deppPurplePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationModel> notifications) {
    if (notifications.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('No notifications'),
        ),
      );
    }

    return Flexible(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _NotificationTile(
            notification: notification,
            onTap: () => onNotificationTap?.call(notification),
          );
        },
      ),
    );
  }

  Widget _buildFooter() {
    return TextButton(
      onPressed: onSeeMore,
      child: Text(
        'Close',
        style: TextStyle(
          color: appTheme.deppPurplePrimary,
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const _NotificationTile({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isRead == true ? Colors.white : Colors.blue[50],
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(notification.avatar ?? ''),
            onBackgroundImageError: (_, __) {
              // Handle error loading image
            },
          ),
          title: Text(
            notification.name ?? 'Unnamed',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.notificationType == "POST"
                    ? "A new post have been created in your group"
                    : "${notification.name} commented to your post.",
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notification.notificationType == "COMMENT"
                        ? notification.description!
                        : "",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    notification.date ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}
