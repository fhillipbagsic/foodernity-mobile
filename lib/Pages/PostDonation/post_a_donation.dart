import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Models/Category.dart';
import 'package:my_app/Pages/PostDonation/step_three.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

File donationImage;
TextEditingController donationNameController = TextEditingController();
Future<List<Category>> futureCategoryForms;
List<Category> categoryForms = [];
List selectedCategories = [];
List categories = [
  "Eggs",
  "Canned goods",
  "Instant Noodles",
  "Rice",
  "Cereals",
  "Tea/Coffee/Milk/Sugar",
  "Biscuits",
  "Condiments and sauces",
  "Beverages",
  "Snacks"
];
Future<List<Category>> addCategoryForm() async {
  categoryForms.add(new Category(category: '', date: '', quantity: ''));
  return categoryForms;
}

Future<List<Category>> removeCategoryForm(int index) async {
  categoryForms.removeAt(index);
  return categoryForms;
}

class PostADonation extends StatefulWidget {
  @override
  State<PostADonation> createState() => _PostADonationState();
}

class _PostADonationState extends State<PostADonation> {
  @override
  void initState() {
    super.initState();
    futureCategoryForms = addCategoryForm();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: SafeArea(
            child: Container(
          color: Colors.grey[100],
          child: FutureBuilder<List<Category>>(
            future: futureCategoryForms,
            builder: (context, snapshot) {
              Widget categoryFormSliverList;
              if (snapshot.hasData) {
                categoryFormSliverList = SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return categoryForm(snapshot.data[index], index);
                  }, childCount: snapshot.data.length),
                );
              } else {
                categoryFormSliverList = SliverToBoxAdapter(
                  child: Text('wait'),
                );
              }
              return CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: Text('Post a Donation'),
                  ),
                  imageForm(),
                  donationName(),
                  categoryTitle(),
                  categoryFormSliverList,
                  addButton(),
                  proceedButton()
                ],
              );
            },
          ),
        )),
      );
    });
  }

  Widget imageForm() {
    Future<void> getImage() async {
      final picker = ImagePicker();

      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null && pickedFile.path != null) {
        setState(() {
          donationImage = File(pickedFile.path);
        });
      }
    }

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Donation Image',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 20.h,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: donationImage == null
                      ? GestureDetector(
                          onTap: getImage,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library_rounded,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Browse Image',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13.sp,
                                  )),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: getImage,
                          child:
                              Image.file(donationImage, fit: BoxFit.fitWidth),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget donationName() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Donation Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: donationNameController,
                  validator: (String value) {
                    var validCharacters = RegExp(r'^[a-zA-Z ]+$');

                    if (value.isEmpty) {
                      return 'Donation Name is required';
                    } else {
                      if (validCharacters.hasMatch(value)) {
                        //goods

                        donationNameController.text = value;
                      } else {
                        return "Only letters are allowed in the Donation Name field.";
                      }
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white, width: 0)),
                    border: OutlineInputBorder(),
                    hintText: 'E.g. assorted goods',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryTitle() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food Categories',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text('Choose all the food categories of your donation',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget categoryForm(Category category, int index) {
    List unselectedCategories = [];
    TextEditingController expiryController = TextEditingController();

    for (var category in categoryForms) {
      selectedCategories.add(category.category);
    }

    // for (var category in categories) {
    //   if(selectedCategories.contains(category)) {

    //   }
    // }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            index == 0
                ? SizedBox()
                : Align(
                    alignment: Alignment.topRight,
                    child: deleteCategory(index, category.category),
                  ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: DropdownButton(
                isExpanded: true,
                hint: category.category == ''
                    ? Text('Choose a category')
                    : Text(category.category),
                items: categories.map(
                  (category) {
                    return DropdownMenuItem(
                        value: category, child: Text(category));
                  },
                ).toList(),
                onChanged: (selected) {
                  setState(() {
                    category.category = selected;
                  });
                },
                underline: SizedBox(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                'Earliest Expiry:',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.only(left: 15, right: 5),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DateTimeField(
                initialValue: DateTime.tryParse(category.date),
                format: DateFormat('yyyy-MM-dd'),
                controller: expiryController,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: getMinExpiryDate(category.category),
                    initialDate:
                        currentValue ?? getMinExpiryDate(category.category),
                    lastDate: getMaxExpiryDate(category.category),
                  );
                  if (date != null) {
                    String formattedDate = date.year.toString() +
                        '-' +
                        date.month.toString() +
                        '-' +
                        date.day.toString();
                    category.date = formattedDate;
                    return date;
                  }

                  return currentValue;
                },
                enabled: category.category == '' ? false : true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: category.date == ''
                        ? 'Select expiry date'
                        : category.date),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                'Quantity:',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                initialValue: category.quantity,
                // controller: quantityController,
                enabled: category.category == '' ? false : true,
                onChanged: (value) {
                  category.quantity = value;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'piece/s'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addButton() {
    return SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () {
          for (var category in categoryForms) {
            if (category.category == '' ||
                category.date == '' ||
                category.quantity == '') {
              return print('select first');
            }
          }
          addCategoryForm();
          setState(() {});
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.blue,
            ),
            Text(
              'Add another category',
              style: TextStyle(color: Colors.blue, fontSize: 13.sp),
            )
          ],
        ),
      ),
    ));
  }

  Widget deleteCategory(int index, String category) {
    return GestureDetector(
      onTap: () {
        removeCategoryForm(index);

        selectedCategories.remove(category);

        setState(() {});
      },
      child: Container(child: Icon(Icons.close)),
    );
  }

  Widget proceedButton() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () {
            List categoryInputs = [];
            for (var category in categoryForms) {
              categoryInputs.add(category.category);
              categoryInputs.add(category.date);
              categoryInputs.add(category.quantity);
            }
//donationImage == null ||
            if (donationNameController.text == '' ||
                categoryInputs.any((element) => element == '')) {
              print('fill up first');
              return;
            }

            var categArr = [];
            var dateArr = [];
            var qtyArr = [];

            for (var category in categoryForms) {
              categArr.add(category.category);
              dateArr.add(category.date);
              qtyArr.add(category.quantity);
            }
            print(categArr);
            print(dateArr);
            print(qtyArr);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StepThree(),
              ),
            );
            postDonation(categArr, qtyArr, donationImage, donationName);
            donationImage = null;
            donationNameController.clear();
            categoryForms.clear();
          },
          child: Text('Proceed'),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue, width: 2, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

DateTime getMinExpiryDate(String category) {
  switch (category) {
    case 'Eggs':
      return DateTime.now().add(Duration(days: 14));
    default:
      return DateTime.now().add(Duration(days: 180));
  }
}

DateTime getMaxExpiryDate(String category) {
  switch (category) {
    case 'Eggs':
      return DateTime.now().add(Duration(days: 42));
    default:
      return DateTime(2100);
  }
}

void postDonation(dynamic donationCateg, dynamic donationQty, dynamic img,
    dynamic donationName) async {
  final prefs = await SharedPreferences.getInstance();
  var userID = prefs.getInt("userID");

  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('MM/dd/yyyy');
  final String formattedDate = formatter.format(now);

  final cloudinary = CloudinaryPublic('dftq12ab0', 'b4jy8nar', cache: false);
  CloudinaryResponse responseImg = await cloudinary.uploadFile(
    CloudinaryFile.fromFile(img.path,
        resourceType: CloudinaryResourceType.Image),
  );
}
