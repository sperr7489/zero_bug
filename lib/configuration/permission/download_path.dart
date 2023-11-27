import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getPublicDownloadFolderPath() async {
  String? downloadDirPath;

  // 만약 다운로드 폴더가 존재하지 않는다면 앱내 파일 패스를 대신 주도록한다.
  if (Platform.isAndroid) {
    downloadDirPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    Directory dir = Directory(downloadDirPath);

    if (!dir.existsSync()) {
      downloadDirPath = (await getExternalStorageDirectory())!.path;
    }
  } else if (Platform.isIOS) {
    // downloadDirPath = (await getApplicationSupportDirectory())!.path;
    downloadDirPath = (await getApplicationDocumentsDirectory()).path;
  }

  return downloadDirPath!;
}
