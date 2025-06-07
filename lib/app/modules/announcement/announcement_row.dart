import 'package:flutter/material.dart';
import '../../core/utils/screen_utils.dart';
import 'model/announcement_response.dart';

class AnnouncementRow extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementRow({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: ScreenUtils.ratioWidth(context, 75),
                height: ScreenUtils.ratioWidth(context, 75),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child:
                      announcement.hasImage
                          ? Image.network(
                            announcement.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.business,
                                  size: 30,
                                  color: Colors.grey[600],
                                ),
                              );
                            },
                          )
                          : Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.business,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                          ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  child: Text(
                    announcement.subscriptionState,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: ScreenUtils.ratioWidth(context, 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    announcement.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        announcement.periodText,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        announcement.recruitingText,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.notifications_rounded,
            size: 24,
            color: announcement.isPushAlarmRegistered
                ? Colors.red
                : Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
