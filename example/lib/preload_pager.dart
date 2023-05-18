import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnPageChanged = void Function(int page, int previousPage);

class PreloadPager extends StatefulWidget {
  const PreloadPager({
    super.key,
    required this.children,
    this.onPageChanged,
    this.preloadSize = 0,
  });

  final List<Widget> children;
  final OnPageChanged? onPageChanged;
  final int preloadSize;

  @override
  State<PreloadPager> createState() => _PreloadPagerState();
}

class _PreloadPagerState extends State<PreloadPager> {
  int _lastReportedPage = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            widget.onPageChanged != null &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page!.round();
          if (currentPage != _lastReportedPage) {
            widget.onPageChanged!(currentPage, _lastReportedPage);
            _lastReportedPage = currentPage;
          }
        }
        return false;
      },
      child: Scrollable(
        physics: const PageScrollPhysics(),
        controller: pageController,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        viewportBuilder: (context, position) {
          return Viewport(
            offset: position,
            cacheExtent: widget.preloadSize.toDouble(),
            cacheExtentStyle: CacheExtentStyle.viewport,
            slivers: [
              SliverFillViewport(
                delegate: SliverChildListDelegate(widget.children),
              ),
            ],
          );
        },
      ),
    );
  }
}
