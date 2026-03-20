import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

/// A hierarchical item for the [HierarchySearchableDropdown].
class HierarchyItem {
  const HierarchyItem({
    required this.title,
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
    this.isMultiSelect = true,
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

  @override
  State<HierarchySearchableDropdown> createState() =>
      _HierarchySearchableDropdownState();
}

class _HierarchySearchableDropdownState
    extends State<HierarchySearchableDropdown> {
  final Set<String> _selectedIds = {};
  final Set<String> _expandedIds = {};

  bool _isOpen = false;
  String _searchQuery = '';
  String? _errorText;
  final TextEditingController _searchController = TextEditingController();

  String get _selectedLabel {
    if (_selectedIds.isEmpty) return '';
    final buf = <String>[];
    for (final item in widget.items) {
      item.collectSelectedTitles(_selectedIds, buf);
    }
    return buf.join(', ');
  }

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
      if (!_isOpen) {
        _searchQuery = '';
        _searchController.clear();
      }
    });
  }

  void _onLeafTapped(HierarchyItem leaf) {
    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedIds.contains(leaf.title)) {
          _selectedIds.remove(leaf.title);
        } else {
          _selectedIds.add(leaf.title);
        }
      } else {
        _selectedIds
          ..clear()
          ..add(leaf.title);
        _isOpen = false;
      }
    });
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
        _selectedIds.addAll(leaves);
      } else {
        _selectedIds.removeAll(leaves);
      }
    });
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = _selectedLabel;
    return Column(
      children: [
        if (widget.headerBuilder != null)
          widget.headerBuilder!(context, label, _isOpen, _toggleDropdown)
        else
          _DefaultHeader(
            label: label,
            hint: widget.hint,
            isMultiline: widget.isMultiline,
            isOpen: _isOpen,
            errorText: _errorText,
            onTap: _toggleDropdown,
          ),
        const SizedBox(height: 8),
        if (_isOpen)
          _DropdownPanel(
            items: widget.items,
            isMultiSelect: widget.isMultiSelect,
            selectedIds: _selectedIds,
            expandedIds: _expandedIds,
            searchQuery: _searchQuery,
            searchController: _searchController,
            maxHeight: widget.maxHeight,
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
            onSearchChanged: (q) =>
                setState(() => _searchQuery = q.toLowerCase()),
            onLeafTapped: _onLeafTapped,
            onGroupToggle: _onGroupToggle,
            onExpandToggle: _onExpandToggle,
          ),
      ],
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
  });

  final String label;
  final String hint;
  final bool isMultiline;
  final bool isOpen;
  final VoidCallback onTap;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final hasLabel = label.isNotEmpty;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: GlassWrap(
            isGlassMode: true,
            blur: 15,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: hasError
                      ? Colors.red.shade400
                      : (isOpen ? Colors.blue.shade400 : Colors.white10),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.checklist_rounded,
                    color: hasError
                        ? Colors.red.shade300
                        : (hasLabel ? Colors.blue.shade300 : Colors.white54),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      hasLabel ? label : hint,
                      maxLines: isMultiline ? null : 1,
                      overflow: isMultiline
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hasLabel ? Colors.white : Colors.white54,
                        fontSize: 16,
                        fontWeight:
                            hasLabel ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.white70),
                  ),
                ],
              ),
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

class _DropdownPanel extends StatelessWidget {
  const _DropdownPanel({
    required this.items,
    required this.isMultiSelect,
    required this.selectedIds,
    required this.expandedIds,
    required this.searchQuery,
    required this.searchController,
    required this.maxHeight,
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
    required this.onSearchChanged,
    required this.onLeafTapped,
    required this.onGroupToggle,
    required this.onExpandToggle,
  });

