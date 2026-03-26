import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A hierarchical item for the [HierarchySearchableDropdown].
class HierarchyItem {
  const HierarchyItem({
    required this.title,
    this.subtitle,
    this.subItems,
    this.icon,
    this.iconPath,
    this.iconHeight,
    this.iconWidth,
    this.iconBorderRadius,
    this.prefix,
    this.suffix,
    this.data,
  });

  /// The display title of the item.
  final String title;

  /// The display subtitle of the item.
  final String? subtitle;

  /// Nested sub-items for this category.
  final List<HierarchyItem>? subItems;

  /// Optional icon for the item.
  final IconData? icon;

  /// Optional path for an image (network URL or asset path).
  final String? iconPath;

  /// Optional custom height for this item's icon/image.
  final double? iconHeight;

  /// Optional custom width for this item's icon/image.
  final double? iconWidth;

  /// Optional custom border radius for this item's icon/image.
  final double? iconBorderRadius;

  /// Optional custom widget to show before the title.
  final Widget? prefix;

  /// Optional custom widget to show after the title.
  final Widget? suffix;

  /// Optional custom data associated with this item.
  final dynamic data;

  /// Returns true if this is a leaf node (no sub-items).
  bool get isLeaf => subItems == null || subItems!.isEmpty;

  /// Collects all leaf titles that are marked selected in [selectedIds].
  void collectSelectedTitles(Set<String> selectedIds, List<String> out) {
    if (isLeaf) {
      if (selectedIds.contains(title)) out.add(title);
    } else {
      for (final sub in subItems!) {
        sub.collectSelectedTitles(selectedIds, out);
      }
    }
  }

  /// Returns all leaf titles under this item (for select-all).
  List<String> get allLeafTitles {
    if (isLeaf) return [title];
    return [for (final sub in subItems!) ...sub.allLeafTitles];
  }

  /// Returns true if [title] or any descendant matches [query].
  bool matchesQuery(String query) {
    if (query.isEmpty) return true;
    final lowerQuery = query.toLowerCase();
    if (title.toLowerCase().contains(lowerQuery)) return true;
    if (subtitle != null && subtitle!.toLowerCase().contains(lowerQuery)) {
      return true;
    }
    if (!isLeaf) {
      for (final sub in subItems!) {
        if (sub.matchesQuery(lowerQuery)) return true;
      }
    }
    return false;
  }
}

/// Builder for the dropdown trigger/header.
typedef HierarchyHeaderBuilder = Widget Function(
  BuildContext context,
  String label,
  bool isOpen,
  VoidCallback onTap,
);

/// Builder for the search field.
typedef HierarchySearchBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
  String query,
  ValueChanged<String> onChanged,
);

/// Builder for individual tree rows.
typedef HierarchyItemBuilder = Widget Function(
  BuildContext context,
  HierarchyItem item,
  int level,
  bool isExpanded,
  bool? isSelected, // null for partial, true/false for leaf/group
  VoidCallback onToggleExpand,
  VoidCallback onToggleSelect,
);

/// A premium, customizable hierarchical dropdown with search and multi-select support.
class HierarchySearchableDropdown extends StatefulWidget {
  const HierarchySearchableDropdown({
    super.key,
    required this.items,
    this.hint = 'Select items...',
    this.isMultiline = false,
    this.isMultiSelect = false,
    required this.onChanged,
    this.headerBuilder,
    this.searchBuilder,
    this.itemBuilder,
    this.dropdownDecoration,
    this.maxHeight = 500,
    this.itemTextStyle,
    this.itemTextAlign,
    this.itemPadding,
    this.listPadding,
    this.itemSpacing,
    this.defaultIconHeight = 22,
    this.defaultIconWidth = 22,
    this.defaultIconBorderRadius = 6,
    this.validator,
    this.buttonHeight,
    this.buttonWidth,
    this.dropdownHeight,
    this.dropdownWidth,
    this.offset,
    this.headerDecoration,
    this.searchDecoration,
    this.searchBoxDecoration,
    this.searchStyle,
    this.targetAnchor = Alignment.bottomLeft,
    this.followerAnchor = Alignment.topLeft,
    this.showChips = false,
    this.chipDecoration,
    this.chipTextStyle,
    this.chipPadding,
    this.chipHeight,
    this.searchFocusNode,
    this.autoFocusSearch = false,
    this.headerPrefix,
    this.headerSuffix,
    this.clearSearchOnClose = true,
    this.chipScrollDirection = Axis.horizontal,
    this.showSearch = true,
    this.isLoadingMore = false,
    this.onLoadMore,
    this.loadingIndicator,
    this.enableAnimation = true,
    this.isGlassMode = false,
    this.blur = 10,
    this.connectivity = 0.1,
  });

  /// The list of top-level hierarchy items.
  final List<HierarchyItem> items;

  /// Hint text for the dropdown trigger.
  final String hint;

  /// Whether the selected label should wrap onto multiple lines.
  final bool isMultiline;

