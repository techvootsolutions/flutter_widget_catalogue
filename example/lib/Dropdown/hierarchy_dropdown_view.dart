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
            prefix:
                const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
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

final List<HierarchyItem> _kCountryData = [
  HierarchyItem(title: 'United States', icon: Icons.flag_rounded),
  HierarchyItem(title: 'United Kingdom', icon: Icons.flag_rounded),
  HierarchyItem(title: 'Canada', icon: Icons.flag_rounded),
  HierarchyItem(title: 'Australia', icon: Icons.flag_rounded),
  HierarchyItem(title: 'India', icon: Icons.flag_rounded),
];

final List<HierarchyItem> _kLocationData = List.generate(
  50,
  (index) => HierarchyItem(
    title: 'City ${index + 1}',
    icon: Icons.location_on_rounded,
    suffix: Text(
      'Lat: ${(10 + index * 0.5).toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 10, color: Colors.grey),
    ),
  ),
);

final List<HierarchyItem> _kUserData = [
  HierarchyItem(
    title: 'Alex Johnson',
    subtitle: 'Senior Product Designer',
    iconPath:
        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100&h=100&fit=crop',
  ),
  HierarchyItem(
    title: 'Sarah Williams',
    subtitle: 'Lead Developer',
    iconPath:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop',
  ),
  HierarchyItem(
    title: 'Michael Chen',
    subtitle: 'Marketing Specialist',
    iconPath:
        'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=100&h=100&fit=crop',
  ),
  HierarchyItem(
    title: 'Emily Davis',
    subtitle: 'UX Researcher',
    iconPath:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&h=100&fit=crop',
  ),
];

final List<HierarchyItem> _kTimerData = [
  HierarchyItem(title: '1 Hour', icon: Icons.timer_outlined),
  HierarchyItem(title: '20 Minutes', icon: Icons.timer_outlined),
  HierarchyItem(title: '5 Minutes', icon: Icons.timer_outlined),
  HierarchyItem(title: '1 Minute', icon: Icons.timer_outlined),
];

final List<HierarchyItem> _kLightData = [
  HierarchyItem(title: 'Bright Light', icon: Icons.light_mode_rounded),
  HierarchyItem(title: 'Medium Light', icon: Icons.wb_sunny_rounded),
  HierarchyItem(title: 'Low Light', icon: Icons.nightlight_round),
];

final List<HierarchyItem> _kCameraData = [
  HierarchyItem(title: 'Take Photo', icon: Icons.camera_alt_rounded),
  HierarchyItem(title: 'Record Slo-mo', icon: Icons.slow_motion_video_rounded),
  HierarchyItem(title: 'Record Video', icon: Icons.videocam_rounded),
  HierarchyItem(title: 'Take Selfie', icon: Icons.portrait_rounded),
];

final List<HierarchyItem> _kFilterData = [
  HierarchyItem(title: 'New Arrivals', icon: Icons.fiber_new_rounded),
  HierarchyItem(title: 'Best Sellers', icon: Icons.trending_up_rounded),
  HierarchyItem(title: 'Discounts', icon: Icons.sell_rounded),
  HierarchyItem(title: 'Top Rated', icon: Icons.star_rounded),
  HierarchyItem(title: 'Free Shipping', icon: Icons.local_shipping_rounded),
  HierarchyItem(title: 'In Stock', icon: Icons.check_circle_outline_rounded),
  HierarchyItem(title: 'On Sale', icon: Icons.monetization_on_rounded),
  HierarchyItem(title: 'Limited Edition', icon: Icons.auto_awesome_rounded),
  HierarchyItem(title: 'Premium Quality', icon: Icons.verified_rounded),
  HierarchyItem(title: 'New Arrivals', icon: Icons.fiber_new_rounded),
];

final List<HierarchyItem> _kProductData = List.generate(
  50,
  (index) => HierarchyItem(
    title: 'Product - ${index + 1}',
    icon: Icons.inventory_2_rounded,
    suffix: index % 5 == 0
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'New',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        : null,
  ),
);

