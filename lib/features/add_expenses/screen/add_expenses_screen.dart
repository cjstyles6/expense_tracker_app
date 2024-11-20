import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:expense_tracker_app/features/add_expenses/controller/add_expenses_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AddExpensesScreen extends StatelessWidget {
  const AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddExpensesController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Ionicons.close, size: 30),
                ),
              ),
              20.heightBox,
              Center(
                child: const Text('Add Expenses').fontSize(30),
              ),
              10.heightBox,
              Container(
                width: .7.sw,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextField(
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              20.heightBox,
              SizedBox(
                height: 60,
                width: double.infinity,
                child: CoolDropdown(
                  defaultItem: CoolDropdownItem(
                    label: 'Select Type',
                    value: 'Select',
                  ),
                  dropdownList: controller.selectType,
                  controller: DropdownController(),
                  onChange: (value) {
                    controller.updateCategoryList(value);
                  },
                ),
              ),
              20.heightBox,
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Obx(() {
                  return CoolDropdown(
                    defaultItem: CoolDropdownItem(
                      label: 'Select Category',
                      value: 'Select',
                    ),
                    dropdownList: controller.currentCategoryList.value,
                    controller: DropdownController(),
                    onChange: (value) {
                      controller.selectedCategory.value = value;
                    },
                  );
                }),
              ),
              20.heightBox,
              GestureDetector(
                onTap: () => controller.selectDate(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() => Text(
                        controller.getFormattedDate(),
                        style: const TextStyle(fontSize: 20),
                      )),
                ),
              ),
              40.heightBox,
              ElevatedButton(
                onPressed: () => controller.addExpenses(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
