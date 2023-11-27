import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../model/memo.dart';
import '../../../util/format_time.dart';

class AlarmLogCard extends StatelessWidget {
  final Memo memo;

  const AlarmLogCard({super.key, required this.memo});

  @override
  Widget build(BuildContext context) {
    Duration duration = memo.stoppedAt.difference(memo.createdAt);
    String cumTime = FormatTime.formatDurationToTime(duration);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/image/feeling/${memo.satisfaction}.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      memo.satisfaction,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gaps.h20,
            SizedBox(
              height: 80,
              width: 160,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "바로 시작하지 않은 이유",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v4,
                    Flexible(
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                            text: memo.content != ""
                                ? memo.content
                                : "지금 바로 집중하지 않은 이유",
                            style: const TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FormatTime.formatDatetime(memo.createdAt),
                    style: const TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Gaps.v5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.access_time, size: 20),
                      Gaps.h4,
                      Text(cumTime,
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
