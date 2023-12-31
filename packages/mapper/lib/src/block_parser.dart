import 'package:mapper/src/models/block_model.dart';
import 'package:mapper/src/models/failed_block_model.dart';
import 'package:mapper/src/models/heading_block_model.dart';
import 'package:mapper/src/models/image_block_model.dart';
import 'package:mapper/src/models/list_block_model.dart';
import 'package:mapper/src/models/paragraph_block_model.dart';
import 'package:mapper/src/models/video_block_model.dart';
import 'package:mapper/src/utils/safe_cast.dart';

class BlockParser {
  List<BlockModel> fromJson(List<Map<String, dynamic>> blocks) {
    return blocks.map((block) {
      final data = safeCast<Map<String, dynamic>>(block['data']);
      try {
        final model = _typeMap[block['type']]?.call(data);
        return model ?? FailedBlockModel();
      } catch (_) {
        return FailedBlockModel();
      }
    }).toList();
  }
}

final _typeMap = {
  'paragraph': CustomParagraphBlockModel.fromJson,
  'heading': CustomHeadingBlockModel.fromJson,
  'list': CustomListBlockModel.fromJson,
  'image': CustomImageBlockModel.fromJson,
  'video': CustomVideoBlockModel.fromJson,
};
