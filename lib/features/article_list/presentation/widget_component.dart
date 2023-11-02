import 'package:artus/features/article_list/domain/models/article_list_item.dart';
import 'package:artus/features/article_list/domain/use_case.dart';
import 'package:artus/features/article_list/presentation/article_list_component.dart';
import 'package:artus/features/article_list/presentation/view.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class ArticleListWidgetComponent extends StatefulWidget {
  const ArticleListWidgetComponent({
    required this.incrementCurrentPageUseCase,
    required this.loadArticleListUseCase,
    required this.getArticlesCountUseCase,
    required this.failureDisplayer,
    super.key,
  });

  final IncrementCurrentPageUseCase incrementCurrentPageUseCase;
  final LoadArticleListUseCase loadArticleListUseCase;
  final GetArticlesCountUseCase getArticlesCountUseCase;
  final FailureDisplayer failureDisplayer;

  @override
  State createState() => _ArticleListWidgetComponentState();
}

class _ArticleListWidgetComponentState
    extends ComponentState<ArticleListWidgetComponent, ArticleListComponent>
    implements ArticleListComponent {
  @override
  WidgetView<ArticleListComponent> buildView(BuildContext context) {
    return ArticleListView(this);
  }

  @override
  void initState() {
    super.initState();
    _updateArticles();
    scrollController = ScrollController();
    scrollController.addListener(_loadPage);
  }

  @override
  late final ScrollController scrollController;

  @override
  List<ArticleListItem> articleList = [];

  @override
  Exception? failure;

  @override
  bool loading = true;

  Future<void> _loadPage() async {
    if (_isMaxScroll && !_isMaxArticlesCount) {
      widget.incrementCurrentPageUseCase.increment();
      await _updateArticles();
    }
  }

  Future<void> _updateArticles() async {
    final (newArticles, error) =
        await widget.loadArticleListUseCase.loadArticles();

    if (newArticles != null) {
      articleList.addAll(newArticles);
    }

    failure = error;
    loading = false;

    setState(() {});

    if (failure != null) {
      await widget.failureDisplayer.display(context, failure!);
    }
  }

  bool get _isMaxScroll =>
      scrollController.position.pixels ==
      scrollController.position.maxScrollExtent;

  bool get _isMaxArticlesCount =>
      widget.getArticlesCountUseCase.articlesCount == articleList.length;
}