  /// Whether to allow multiple selections with recursive logic.
  final bool isMultiSelect;

  /// Callback when the selection changes (comma-separated labels).
  final ValueChanged<String> onChanged;

  /// Optional custom builder for the dropdown trigger.
  final HierarchyHeaderBuilder? headerBuilder;

  /// Optional custom builder for the search field.
  final HierarchySearchBuilder? searchBuilder;

  /// Optional custom builder for each tree row.
  final HierarchyItemBuilder? itemBuilder;

  /// Optional decoration for the dropdown panel content.
  final BoxDecoration? dropdownDecoration;

  /// Maximum height of the dropdown panel.
  final double maxHeight;

  /// Optional custom text style for all items.
  final TextStyle? itemTextStyle;

  /// Optional text alignment for the item title.
  final TextAlign? itemTextAlign;

  /// Optional padding for each item row.
  final EdgeInsets? itemPadding;

  /// Optional padding for the overall list inside the dropdown.
  final EdgeInsets? listPadding;

  /// Vertical space between items.
  final double? itemSpacing;

  /// Default height for icons/images if not specified per-item.
  final double defaultIconHeight;

  /// Default width for icons/images if not specified per-item.
  final double defaultIconWidth;

  /// Default border radius for icons/images if not specified per-item.
  final double defaultIconBorderRadius;

  /// Optional validator function to validate the selection.
  final String? Function(String?)? validator;

  /// Optional custom height for the dropdown trigger/button.
  final double? buttonHeight;

  /// Optional custom width for the dropdown trigger/button.
  final double? buttonWidth;

  /// Optional custom height for the dropdown panel.
  final double? dropdownHeight;

  /// Optional custom width for the dropdown panel.
  final double? dropdownWidth;

  /// Optional offset to position the dropdown panel relative to the trigger.
  final Offset? offset;

  /// Optional custom decoration for the default header.
  final BoxDecoration? headerDecoration;

  /// Optional custom decoration for the default search field's InputDecoration.
  final InputDecoration? searchDecoration;

  /// Optional custom decoration for the search field container.
  final BoxDecoration? searchBoxDecoration;

  /// Optional custom text style for the search field.
  final TextStyle? searchStyle;

  /// Optional target anchor for the dropdown panel position.
  final Alignment targetAnchor;

  /// Optional follower anchor for the dropdown panel position.
  final Alignment followerAnchor;

  /// Whether to show selected items as chips in the header.
  final bool showChips;

  /// Optional decoration for the chips in the header.
  final BoxDecoration? chipDecoration;

  /// Optional text style for the chips in the header.
  final TextStyle? chipTextStyle;

  /// Optional padding for the chips in the header.
  final EdgeInsets? chipPadding;

  /// Optional custom height for the chips in the header.
  final double? chipHeight;

  /// Optional custom FocusNode for the search field.
  final FocusNode? searchFocusNode;

  /// Whether the search field should auto-focus when opened.
  final bool autoFocusSearch;

  /// Optional custom widget to show as prefix in the default header.
  final Widget? headerPrefix;

  /// Optional custom widget to show as suffix in the default header.
  final Widget? headerSuffix;

  /// Whether to clear the search query when the dropdown is closed.
  final bool clearSearchOnClose;

  /// The scroll direction of the chips in the header.
  final Axis chipScrollDirection;

  /// Whether to show the search bar in the dropdown panel.
  final bool showSearch;

  /// Whether we are currently loading more items at the bottom.
  final bool isLoadingMore;

  /// Callback when the user scrolls near the bottom of the list.
  final VoidCallback? onLoadMore;

  /// Optional widget to show as a loader at the bottom of the list.
  final Widget? loadingIndicator;

  /// Whether to enable entrance animations for items.
  final bool enableAnimation;

  /// Whether to enable glassmorphism (blur background) for the dropdown panel.
  final bool isGlassMode;

  /// Blur amount for the glassmorphism effect.
  final double blur;

  /// Connectivity (white opacity) for the glassmorphism effect.
  final double connectivity;

  @override
  State<HierarchySearchableDropdown> createState() =>
      _HierarchySearchableDropdownState();
}

