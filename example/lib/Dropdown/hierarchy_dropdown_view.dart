import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

final List<HierarchyItem> _kSampleData = [
  HierarchyItem(
    title: 'Electronics',
    icon: Icons.electrical_services_rounded,
    subItems: [
      HierarchyItem(
        title: 'Smartphones',
        icon: Icons.phone_android_rounded,
        subItems: [
          HierarchyItem(
            title: 'iPhone 15 Pro',
            icon: Icons.apple_rounded,
            suffix: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('HOT',
                  style: TextStyle(color: Colors.white, fontSize: 8)),
            ),
          ),
          HierarchyItem(
            title: 'Samsung S24 Ultra',
            icon: Icons.android_rounded,
            prefix: const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
          ),
          HierarchyItem(
              title: 'Google Pixel 8', icon: Icons.phone_android_rounded),
        ],
      ),
      HierarchyItem(
        title: 'Laptops',
        icon: Icons.laptop_rounded,
        subItems: [
          HierarchyItem(title: 'MacBook Air M3'),
          HierarchyItem(title: 'Dell XPS 15'),
          HierarchyItem(title: 'Razer Blade 14'),
        ],
      ),
    ],
  ),
  HierarchyItem(
    title: 'Home & Living',
    icon: Icons.home_rounded,
    subItems: [
      HierarchyItem(
        title: 'Furniture',
        icon: Icons.chair_rounded,
        subItems: [
          HierarchyItem(title: 'Velvet Sofa'),
          HierarchyItem(title: 'Dining Table'),
          HierarchyItem(title: 'Ergonomic Chair'),
        ],
      ),
      HierarchyItem(
        title: 'Lighting',
        icon: Icons.lightbulb_rounded,
        subItems: [
          HierarchyItem(title: 'Smart LED Bulb'),
          HierarchyItem(title: 'Floor Lamp'),
        ],
      ),
    ],
  ),
  HierarchyItem(
    title: 'Fashion',
    icon: Icons.checkroom_rounded,
    subItems: [
      HierarchyItem(
        title: 'Men',
        subItems: [
          HierarchyItem(title: 'Denim Jacket'),
          HierarchyItem(title: 'Chino Pants'),
        ],
      ),
      HierarchyItem(
        title: 'Women',
        subItems: [
          HierarchyItem(
            title: 'Floral Dress',
            iconPath:
                'https://img.freepik.com/free-photo/summer-fashion-portrait-young-woman-floral-dress_273609-19973.jpg',
            iconHeight: 30,
            iconWidth: 30,
            iconBorderRadius: 15, // Circle
          ),
          HierarchyItem(
              title: 'Leather Boots', icon: Icons.shopping_bag_rounded),
          HierarchyItem(
            title: 'Plain T-Shirt',
            suffix: Icon(Icons.new_releases_rounded,
                color: Colors.blue.shade200, size: 16),
          ), // No icon, but has suffix
        ],
      ),
    ],
  ),
];

class HierarchyDropdownView extends StatefulWidget {
  const HierarchyDropdownView({super.key});

  @override
  State<HierarchyDropdownView> createState() => _HierarchyDropdownViewState();
}

class _HierarchyDropdownViewState extends State<HierarchyDropdownView> {
  String _selectedLabel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Hierarchy Suite',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.indigo.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MULTI-SELECT TREE',
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Check & Select',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                HierarchySearchableDropdown(
                  items: _kSampleData,
                  hint: 'Select Multiple Items',
                  isMultiline: false,
                  isMultiSelect: true,
                  onChanged: (label) => setState(() => _selectedLabel = label),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select at least one item';
                    }
                    return null;
                  },
                  itemSpacing: 8,
                  listPadding: const EdgeInsets.symmetric(vertical: 16),
                  itemTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 80),
                const Text(
                  'MODERN MINIMALIST',
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fully Customized',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                HierarchySearchableDropdown(
                  items: _kSampleData,
                  hint: 'Choose Category',
                  isMultiSelect: false,
                  onChanged: (label) => setState(() => _selectedLabel = label),
                  headerBuilder: (context, label, isOpen, onTap) => InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.style_rounded,
                              color: Colors.blue.shade200, size: 22),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              label.isNotEmpty ? label : 'Select a Style',
                              style: TextStyle(
                                color: label.isNotEmpty
                                    ? Colors.white
                                    : Colors.white60,
                                fontWeight: label.isNotEmpty
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          Icon(
                            isOpen
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemBuilder: (context, item, level, isExpanded, isSelected,
                          onExpand, onSelect) =>
                      ListTile(
                    contentPadding:
                        EdgeInsets.only(left: 16.0 + level * 20.0, right: 16),
                    onTap: item.isLeaf ? onSelect : onExpand,
                    leading: Icon(
                      item.icon ??
                          (item.isLeaf
                              ? Icons.circle_outlined
                              : Icons.folder_open_rounded),
                      color: isSelected == true
                          ? Colors.blue.shade300
                          : Colors.white60,
                      size: 18,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: isSelected == true
                            ? Colors.blue.shade50
                            : Colors.white70,
                        fontWeight:
                            item.isLeaf ? FontWeight.normal : FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    trailing: !item.isLeaf
                        ? Icon(
                            isExpanded
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                            color: Colors.white30,
                            size: 18,
                          )
                        : (isSelected == true
                            ? Icon(Icons.check_rounded,
                                color: Colors.blue.shade300, size: 18)
                            : null),
                  ),
                ),
                const SizedBox(height: 60),
                if (_selectedLabel.isNotEmpty) ...[
                  const Text(
                    'SELECTED ENTITIES',
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _SelectionCard(label: _selectedLabel),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return GlassWrap(
      isGlassMode: true,
      blur: 20,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.checklist_rtl_rounded, color: Colors.blue.shade300),
                const SizedBox(width: 12),
                const Text(
                  'Active Selection',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 15, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