class HierarchyDropdownView extends StatefulWidget {
  const HierarchyDropdownView({super.key});

  @override
  State<HierarchyDropdownView> createState() => _HierarchyDropdownViewState();
}

class _HierarchyDropdownViewState extends State<HierarchyDropdownView> {
  String selectedLabel = '';
  String selectedCountry = '';
  String selectedProduct = '';
  String selectedFilters = '';
  String selectedNested = '';
  String selectedLocation = '';
  String selectedUser = '';
  String selectedTimer = '';
  String selectedLight = '';
  String selectedCamera = '';

  // Pagination State
  final List<HierarchyItem> _allLocations = _kLocationData;
  List<HierarchyItem> _paginatedLocations = [];
  bool _isLoadingMore = false;
  int _currentPage = 0;
  static const int _pageSize = 15;

  @override
  void initState() {
    super.initState();
    _loadInitialLocations();
  }

  void _loadInitialLocations() {
    _currentPage = 1;
    _paginatedLocations = _allLocations.take(_pageSize).toList();
  }

  Future<void> _loadMoreLocations() async {
    if (_isLoadingMore || _paginatedLocations.length >= _allLocations.length) {
      return;
    }

    setState(() => _isLoadingMore = true);

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final int start = _currentPage * _pageSize;
    final newItems = _allLocations.skip(start).take(_pageSize).toList();

    if (mounted) {
      setState(() {
        _paginatedLocations.addAll(newItems);
        _currentPage++;
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        elevation: 4,
        title: const Text(
          'Dropdowns',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Single-Select Minimal',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kCountryData,
            hint: 'Select Country',
            showSearch: false,
            isMultiSelect: false,
            showChips: false,
            onChanged: (label) => setState(() => selectedCountry = label),
          ),
          const SizedBox(height: 12),
          const Text(
            'Searchable Dropdown (Products)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kProductData,
            hint: 'Search Products...',
            showSearch: true,
            showChips: false,
            isMultiSelect: false,
            onChanged: (label) => setState(() => selectedProduct = label),
          ),
          const SizedBox(height: 12),
          const Text(
            'Multi-Select Single-Line (Scrollable Chips)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kFilterData,
            hint: 'Select Filters',
            isMultiSelect: true,
            showChips: true,
            isMultiline: false,
            onChanged: (label) => setState(() => selectedFilters = label),
          ),
          const SizedBox(height: 12),
          const Text(
            'Multi-Select Dropdown',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kFilterData,
            hint: 'Select Filters',
            isMultiSelect: true,
            showChips: true,
            isMultiline: true,
            onChanged: (label) => setState(() => selectedFilters = label),
          ),
          const SizedBox(height: 12),
          const Text(
            'Hierarchical Single-Select',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kSampleData,
            hint: 'Select Nested Item',
            isMultiSelect: false,
            showSearch: true,
            onChanged: (label) => setState(() => selectedNested = label),
          ),
          const SizedBox(height: 12),
          const Text(
            'Multi-Select Tree',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kSampleData,
            hint: 'Select Multiple Items',
            isMultiline: true,
            isMultiSelect: true,
            onChanged: (label) => setState(() => selectedLabel = label),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select at least one item';
              }
              return null;
            },
            itemSpacing: 2,
            listPadding: const EdgeInsets.symmetric(vertical: 16),
            itemTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Autocomplete Dropdown (Locations)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _paginatedLocations,
            hint: 'Search Location...',
            showSearch: true,
            isMultiSelect: false,
            isLoadingMore: _isLoadingMore,
            onLoadMore: _loadMoreLocations,
            enableAnimation: true,
            onChanged: (label) => setState(() => selectedLocation = label),
          ),
          const SizedBox(height: 12),
          const Text(
            'Custom Item Dropdown (Users)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kUserData,
            hint: 'Select User',
            isMultiSelect: false,
            onChanged: (label) => setState(() => selectedUser = label),
            itemBuilder: (context, item, level, isExpanded, isSelected,
                onExpand, onSelect) {
              return ListTile(
                onTap: onSelect,
                leading: CircleAvatar(
                  backgroundImage: item.iconPath != null
                      ? NetworkImage(item.iconPath!)
                      : null,
                  radius: 18,
                  backgroundColor: Colors.blue.shade100,
                  child: item.iconPath == null ? Text(item.title[0]) : null,
                ),
                title: Text(item.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text(item.subtitle ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: isSelected == true
                    ? const Icon(Icons.check_circle_rounded,
                        color: Colors.blue, size: 20)
                    : null,
              );
            },
            headerBuilder: (context, label, isOpen, onTap) {
              final user = _kUserData.firstWhere((u) => u.title == label,
                  orElse: () => _kUserData.first);
              final hasSelected = label.isNotEmpty;

              return InkWell(
                onTap: onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      if (hasSelected)
                        CircleAvatar(
                          backgroundImage: user.iconPath != null
                              ? NetworkImage(user.iconPath!)
                              : null,
                          radius: 14,
                          backgroundColor: Colors.blue.shade100,
                        )
                      else
                        const Icon(Icons.person_outline_rounded,
                            color: Colors.black38),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          hasSelected ? user.title : 'Select a team member',
                          style: TextStyle(
                            color: hasSelected ? Colors.black : Colors.black38,
                            fontWeight: hasSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      Icon(isOpen
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'Custom Header & Builder',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          HierarchySearchableDropdown(
            items: _kSampleData,
            hint: 'Choose Category',
            isMultiSelect: false,
            onChanged: (label) => setState(() => selectedLabel = label),
            headerBuilder: (context, label, isOpen, onTap) => InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isOpen ? Colors.blue : Colors.black12, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.category_rounded,
                        color: Colors.blue.shade600, size: 22),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        label.isNotEmpty ? label : 'Select a Category',
                        style: TextStyle(
                          color:
                              label.isNotEmpty ? Colors.black : Colors.black38,
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
                      color: Colors.black45,
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
                color: isSelected == true ? Colors.blue.shade300 : Colors.black,
                size: 18,
              ),
              title: Text(
                item.title,
                style: TextStyle(
                  color: isSelected == true ? Colors.blue : Colors.black,
                  fontWeight: item.isLeaf ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              trailing: !item.isLeaf
                  ? Icon(
                      isExpanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: Colors.black,
                      size: 18,
                    )
                  : (isSelected == true
                      ? Icon(Icons.check_rounded,
                          color: Colors.blue.shade300, size: 18)
                      : null),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Glass Dropdown (iOS Style)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // child: Image.network(
                  //   'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&q=80&w=1000',
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              Column(
                children: [
                  HierarchySearchableDropdown(
                    items: _kLightData,
                    hint: 'Control Center (Light)',
                    isGlassMode: true,
                    showSearch: false,
                    blur: 15,
                    itemPadding: EdgeInsets.symmetric(vertical: 5),
                    connectivity: 0.2,
                    onChanged: (label) => setState(() => selectedLight = label),
                  ),
                  const SizedBox(height: 12),
                  HierarchySearchableDropdown(
                    items: _kTimerData,
                    hint: 'Quick Timer',
                    isGlassMode: true,
                    itemPadding: EdgeInsets.symmetric(vertical: 5),
                    blur: 20,
                    connectivity: 0.15,
                    onChanged: (label) => setState(() => selectedTimer = label),
                  ),
                  const SizedBox(height: 12),
                  HierarchySearchableDropdown(
                    items: _kCameraData,
                    hint: 'Camera Actions',
                    isGlassMode: true,
                    blur: 25,
                    isMultiSelect: true,
                    connectivity: 0.25,
                    onChanged: (label) =>
                        setState(() => selectedCamera = label),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