  final List<HierarchyItem> items;
  final bool isMultiSelect;
  final Set<String> selectedIds;
  final Set<String> expandedIds;
  final String searchQuery;
  final TextEditingController searchController;
  final double maxHeight;
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
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<HierarchyItem> onLeafTapped;
  final void Function(HierarchyItem, bool) onGroupToggle;
  final ValueChanged<String> onExpandToggle;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: GlassWrap(
        isGlassMode: true,
        blur: 25,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: decoration ??
              BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: Colors.white10),
                borderRadius: BorderRadius.circular(20),
              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (searchBuilder != null)
                searchBuilder!(
                    context, searchController, searchQuery, onSearchChanged)
              else
                _DefaultSearchBar(
                  controller: searchController,
                  query: searchQuery,
                  onChanged: onSearchChanged,
                ),
              const Divider(color: Colors.white12, height: 1),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding:
                      listPadding ?? const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (_, i) => _InternalTreeItem(
                    key: ValueKey(items[i].title),
                    item: items[i],
                    level: 0,
                    searchQuery: searchQuery,
                    parentMatches: false,
                    isMultiSelect: isMultiSelect,
                    selectedIds: selectedIds,
                    expandedIds: expandedIds,
                    itemBuilder: itemBuilder,
                    itemTextStyle: itemTextStyle,
                    itemTextAlign: itemTextAlign,
                    itemPadding: itemPadding,
                    itemSpacing: itemSpacing,
                    defaultIconHeight: defaultIconHeight,
                    defaultIconWidth: defaultIconWidth,
                    defaultIconBorderRadius: defaultIconBorderRadius,
                    onLeafTapped: onLeafTapped,
                    onGroupToggle: onGroupToggle,
                    onExpandToggle: onExpandToggle,
                  ),
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
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.white38),
          prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: Colors.white38, size: 20),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _InternalTreeItem extends StatelessWidget {
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

  bool get _isExpanded => expandedIds.contains(item.title);
  bool get _selfMatches =>
      searchQuery.isEmpty || item.title.toLowerCase().contains(searchQuery);
  bool get _childMatches => !item.isLeaf && item.matchesQuery(searchQuery);
  bool get _shouldShow => _selfMatches || parentMatches || _childMatches;

  bool? get _triState {
    if (item.isLeaf) return selectedIds.contains(item.title);
    final leaves = item.allLeafTitles;
    final count = leaves.where(selectedIds.contains).length;
    if (count == 0) return false;
    if (count == leaves.length) return true;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShow) return const SizedBox.shrink();

    final forceExpand =
        searchQuery.isNotEmpty && !_selfMatches && _childMatches;
    final isActuallyExpanded = _isExpanded || forceExpand;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (itemBuilder != null)
          itemBuilder!(
            context,
            item,
            level,
            isActuallyExpanded,
            isMultiSelect ? _triState : selectedIds.contains(item.title),
            () => onExpandToggle(item.title),
            () {
              if (item.isLeaf) {
                onLeafTapped(item);
              } else if (isMultiSelect) {
                onGroupToggle(item, _triState != true);
              }
            },
          )
        else
          _DefaultTreeRow(
            item: item,
            level: level,
            isMultiSelect: isMultiSelect,
            isExpanded: isActuallyExpanded,
            triState: isMultiSelect ? _triState : null,
            isSelected: !isMultiSelect && selectedIds.contains(item.title),
            onTap: () {
              if (!item.isLeaf) {
                onExpandToggle(item.title);
              } else {
                onLeafTapped(item);
              }
            },
            onCheckboxChanged:
                isMultiSelect ? (v) => onGroupToggle(item, v ?? false) : null,
            itemTextStyle: itemTextStyle,
            itemTextAlign: itemTextAlign,
            itemPadding: itemPadding,
            itemSpacing: itemSpacing,
            defaultIconHeight: defaultIconHeight,
            defaultIconWidth: defaultIconWidth,
            defaultIconBorderRadius: defaultIconBorderRadius,
          ),
        if (!item.isLeaf && isActuallyExpanded)
          ...item.subItems!.map(
            (sub) => _InternalTreeItem(
              key: ValueKey(sub.title),
              item: sub,
              level: level + 1,
              searchQuery: searchQuery,
              parentMatches: _selfMatches || parentMatches,
              isMultiSelect: isMultiSelect,
              selectedIds: selectedIds,
              expandedIds: expandedIds,
              itemBuilder: itemBuilder,
              itemTextStyle: itemTextStyle,
              itemTextAlign: itemTextAlign,
              itemPadding: itemPadding,
              itemSpacing: itemSpacing,
              defaultIconHeight: defaultIconHeight,
              defaultIconWidth: defaultIconWidth,
              defaultIconBorderRadius: defaultIconBorderRadius,
              onLeafTapped: onLeafTapped,
              onGroupToggle: onGroupToggle,
              onExpandToggle: onExpandToggle,
            ),
          ),
      ],
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
                    color: Colors.white70, size: 24),
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
                  activeColor: Colors.blue.shade400,
                  checkColor: Colors.white,
                  side: const BorderSide(color: Colors.white38, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              )
            else if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 4),
                child: Icon(Icons.check_circle_rounded,
                    color: Colors.blue.shade300, size: 18),
              )
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
                      color: Colors.white,
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
                    color: Colors.white24,
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
            ? Colors.amber.shade300
            : Colors.blue.shade300,
        size: 18,
      );
    }

    // Default icon for folders if no custom icon/path is provided
    if (item.subItems != null && item.subItems!.isNotEmpty) {
      return Icon(
        Icons.folder_rounded,
        color: Colors.amber.shade300,
        size: 18,
      );
    }

    return const SizedBox.shrink();
  }
}
