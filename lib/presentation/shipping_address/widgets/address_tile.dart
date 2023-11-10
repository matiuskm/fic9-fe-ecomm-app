import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/default_address_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';

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
  Widget defaultLabel() {
    if (widget.isDefault) {
      return Chip(
        label: const Text('Utama'),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.grey.shade700,
        labelPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: -5),
        padding: const EdgeInsets.all(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }
    return const Text("");
  }

  Widget addMenu(int id) {
    return GestureDetector(
      onTapDown: (details) async {
        double left = details.globalPosition.dx;
        double top = details.globalPosition.dy;
        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, 0, 0),
          items: [
            const PopupMenuItem(
              value: 1,
              child: Text("Jadikan Alamat Utama"),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text("Hapus Alamat"),
            ),
          ],
          elevation: 8.0,
        ).then((value) async {
          if (value != null && value == 1) {
            final user = await AuthLocalDatasource().getUser();
            if (context.mounted) {
              context.read<GetAddressBloc>().add(
                    GetAddressEvent.setAsDefaultAddress(
                      id,
                      DefaultAddressRequestModel(
                        data: Data(userId: user.id ?? 0, isDefault: true),
                      ),
                    ),
                  );
            }
          } else if (value != null && value == 2) {
            widget.onDeleteTap();
          }
        });
      },
      child: const Icon(Icons.more_vert),
    );
  }

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
            color: widget.isSelected ? ColorName.primary : ColorName.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.data.attributes.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  height: 20,
                  width: widget.data.attributes.isDefault ? null : 0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 110, 186, 73),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'UTAMA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            Text(
              widget.data.attributes.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(8.0),
            Row(
              children: [
                const Icon(Icons.phone,
                    color: Color.fromARGB(255, 76, 76, 111)),
                const SpaceWidth(12.0),
                Text(
                  widget.data.attributes.phone,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: widget.isSelected ? ColorName.black : ColorName.grey,
                  ),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            Row(
              children: [
                const Icon(Icons.place,
                    color: Color.fromARGB(255, 76, 76, 111)),
                const SpaceWidth(12.0),
                Expanded(
                  child: Text(
                    widget.data.attributes.completeAddress,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          widget.isSelected ? ColorName.black : ColorName.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button.filled(
                  onPressed: widget.onEditTap,
                  label: 'Edit',
                  width: 80.0,
                ),
                const SpaceWidth(8.0),
                widget.data.attributes.isDefault
                    ? const Spacer()
                    : addMenu(widget.data.id),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