class _HierarchySearchableDropdownState
    extends State<HierarchySearchableDropdown> {
  final Set<String> _selectedIds = {};
  final List<String> _orderedSelectedLabels = [];
  final Set<String> _expandedIds = {};
  bool _isOpen = false;
  bool _isOpeningUpwards = false;
  double _buttonWidth = 0;
  double _maxAvailableHeight = 0;
  String _searchQuery = '';
  String? _errorText;
  final TextEditingController _searchController = TextEditingController();
  late final FocusNode _internalFocusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  FocusNode get _effectiveFocusNode =>
      widget.searchFocusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(HierarchySearchableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isOpen) {
      if (oldWidget.items != widget.items ||
          oldWidget.isLoadingMore != widget.isLoadingMore ||
          oldWidget.isMultiSelect != widget.isMultiSelect ||
          oldWidget.showSearch != widget.showSearch) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_isOpen) {
            _overlayEntry?.markNeedsBuild();
          }
        });
      }
    }
  }

  String get _selectedLabel {
    if (_selectedIds.isEmpty) return '';
    final buf = <String>[];
    for (final item in widget.items) {
      item.collectSelectedTitles(_selectedIds, buf);
    }
    return buf.join(', ');
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);

    // Calculate available space to decide if we should open upwards
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final topPadding = mediaQuery.viewPadding.top;
    final bottomPadding = mediaQuery.viewPadding.bottom;

    final availableSpaceBelow =
        screenHeight - offset.dy - size.height - bottomPadding - 16;
    final availableSpaceAbove = offset.dy - topPadding - 16;

    // Use a small buffer (20.0) for better UI
    final dropdownHeight = widget.dropdownHeight ?? widget.maxHeight;
    _isOpeningUpwards = availableSpaceBelow < (dropdownHeight + 20) &&
        availableSpaceAbove > availableSpaceBelow;

    _buttonWidth = size.width;
    _maxAvailableHeight =
        _isOpeningUpwards ? availableSpaceAbove : availableSpaceBelow;

    _overlayEntry = _createOverlayEntry();
    overlay.insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
    if (widget.autoFocusSearch) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _effectiveFocusNode.requestFocus();
      });
    }
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
      if (widget.clearSearchOnClose) {
        _searchQuery = '';
        _searchController.clear();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    final targetAnchor =
        _isOpeningUpwards ? Alignment.topLeft : widget.targetAnchor;
    final followerAnchor =
        _isOpeningUpwards ? Alignment.bottomLeft : widget.followerAnchor;
    final finalOffset = _isOpeningUpwards
        ? (widget.offset?.scale(1, -1) ?? const Offset(0, -4))
        : (widget.offset ?? const Offset(0, 4));

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: targetAnchor,
            followerAnchor: followerAnchor,
            offset: finalOffset,
            child: TapRegion(
              groupId: _layerLink,
              onTapOutside: (_) => _closeDropdown(),
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: widget.dropdownWidth ?? _buttonWidth,
                  height: widget.dropdownHeight,
                  child: _DropdownPanel(
                    items: widget.items,
                    isMultiSelect: widget.isMultiSelect,
                    showSearch: widget.showSearch,
                    selectedIds: _selectedIds,
                    expandedIds: _expandedIds,
                    searchQuery: _searchQuery,
                    searchController: _searchController,
                    maxHeight: widget.dropdownHeight ??
                        (widget.maxHeight < _maxAvailableHeight
                            ? widget.maxHeight
                            : _maxAvailableHeight),
                    decoration: widget.dropdownDecoration,
                    searchBuilder: widget.searchBuilder,
                    itemBuilder: widget.itemBuilder,
                    itemTextStyle: widget.itemTextStyle,
                    itemTextAlign: widget.itemTextAlign,
                    itemPadding: widget.itemPadding,
                    listPadding: widget.listPadding,
                    itemSpacing: widget.itemSpacing,
                    defaultIconHeight: widget.defaultIconHeight,
                    defaultIconWidth: widget.defaultIconWidth,
                    defaultIconBorderRadius: widget.defaultIconBorderRadius,
                    searchDecoration: widget.searchDecoration,
                    searchBoxDecoration: widget.searchBoxDecoration,
                    searchStyle: widget.searchStyle,
                    focusNode: _effectiveFocusNode,
                    autoFocus: widget.autoFocusSearch,
                    onSearchChanged: (q) {
                      setState(() => _searchQuery = q.toLowerCase());
                      _overlayEntry?.markNeedsBuild();
                    },
                    onLeafTapped: _onLeafTapped,
                    onGroupToggle: _onGroupToggle,
                    onExpandToggle: (id) {
                      _onExpandToggle(id);
                      _overlayEntry?.markNeedsBuild();
                    },
                    isLoadingMore: widget.isLoadingMore,
                    onLoadMore: widget.onLoadMore,
                    loadingIndicator: widget.loadingIndicator,
                    enableAnimation: widget.enableAnimation,
                    isGlassMode: widget.isGlassMode,
                    blur: widget.blur,
                    connectivity: widget.connectivity,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLeafTapped(HierarchyItem leaf) {
    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedIds.contains(leaf.title)) {
          _selectedIds.remove(leaf.title);
          _orderedSelectedLabels.remove(leaf.title);
        } else {
          _selectedIds.add(leaf.title);
          _orderedSelectedLabels.add(leaf.title);
        }
      } else {
        _selectedIds
          ..clear()
          ..add(leaf.title);
        _orderedSelectedLabels
          ..clear()
          ..add(leaf.title);
        _closeDropdown();
      }
    });
    _overlayEntry?.markNeedsBuild();
    widget.onChanged(_selectedLabel);
    _validate();
  }

  void _validate() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_selectedLabel);
      });
    }
  }

  void _onGroupToggle(HierarchyItem group, bool select) {
    assert(widget.isMultiSelect);
    setState(() {
      final leaves = group.allLeafTitles;
      if (select) {
        for (final leaf in leaves) {
          if (!_selectedIds.contains(leaf)) {
            _selectedIds.add(leaf);
            _orderedSelectedLabels.add(leaf);
          }
        }
      } else {
        for (final leaf in leaves) {
          _selectedIds.remove(leaf);
          _orderedSelectedLabels.remove(leaf);
        }
      }
    });
    _overlayEntry?.markNeedsBuild();
    widget.onChanged(_selectedLabel);
    _validate();
  }

  void _onExpandToggle(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  void _removeSelection(String label) {
    setState(() {
      _selectedIds.remove(label);
      _orderedSelectedLabels.remove(label);
    });
    _overlayEntry?.markNeedsBuild();
    widget.onChanged(_selectedLabel);
    _validate();
  }

  void _reorderSelections(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _orderedSelectedLabels.removeAt(oldIndex);
      _orderedSelectedLabels.insert(newIndex, item);
    });
    widget.onChanged(_selectedLabel);
  }

  @override
  void dispose() {
    _closeDropdown();
    _searchController.dispose();
    _internalFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = _selectedLabel;
    return TapRegion(
      groupId: _layerLink,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: SizedBox(
          width: widget.buttonWidth,
          height: widget.isMultiline ? null : widget.buttonHeight,
          child: widget.headerBuilder != null
              ? widget.headerBuilder!(context, label, _isOpen, _toggleDropdown)
              : _DefaultHeader(
                  label: label,
                  hint: widget.hint,
                  isMultiline: widget.isMultiline,
                  isOpen: _isOpen,
                  errorText: _errorText,
                  onTap: _toggleDropdown,
                  decoration: widget.headerDecoration,
                  showChips: widget.showChips,
                  selectedLabels: _orderedSelectedLabels,
                  onRemove: _removeSelection,
                  onReorder: _reorderSelections,
                  chipDecoration: widget.chipDecoration,
                  chipTextStyle: widget.chipTextStyle,
                  chipPadding: widget.chipPadding,
                  chipHeight: widget.chipHeight,
                  chipScrollDirection: widget.chipScrollDirection,
                  prefix: widget.headerPrefix,
                  suffix: widget.headerSuffix,
                  isGlassMode: widget.isGlassMode,
                  blur: widget.blur,
                  connectivity: widget.connectivity,
                ),
        ),
      ),
    );
  }
}

