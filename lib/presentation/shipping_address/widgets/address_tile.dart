import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';

class AddressTile extends StatefulWidget {
  final bool isSelected;
  final bool isDefault;
  final GetAddress data;
  final VoidCallback onTap;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const AddressTile({
    super.key,
    this.isSelected = false,
    this.isDefault = false,
    required this.data,
    required this.onTap,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color:
              widget.isSelected ? ColorName.primaryAccent : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(
              color: widget.isSelected ? ColorName.primary : ColorName.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data.attributes.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(16.0),
            Text(
              widget.data.attributes.street,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: widget.isSelected ? ColorName.black : ColorName.grey,
              ),
            ),
            const SpaceHeight(16.0),
            Text(
              widget.data.attributes.phone,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: widget.isSelected ? ColorName.black : ColorName.grey,
              ),
            ),
            const SpaceHeight(16.0),
            Row(
              children: [
                Button.filled(
                  onPressed: widget.onEditTap,
                  label: 'Edit',
                  width: 80.0,
                ),
                const SpaceWidth(16.0),
                IconButton(
                  onPressed: widget.onDeleteTap,
                  icon: ImageIcon(
                    const AssetImage(Images.trashIcon),
                    color: widget.isSelected ? ColorName.white : ColorName.red,
                  ),
                ),
              ],
            ),
            if (widget.isDefault) const SpaceHeight(16.0),
            if (widget.isDefault)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Alamat Utama',
                    style: TextStyle(
                      fontSize: 10,
                      color:
                          widget.isSelected ? ColorName.black : ColorName.grey,
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
