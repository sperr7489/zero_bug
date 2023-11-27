import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import 'download_path.dart';

Future<void> requestMediaLibraryPermission() async {
  try {
    PermissionStatus status = await Permission.mediaLibrary.status;

    if (!status.isGranted) {
      // 권한이 허용되지 않은 경우, 권한 요청
      await Permission.mediaLibrary.request();
    }

    await getPublicDownloadFolderPath().then((String filePath) async {
      final path = Directory(filePath);
      if (!await path.exists()) {
        await path.create(); // 폴더가 존재하지 않으면 생성
      }
    });

    // 추가적인 작업 수행 (권한 확인 후)
  } catch (e) {
    print(e.toString());
  }
}

Future<void> addMusicFile() async {
  // 저장소 접근 권한 확인
  if (await Permission.mediaLibrary.request().isGranted) {
    // 파일 탐색기를 열어 음악 파일 선택
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      // 파일 경로 가져오기
      String? filePath = result.files.single.path;
      // filePath를 사용하여 앱 내에서 음악 파일 추가 처리
    }
  }
}
