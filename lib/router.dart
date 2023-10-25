import 'package:api/api.dart';
import 'package:artus/features/article/data/article_repository.dart';
import 'package:artus/features/article/presentation/widget_component.dart';
import 'package:artus/features/article_list/data/article_list_repository.dart';
import 'package:artus/features/article_list/presentation/widget_component.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          final repository = ArticleListRepository(currentPage: 0);
          return ArticleListWidgetComponent(
            incrementCurrentPageUseCase: repository,
            getCurrentPageUseCase: repository,
            getScrollControllerUseCase: repository,
            loadArticlesUseCase: repository,
            getArticlesCountUseCase: repository,
          );
        },
        routes: [
          GoRoute(
            path: 'article/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null) {
                return const SizedBox.shrink();
              }
              final repository = ArticleRepository(articleId: id, api: ArticlesApi());
              return ArticleWidgetComponent(
                getArticleBlocksUseCase: repository,
              );
            },
          ),
        ]),
  ],
);