class _DefaultHeader extends StatelessWidget {
  const _DefaultHeader({
    required this.label,
    required this.hint,
    required this.isMultiline,
    required this.isOpen,
    required this.onTap,
    this.errorText,
    this.decoration,
    this.showChips = false,
    this.selectedLabels = const [],
    this.onRemove,
    this.onReorder,
    this.chipDecoration,
    this.chipTextStyle,
    this.chipPadding,
    this.chipHeight,
    this.chipScrollDirection = Axis.horizontal,
    this.prefix,
    this.suffix,
    this.isGlassMode = false,
    this.blur = 10,
    this.connectivity = 0.1,
  });

  final String label;
  final String hint;
  final bool isMultiline;
  final bool isOpen;
  final VoidCallback onTap;
  final String? errorText;
  final BoxDecoration? decoration;
  final bool showChips;
  final List<String> selectedLabels;
  final ValueChanged<String>? onRemove;
  final ReorderCallback? onReorder;
  final BoxDecoration? chipDecoration;
  final TextStyle? chipTextStyle;
  final EdgeInsets? chipPadding;
  final double? chipHeight;
  final Axis chipScrollDirection;
  final Widget? prefix;
  final Widget? suffix;
  final bool isGlassMode;
  final double blur;
  final double connectivity;

