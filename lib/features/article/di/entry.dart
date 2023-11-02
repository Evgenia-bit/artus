import 'package:artus/features/app/di/i_app_assembly.dart';
import 'package:artus/features/article/data/article_repository.dart';
import 'package:artus/features/article/di/assembly.dart';
import 'package:artus/features/article/domain/use_case.dart';
import 'package:artus/features/article/presentation/article_failure_displayer.dart';
import 'package:artus/features/article/presentation/widget_component.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class ArticleEntry extends StatefulWidget {
  const ArticleEntry({
    required this.appAssembly,
    required this.articleId,
    super.key,
  });

  final IAppAssembly appAssembly;
  final int articleId;

  @override
  State<ArticleEntry> createState() => _ArticleEntryState();
}

class _ArticleEntryState extends State<ArticleEntry>
    implements IArticleAssembly {
  late final ArticleRepository _repository;

  @override
  void initState() {
    _repository = ArticleRepository(
      articleId: widget.articleId,
      api: widget.appAssembly.articlesApi,
      mapper: widget.appAssembly.mapper,
      logger: widget.appAssembly.logger,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ArticleWidgetComponent(
        loadArticleUseCase: loadArticleUseCase,
        failureDisplayer: failureDisplayer,
      );

  @override
  LoadArticleUseCase get loadArticleUseCase => _repository;

  @override
  FailureDisplayer get failureDisplayer =>
      ArticleFailureDisolayer(widget.appAssembly.messageController);
}
