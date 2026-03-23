import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class AnimationListView extends StatefulWidget {
  const AnimationListView({super.key});

  @override
  State<AnimationListView> createState() => _AnimationListViewState();
}

enum ViewMode { list, grid, masonry, quilted }

class _AnimationListViewState extends State<AnimationListView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ViewMode _viewMode = ViewMode.list;
  final bool _isGlassMode = false;
  final Set<int> _expandedIndices = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: ViewMode.values.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _viewMode = ViewMode.values[_tabController.index];
          _expandedIndices.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Color> _colors = [
    Colors.purple.shade400,
    Colors.blue.shade400,
    Colors.teal.shade400,
    Colors.orange.shade400,
    Colors.pink.shade400,
    Colors.indigo.shade400,
    Colors.cyan.shade400,
    Colors.amber.shade400,
  ];

  // 26 Trending Unique GIFs sourced directly from Giphy Explore (https://giphy.com/explore/images)
  final List<String> _gifs = [
    'https://media.giphy.com/media/VRhsYYBw8AE36/giphy.gif',
    'https://media.giphy.com/media/nH9XnL1jf9gju/giphy.gif',
    'https://media.giphy.com/media/12xlmkGiCLPNcY/giphy.gif',
    'https://media.giphy.com/media/ebF0Vfj4TJo3u/giphy.gif',
    'https://media.giphy.com/media/iTOg0SvRhoTMk/giphy.gif',
    'https://media.giphy.com/media/APADxEYAkOaI0/giphy.gif',
    'https://media.giphy.com/media/M4OUDwYOB8FY4/giphy.gif',
    'https://media.giphy.com/media/fADf4RUs3hUFvHz18o/giphy.gif',
    'https://media.giphy.com/media/2QewZaD5sjQNa/giphy.gif',
    'https://media.giphy.com/media/Jn2l1wCoDLghG/giphy.gif',
    'https://media.giphy.com/media/jBGTKzZPffoZ2/giphy.gif',
    'https://media.giphy.com/media/vQvhB9YD2vLTG/giphy.gif',
    'https://media.giphy.com/media/yHLX7TSWuneg0/giphy.gif',
    'https://media.giphy.com/media/q9ovqCdLWJEME/giphy.gif',
    'https://media.giphy.com/media/OrIU3eNm3hLpe/giphy.gif',
    'https://media.giphy.com/media/fzbYrbFFULsoo/giphy.gif',
    'https://media.giphy.com/media/soRejObN6XcUo/giphy.gif',
    'https://media.giphy.com/media/4On0BLjQuL8YM/giphy.gif',
    'https://media.giphy.com/media/gdXRXxcllUdyw/giphy.gif',
    'https://media.giphy.com/media/LCgGJ0PBT04dW/giphy.gif',
    'https://media.giphy.com/media/3wPQiJa2tAB8c/giphy.gif',
    'https://media.giphy.com/media/131snIIcyKlUty/giphy.gif',
    'https://media.giphy.com/media/FuxpQNRSjoEZG/giphy.gif',
    'https://media.giphy.com/media/s2e72J0DIMls4/giphy.gif',
    'https://media.giphy.com/media/sME3mKM6Uim1W/giphy.gif',
    'https://media.giphy.com/media/5Ch2Z4c4FfFw4/giphy.gif',
  ];

  final double _staticMasonryHeight = 250.0;

  void _toggleExpanded(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  void _openDetail(int index, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(
          index: index,
          imageUrl: imageUrl,
          color: _colors[index % _colors.length],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          _viewMode == ViewMode.list
              ? 'Premium List'
              : (_viewMode == ViewMode.grid
                  ? 'Living Grid'
                  : (_viewMode == ViewMode.masonry
                      ? 'Dynamic Masonry'
                      : 'Quilted Suite')),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal, color: Colors.white),
          tabs: const [
            Tab(text: 'LIST'),
            Tab(text: 'GRID'),
            Tab(text: 'MASONRY'),
            Tab(text: 'QUILTED'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView(),
          _buildGridView(),
          _buildMasonryView(),
          _buildQuiltedView(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return AnimationLimiter(
      child: ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
        itemCount: 40,
        itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 100),
          child: SlideAnimation(
            verticalOffset: 120.0,
            curve: Curves.easeOutBack,
            child: ScaleAnimation(
              scale: 0.7,
              curve: Curves.easeOutBack,
              child: FadeInAnimation(child: _buildExpandableItem(index)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return AnimationLimiter(
      child: GridView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
        itemCount: 40,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 800),
          columnCount: 2,
          delay: const Duration(milliseconds: 100),
          child: FlipAnimation(
            flipAxis: FlipAxis.y,
            curve: Curves.easeOutBack,
            child: ScaleAnimation(
              scale: 0.8,
              curve: Curves.easeOutBack,
              child: FadeInAnimation(child: _buildGridItem(index)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMasonryView() {
    return AnimationLimiter(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildMasonryColumn(0)),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: _staticMasonryHeight / 2),
                child: _buildMasonryColumn(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMasonryColumn(int columnIndex) {
    return Column(
      children: List.generate(20, (i) {
        final index = i * 2 + columnIndex;
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 1000),
          columnCount: 2,
          delay: const Duration(milliseconds: 100),
          child: SlideAnimation(
            verticalOffset: 120.0,
            curve: Curves.easeOutBack,
            child: ScaleAnimation(
              scale: 0.5,
              curve: Curves.easeOutBack,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildMasonryItem(index,
                      isQuilted: false, customHeight: _staticMasonryHeight),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildQuiltedView() {
    return AnimationLimiter(
      child: ListView.builder(
        padding:
            const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 40),
        itemCount: 10,
        itemBuilder: (context, blockIndex) {
          final isEvenBlock = blockIndex % 2 == 0;
          final startIdx = blockIndex * 4;
          return LayoutBuilder(
            builder: (context, constraints) {
              final unitWidth = (constraints.maxWidth - 24) / 4;
              final blockHeight = unitWidth * 2 + 16;
              return SizedBox(
                height: blockHeight + 16,
                child: Stack(
                  children: isEvenBlock
                      ? _buildQuiltedBlockA(startIdx, unitWidth)
                      : _buildQuiltedBlockB(startIdx, unitWidth),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildQuiltedBlockA(int startIdx, double u) {
    return [
      _quiltedTile(startIdx, 0, 0, 2 * u + 8, 2 * u + 8),
      _quiltedTile(startIdx + 1, 2 * u + 16, 0, u, u),
      _quiltedTile(startIdx + 2, 3 * u + 24, 0, u, u),
      _quiltedTile(startIdx + 3, 2 * u + 16, u + 8, 2 * u + 8, u),
    ];
  }

  List<Widget> _buildQuiltedBlockB(int startIdx, double u) {
    return [
      _quiltedTile(startIdx, 0, 0, 2 * u + 8, u),
      _quiltedTile(startIdx + 1, 2 * u + 16, 0, 2 * u + 8, 2 * u + 8),
      _quiltedTile(startIdx + 2, 0, u + 8, u, u),
      _quiltedTile(startIdx + 3, u + 8, u + 8, u, u),
    ];
  }

  Widget _quiltedTile(
      int index, double left, double top, double width, double height) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: AnimationConfiguration.staggeredGrid(
        position: index,
        duration: const Duration(milliseconds: 1000),
        columnCount: 4,
        child: ScaleAnimation(
          scale: 0.5,
          curve: Curves.easeOutBack,
          child: FadeInAnimation(
            child:
                _buildMasonryItem(index, isQuilted: true, customHeight: height),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableItem(int index) {
    final isExpanded = _expandedIndices.contains(index);
    final color = _colors[index % _colors.length];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GlassWrap(
        isGlassMode: _isGlassMode,
        blur: 15,
        connectivity: 0.15,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: _isGlassMode ? Colors.transparent : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: _isGlassMode
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black12,
                width: 1),
            boxShadow: _isGlassMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _toggleExpanded(index),
            child: Column(
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        shape: BoxShape.circle),
                    child: Icon(Icons.rocket_launch_rounded, color: color),
                  ),
                  title: Text('Innovation ${index + 1}',
                      style: TextStyle(
                          color: _isGlassMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  subtitle: Text('Exclusive Feature Set',
                      style: TextStyle(
                          color: _isGlassMode ? Colors.white70 : Colors.black54,
                          fontSize: 13)),
                  trailing: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: isExpanded ? 0.5 : 0,
                    child: Icon(Icons.expand_more_rounded,
                        color: _isGlassMode ? Colors.white70 : Colors.black45),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  child: isExpanded
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                  color: _isGlassMode
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Colors.black12),
                              const SizedBox(height: 12),
                              Text('DYNAMICS & FLEXIBILITY',
                                  style: TextStyle(
                                      color: _isGlassMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                      letterSpacing: 1.5)),
                              const SizedBox(height: 10),
                              Text(
                                  'Seamless synergy between Glassmorphism and staggered entrance effects.',
                                  style: TextStyle(
                                      color: _isGlassMode
                                          ? Colors.white70
                                          : Colors.black87,
                                      height: 1.5)),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: color,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  minimumSize: const Size(double.infinity, 45),
                                ),
                                child: const Text('ACTIVATE'),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(width: double.infinity, height: 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    final color = _colors[index % _colors.length];
    final isGif =
        index % 3 == 0; // Show GIF every 3rd tile for maximum uniqueness
    // Using modulo 30+ ensures uniqueness across 90+ tiles
    final imageUrl = isGif
        ? _gifs[(index ~/ 3) % _gifs.length]
        : 'https://picsum.photos/seed/${index + 100}/600/800';
    return Hero(
      tag: 'item_$index',
      child: GestureDetector(
        onTap: () => _openDetail(index, imageUrl),
        child: GlassWrap(
          isGlassMode: _isGlassMode,
          blur: 15,
          connectivity: 0.15,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: _isGlassMode ? Colors.transparent : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: _isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black12,
                  width: 1),
              boxShadow: _isGlassMode
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LivingImage(imageUrl: imageUrl),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Style ${index + 1}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(isGif ? 'UNIQUE GIF' : '3D PREMIUM',
                        style: TextStyle(
                            color: color.withValues(alpha: 0.9),
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1)),
                    const SizedBox(height: 16),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMasonryItem(int index,
      {required bool isQuilted, required double customHeight}) {
    final color = _colors[index % _colors.length];
    final isGif = (index + 2) % 4 == 0; // Show GIF frequently but uniquely
    // Guaranteed uniqueness logic for GIFs
    final imageUrl = isGif
        ? _gifs[(index ~/ 4) % _gifs.length]
        : 'https://picsum.photos/seed/${index + 200}/600/800';
    return Hero(
      tag: 'item_$index',
      child: GestureDetector(
        onTap: () => _openDetail(index, imageUrl),
        child: SizedBox(
          height: customHeight,
          child: GlassWrap(
            isGlassMode: _isGlassMode,
            blur: 12,
            connectivity: 0.12,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: _isGlassMode ? Colors.transparent : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: _isGlassMode
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black12,
                    width: 1),
                boxShadow: _isGlassMode
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LivingImage(imageUrl: imageUrl),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Text('#$index',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                                isGif
                                    ? Icons.auto_awesome_rounded
                                    : (isQuilted
                                        ? Icons.grid_goldenratio_rounded
                                        : Icons.camera_rounded),
                                color: color,
                                size: (customHeight > 100) ? 32 : 24),
                            if (customHeight > 130) ...[
                              const SizedBox(height: 8),
                              Text(isGif ? 'ANIMATED' : 'PREMIUM',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 10,
                                      letterSpacing: 1)),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LivingImage extends StatelessWidget {
  final String imageUrl;
  const LivingImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 1.15),
      duration: const Duration(seconds: 15),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(
                begin: const Offset(-0.05, -0.05),
                end: const Offset(0.05, 0.05)),
            duration: const Duration(seconds: 20),
            builder: (context, offset, child) {
              return Transform.translate(
                offset: Offset(offset.dx * 100, offset.dy * 100),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              );
            },
          ),
        );
      },
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final int index;
  final String imageUrl;
  final Color color;

  const ImageDetailScreen(
      {super.key,
      required this.index,
      required this.imageUrl,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: 'item_$index',
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.transparent, Colors.black87],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: Colors.white, size: 32),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dynamic Creation #$index',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text('ULTRA PREMIUM',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          const Text('MOTION INTEGRATED',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  letterSpacing: 1)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Experience the fusion of animated media and advanced motion effects. This view utilizes the "Living Tile" engine to create a constant, subtle sense of depth and life.',
                        style: TextStyle(
                            color: Colors.white, fontSize: 15, height: 1.6),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('EXPLORE DYNAMICS',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