  @override
  Widget build(BuildContext context) {
    final hasLabel = label.isNotEmpty;
    final hasError = errorText != null;
    final useChips = showChips && selectedLabels.isNotEmpty;
    final isHorizontal = chipScrollDirection == Axis.horizontal;

    final defaultDecoration = BoxDecoration(
      color: isGlassMode ? Colors.transparent : Colors.white,
      border: Border.all(
        color: hasError
            ? Colors.red.shade400
            : (isOpen ? Colors.blue.shade400 : Colors.black12),
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: isGlassMode
          ? []
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GlassWrap(
          isGlassMode: isGlassMode,
          blur: blur,
          connectivity: connectivity,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: decoration ?? defaultDecoration,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  behavior: HitTestBehavior.opaque,
                  child: prefix ??
                      Icon(
                        Icons.checklist_rounded,
                        color: hasError
                            ? Colors.red.shade400
                            : (hasLabel
                                ? Colors.blue.shade400
                                : Colors.black38),
                      ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: useChips
                      ? isMultiline
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    selectedLabels.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final text = entry.value;
                                  final chipWidget = Container(
                                    padding: chipPadding ??
                                        const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                    decoration: chipDecoration ??
                                        BoxDecoration(
                                          color: Colors.blue
                                              .withValues(alpha: 0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Colors.blue
                                                  .withValues(alpha: 0.2)),
                                        ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          text,
                                          style: chipTextStyle ??
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        const SizedBox(width: 4),
                                        InkWell(
                                          onTap: () => onRemove?.call(text),
                                          child: const Icon(
                                            Icons.close_rounded,
                                            size: 14,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  return DragTarget<String>(
                                    key: ValueKey(text),
                                    onWillAcceptWithDetails: (details) {
                                      if (details.data != text) {
                                        final fromIndex = selectedLabels
                                            .indexOf(details.data);
                                        if (fromIndex != -1) {
                                          // ReorderableListView-style logic requires index + 1 for forward moves
                                          onReorder?.call(
                                              fromIndex,
                                              fromIndex < index
                                                  ? index + 1
                                                  : index);
                                        }
                                      }
                                      return true;
                                    },
                                    onAcceptWithDetails: (details) {
                                      // Final order is already handled by live reordering
                                    },
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return LongPressDraggable<String>(
                                        data: text,
                                        feedback: Material(
                                          color: Colors.transparent,
                                          child: Transform.scale(
                                              scale: 1.05, child: chipWidget),
                                        ),
                                        childWhenDragging: Opacity(
                                            opacity: 0.3, child: chipWidget),
                                        child: chipWidget,
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            )
                          : SizedBox(
                              height: isHorizontal ? (chipHeight ?? 48) : 150,
                              child: ReorderableListView.builder(
                                scrollDirection: chipScrollDirection,
                                physics: const BouncingScrollPhysics(),
                                itemCount: selectedLabels.length,
                                onReorder: onReorder!,
                                buildDefaultDragHandles: false,
                                proxyDecorator: (child, index, animation) {
                                  return AnimatedBuilder(
                                    animation: animation,
                                    builder: (context, child) {
                                      final animValue = Curves.easeInOut
                                          .transform(animation.value);
                                      final scale = 1.0 + (0.05 * animValue);
                                      return Transform.scale(
                                        scale: scale,
                                        child: Material(
                                          color: Colors.white,
                                          type: MaterialType.transparency,
                                          animateColor: true,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 8 * animValue,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: child,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  final text = selectedLabels[index];
                                  return ReorderableDelayedDragStartListener(
                                    key: ValueKey(text),
                                    index: index,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Center(
                                        child: Container(
                                          padding: chipPadding ??
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 6),
                                          decoration: chipDecoration ??
                                              BoxDecoration(
                                                color: Colors.blue
                                                    .withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.blue
                                                        .withValues(
                                                            alpha: 0.2)),
                                              ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                text,
                                                style: chipTextStyle ??
                                                    const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              const SizedBox(width: 4),
                                              InkWell(
                                                onTap: () =>
                                                    onRemove?.call(text),
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  size: 14,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                      : GestureDetector(
                          onTap: onTap,
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: isMultiline ? null : 48,
                            padding: isMultiline
                                ? const EdgeInsets.symmetric(vertical: 4)
                                : null,
                            child: Text(
                              hasLabel ? label : hint,
                              maxLines: isMultiline ? null : 1,
                              overflow: isMultiline
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    hasLabel ? Colors.black87 : Colors.black38,
                                fontSize: 16,
                                fontWeight: hasLabel
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                ),
                GestureDetector(
                  onTap: onTap,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8),
                      suffix ??
                          AnimatedRotation(
                            turns: isOpen ? 0.5 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.keyboard_arrow_down_rounded,
                                color: Colors.black45),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DropdownPanel extends StatefulWidget {
  const _DropdownPanel({
    required this.items,
    required this.isMultiSelect,
    required this.selectedIds,
    required this.expandedIds,
    required this.searchQuery,
    required this.searchController,
    required this.maxHeight,
    required this.showSearch,
    this.decoration,
    this.searchBuilder,
    this.itemBuilder,
    this.itemTextStyle,
    this.itemTextAlign,
    this.itemPadding,
    this.listPadding,
    this.itemSpacing,
    required this.defaultIconHeight,
    required this.defaultIconWidth,
    required this.defaultIconBorderRadius,
    this.searchDecoration,
    this.searchBoxDecoration,
    this.searchStyle,
    this.focusNode,
    this.autoFocus = false,
    required this.onSearchChanged,
    required this.onLeafTapped,
    required this.onGroupToggle,
    required this.onExpandToggle,
    required this.isLoadingMore,
    this.onLoadMore,
    this.loadingIndicator,
    required this.enableAnimation,
    required this.isGlassMode,
    required this.blur,
    required this.connectivity,
  });

  final List<HierarchyItem> items;
  final bool isMultiSelect;
  final Set<String> selectedIds;
  final Set<String> expandedIds;
  final String searchQuery;
  final TextEditingController searchController;
  final double maxHeight;
  final bool showSearch;
  final BoxDecoration? decoration;
  final HierarchySearchBuilder? searchBuilder;
  final HierarchyItemBuilder? itemBuilder;
  final TextStyle? itemTextStyle;
  final TextAlign? itemTextAlign;
  final EdgeInsets? itemPadding;
  final EdgeInsets? listPadding;
  final double? itemSpacing;
  final double defaultIconHeight;
  final double defaultIconWidth;
  final double defaultIconBorderRadius;
  final InputDecoration? searchDecoration;
  final BoxDecoration? searchBoxDecoration;
  final TextStyle? searchStyle;
  final FocusNode? focusNode;
  final bool autoFocus;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<HierarchyItem> onLeafTapped;
  final void Function(HierarchyItem, bool) onGroupToggle;
  final ValueChanged<String> onExpandToggle;
  final bool isLoadingMore;
  final VoidCallback? onLoadMore;
  final Widget? loadingIndicator;
  final bool enableAnimation;
  final bool isGlassMode;
  final double blur;
  final double connectivity;

  @override
  State<_DropdownPanel> createState() => _DropdownPanelState();
}

class _DropdownPanelState extends State<_DropdownPanel> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (widget.onLoadMore != null && !widget.isLoadingMore) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        widget.onLoadMore!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      child: _GlassWrap(
        isGlassMode: widget.isGlassMode,
        blur: widget.blur,
        connectivity: widget.connectivity,
        borderRadius: (widget.decoration?.borderRadius as BorderRadius?) ??
            BorderRadius.circular(20),
        child: Container(
          decoration: widget.decoration ??
              BoxDecoration(
                color: widget.isGlassMode ? Colors.transparent : Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(20),
                boxShadow: widget.isGlassMode
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showSearch)
                if (widget.searchBuilder != null)
                  widget.searchBuilder!(context, widget.searchController,
                      widget.searchQuery, widget.onSearchChanged)
                else
                  _DefaultSearchBar(
                    controller: widget.searchController,
                    query: widget.searchQuery,
                    onChanged: widget.onSearchChanged,
                    decoration: widget.searchDecoration,
                    boxDecoration: widget.searchBoxDecoration,
                    style: widget.searchStyle,
                    focusNode: widget.focusNode,
                    autoFocus: widget.autoFocus,
                  ),
              Flexible(
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: widget.listPadding ??
                      const EdgeInsets.symmetric(vertical: 8),
                  itemCount:
                      widget.items.length + (widget.isLoadingMore ? 1 : 0),
                  itemBuilder: (_, i) {
                    if (i == widget.items.length) {
                      return _LoadingItem(
                        indicator: widget.loadingIndicator,
                        enableAnimation: widget.enableAnimation,
                      );
                    }
                    return _InternalTreeItem(
                      key: ValueKey(widget.items[i].title),
                      item: widget.items[i],
                      level: 0,
                      searchQuery: widget.searchQuery,
                      parentMatches: false,
                      isMultiSelect: widget.isMultiSelect,
                      selectedIds: widget.selectedIds,
                      expandedIds: widget.expandedIds,
                      itemBuilder: widget.itemBuilder,
                      itemTextStyle: widget.itemTextStyle,
                      itemTextAlign: widget.itemTextAlign,
                      itemPadding: widget.itemPadding,
                      itemSpacing: widget.itemSpacing,
                      defaultIconHeight: widget.defaultIconHeight,
                      defaultIconWidth: widget.defaultIconWidth,
                      defaultIconBorderRadius: widget.defaultIconBorderRadius,
                      onLeafTapped: widget.onLeafTapped,
                      onGroupToggle: widget.onGroupToggle,
                      onExpandToggle: widget.onExpandToggle,
                      enableAnimation: widget.enableAnimation,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultSearchBar extends StatelessWidget {
  const _DefaultSearchBar({
    required this.controller,
    required this.query,
    required this.onChanged,
    this.decoration,
    this.boxDecoration,
    this.style,
    this.focusNode,
    this.autoFocus = false,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;
  final InputDecoration? decoration;
  final BoxDecoration? boxDecoration;
  final TextStyle? style;
  final FocusNode? focusNode;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = InputDecoration(
      hintText: 'Search here...',
      hintStyle: const TextStyle(color: Colors.black38),
      prefixIcon: const Icon(Icons.search_rounded, color: Colors.black38),
      suffixIcon: query.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.close_rounded,
                  color: Colors.black38, size: 20),
              onPressed: () {
                controller.clear();
                onChanged('');
              },
            )
          : null,
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.03),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.zero,
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: boxDecoration,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          autofocus: autoFocus,
          style: style ?? const TextStyle(color: Colors.black87),
          decoration: decoration ?? defaultDecoration,
        ),
      ),
    );
  }
}

class _InternalTreeItem extends StatefulWidget {
  const _InternalTreeItem({
    super.key,
    required this.item,
    required this.level,
    required this.searchQuery,
    required this.parentMatches,
    required this.isMultiSelect,
    required this.selectedIds,
    required this.expandedIds,
    this.itemBuilder,
    this.itemTextStyle,
    this.itemTextAlign,
    this.itemPadding,
    this.itemSpacing,
    required this.defaultIconHeight,
    required this.defaultIconWidth,
    required this.defaultIconBorderRadius,
    required this.onLeafTapped,
    required this.onGroupToggle,
    required this.onExpandToggle,
    required this.enableAnimation,
  });

  final HierarchyItem item;
  final int level;
  final String searchQuery;
  final bool parentMatches;
  final bool isMultiSelect;
  final Set<String> selectedIds;
  final Set<String> expandedIds;
  final HierarchyItemBuilder? itemBuilder;
  final TextStyle? itemTextStyle;
  final TextAlign? itemTextAlign;
  final EdgeInsets? itemPadding;
  final double? itemSpacing;
  final double defaultIconHeight;
  final double defaultIconWidth;
  final double defaultIconBorderRadius;
  final ValueChanged<HierarchyItem> onLeafTapped;
  final void Function(HierarchyItem, bool) onGroupToggle;
  final ValueChanged<String> onExpandToggle;
  final bool enableAnimation;

  @override
  State<_InternalTreeItem> createState() => _InternalTreeItemState();
}

class _InternalTreeItemState extends State<_InternalTreeItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    if (widget.enableAnimation) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isExpanded => widget.expandedIds.contains(widget.item.title);
  bool get _selfMatches =>
      widget.searchQuery.isEmpty ||
      widget.item.title.toLowerCase().contains(widget.searchQuery);
  bool get _childMatches =>
      !widget.item.isLeaf && widget.item.matchesQuery(widget.searchQuery);
  bool get _shouldShow => _selfMatches || widget.parentMatches || _childMatches;

  bool? get _triState {
    if (widget.item.isLeaf) {
      return widget.selectedIds.contains(widget.item.title);
    }
    final leaves = widget.item.allLeafTitles;
    final count = leaves.where(widget.selectedIds.contains).length;
    if (count == 0) return false;
    if (count == leaves.length) return true;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShow) return const SizedBox.shrink();

    final forceExpand =
        widget.searchQuery.isNotEmpty && !_selfMatches && _childMatches;
    final isActuallyExpanded = _isExpanded || forceExpand;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.itemBuilder != null)
          widget.itemBuilder!(
            context,
            widget.item,
            widget.level,
            isActuallyExpanded,
            widget.isMultiSelect
                ? _triState
                : widget.selectedIds.contains(widget.item.title),
            () => widget.onExpandToggle(widget.item.title),
            () {
              if (widget.item.isLeaf) {
                widget.onLeafTapped(widget.item);
              } else if (widget.isMultiSelect) {
                widget.onGroupToggle(widget.item, _triState != true);
              }
            },
          )
        else
          _DefaultTreeRow(
            item: widget.item,
            level: widget.level,
            isMultiSelect: widget.isMultiSelect,
            isExpanded: isActuallyExpanded,
            triState: widget.isMultiSelect ? _triState : null,
            isSelected: !widget.isMultiSelect &&
                widget.selectedIds.contains(widget.item.title),
            onTap: () {
              if (!widget.item.isLeaf) {
                widget.onExpandToggle(widget.item.title);
              } else {
                widget.onLeafTapped(widget.item);
              }
            },
            onCheckboxChanged: widget.isMultiSelect
                ? (v) => widget.onGroupToggle(widget.item, v ?? false)
                : null,
            itemTextStyle: widget.itemTextStyle,
            itemTextAlign: widget.itemTextAlign,
            itemPadding: widget.itemPadding,
            itemSpacing: widget.itemSpacing,
            defaultIconHeight: widget.defaultIconHeight,
            defaultIconWidth: widget.defaultIconWidth,
            defaultIconBorderRadius: widget.defaultIconBorderRadius,
          ),
        if (!widget.item.isLeaf && isActuallyExpanded)
          ...widget.item.subItems!.map(
            (sub) => _InternalTreeItem(
              key: ValueKey(sub.title),
              item: sub,
              level: widget.level + 1,
              searchQuery: widget.searchQuery,
              parentMatches: _selfMatches || widget.parentMatches,
              isMultiSelect: widget.isMultiSelect,
              selectedIds: widget.selectedIds,
              expandedIds: widget.expandedIds,
              itemBuilder: widget.itemBuilder,
              itemTextStyle: widget.itemTextStyle,
              itemTextAlign: widget.itemTextAlign,
              itemPadding: widget.itemPadding,
              itemSpacing: widget.itemSpacing,
              defaultIconHeight: widget.defaultIconHeight,
              defaultIconWidth: widget.defaultIconWidth,
              defaultIconBorderRadius: widget.defaultIconBorderRadius,
              onLeafTapped: widget.onLeafTapped,
              onGroupToggle: widget.onGroupToggle,
              onExpandToggle: widget.onExpandToggle,
              enableAnimation: widget.enableAnimation,
            ),
          ),
      ],
    );

    if (!widget.enableAnimation) return content;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: content,
      ),
    );
  }
}

class _DefaultTreeRow extends StatelessWidget {
  const _DefaultTreeRow({
    required this.item,
    required this.level,
    required this.isMultiSelect,
    required this.isExpanded,
    required this.triState,
    required this.isSelected,
    required this.onTap,
    required this.onCheckboxChanged,
    this.itemTextStyle,
    this.itemTextAlign,
    this.itemPadding,
    this.itemSpacing,
    required this.defaultIconHeight,
    required this.defaultIconWidth,
    required this.defaultIconBorderRadius,
  });

  final HierarchyItem item;
  final int level;
  final bool isMultiSelect;
  final bool isExpanded;
  final bool? triState;
  final bool isSelected;
  final VoidCallback onTap;
  final ValueChanged<bool?>? onCheckboxChanged;
  final TextStyle? itemTextStyle;
  final TextAlign? itemTextAlign;
  final EdgeInsets? itemPadding;
  final double? itemSpacing;
  final double defaultIconHeight;
  final double defaultIconWidth;
  final double defaultIconBorderRadius;

  @override
  Widget build(BuildContext context) {
    final hasChildren = !item.isLeaf;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: itemPadding ??
              EdgeInsets.only(
                left: 8.0 + level * 24.0,
                right: 16,
                top: 4 + (itemSpacing ?? 0) / 2,
                bottom: 4 + (itemSpacing ?? 0) / 2,
              ),
          child: Row(
            children: [
              if (item.prefix != null) ...[
                item.prefix!,
                const SizedBox(width: 8),
              ],
              if (hasChildren)
                AnimatedRotation(
                  turns: isExpanded ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.arrow_right_rounded,
                      color: Colors.black45, size: 24),
                )
              else
                const SizedBox(width: 24),
              if (isMultiSelect)
                Transform.scale(
                  scale: 0.85,
                  child: Checkbox(
                    value: triState,
                    tristate: true,
                    onChanged: onCheckboxChanged,
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    side: const BorderSide(color: Colors.black26, width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                )
              // else if (isSelected)
              //   Padding(
              //     padding: const EdgeInsets.only(right: 8, left: 4),
              //     child: Icon(Icons.check_circle_rounded,
              //         color: Colors.blue, size: 18),
              //   )
              else
                const SizedBox(width: 8),
              // Icon/Image
              _TreeItemIcon(
                item: item,
                defaultHeight: defaultIconHeight,
                defaultWidth: defaultIconWidth,
                defaultBorderRadius: defaultIconBorderRadius,
              ),
              if (item.icon != null ||
                  item.iconPath != null ||
                  (item.subItems != null && item.subItems!.isNotEmpty))
                const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  textAlign: itemTextAlign,
                  style: itemTextStyle ??
                      TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight:
                            hasChildren ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
              ),
              if (item.suffix != null) ...[
                const SizedBox(width: 8),
                item.suffix!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TreeItemIcon extends StatelessWidget {
  const _TreeItemIcon({
    required this.item,
    required this.defaultHeight,
    required this.defaultWidth,
    required this.defaultBorderRadius,
  });

  final HierarchyItem item;
  final double defaultHeight;
  final double defaultWidth;
  final double defaultBorderRadius;

  @override
  Widget build(BuildContext context) {
    if (item.iconPath != null) {
      final path = item.iconPath!;
      final isNetwork = path.startsWith('http');
      return SizedBox(
        width: item.iconWidth ?? defaultWidth,
        height: item.iconHeight ?? defaultHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
              item.iconBorderRadius ?? defaultBorderRadius),
          child: isNetwork
              ? Image.network(
                  path,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.broken_image_rounded,
                    color: Colors.black12,
                    size: (item.iconWidth ?? defaultWidth) * 0.7,
                  ),
                )
              : Image.asset(path, fit: BoxFit.cover),
        ),
      );
    }

    if (item.icon != null) {
      return Icon(
        item.icon,
        color: item.subItems != null && item.subItems!.isNotEmpty
            ? Colors.amber.shade400
            : Colors.blue.shade400,
        size: 18,
      );
    }

    // Default icon for folders if no custom icon/path is provided
    if (item.subItems != null && item.subItems!.isNotEmpty) {
      return Icon(
        Icons.folder_rounded,
        color: Colors.amber.shade400,
        size: 18,
      );
    }

    return const SizedBox.shrink();
  }
}

class _LoadingItem extends StatefulWidget {
  const _LoadingItem({
    this.indicator,
    required this.enableAnimation,
  });

  final Widget? indicator;
  final bool enableAnimation;

  @override
  State<_LoadingItem> createState() => _LoadingItemState();
}

class _LoadingItemState extends State<_LoadingItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    if (widget.enableAnimation) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.indicator ??
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        );

    if (!widget.enableAnimation) return child;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: child,
    );
  }
}

class _GlassWrap extends StatelessWidget {
  final Widget child;
  final bool isGlassMode;
  final double blur;
  final double connectivity;
  final BorderRadius? borderRadius;

  const _GlassWrap({
    required this.child,
    this.isGlassMode = false,
    this.blur = 10,
    this.connectivity = 0.1,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!isGlassMode) return child;

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: connectivity),
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
