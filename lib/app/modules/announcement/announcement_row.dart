import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Material(
      color: Colors.white,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          Get.toNamed('/post/${announcement.postId}');
        },
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16,),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: ScreenUtils.ratioWidth(context, 80),
                    height: ScreenUtils.ratioWidth(context, 80),
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
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F82F4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        announcement.subscriptionState,
                        style: const TextStyle(
                          fontFamily: 'pl_light',
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: ScreenUtils.ratioWidth(context, 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        announcement.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            announcement.periodText,
                            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                          ),
                          Text(
                            announcement.recruitingText,
                            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
        ),
      ),
    );
  }
}
