import 'package:flutter/material.dart';
import 'package:simple_weather/models/city_model.dart';
import 'package:simple_weather/theme/theme.dart';

class SearchField extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onClear,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _controller.text = widget.value;
      //  widget.onClear();
      }
    });
  }

  @override
  void didUpdateWidget(covariant SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.borders.withAlpha(200),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        maxLines: 1,

        style: TextStyle(
          color: AppColors.darkThemeText,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.6,
          overflow: TextOverflow.ellipsis,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 18,
          ),
          hintText: 'Пошук міста...',
          hintStyle: TextStyle(
            color: AppColors.darkThemeText.withAlpha(170),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.6,
            overflow: TextOverflow.ellipsis,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class SearchResultsList extends StatelessWidget {
  final List<CityModel> cities;
  final Function(CityModel) onSelect;

  const SearchResultsList({
    super.key,
    required this.cities,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (cities.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: AppColors.borders.withAlpha(200),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cities.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => _CityTile(
          city: cities[index],
          onTap: () => onSelect(cities[index]),
        ),
      ),
    );
  }
}

class _CityTile extends StatelessWidget {
  final CityModel city;
  final VoidCallback onTap;

  const _CityTile({
    required this.city,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        city.name,
        maxLines: 1,
        style: TextStyle(
          color: AppColors.darkThemeText,
          fontSize: 16,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: city.oblast != null
          ? Text(
              city.oblast!,
              maxLines: 1,
              style: TextStyle(
                color: AppColors.darkThemeText.withAlpha(150),
                fontSize: 14,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : null,
      trailing: Icon(
        Icons.location_on_rounded,
        color: AppColors.primaryColor,
        size: 34,
      ),
      onTap: onTap,
    );
  }
}
