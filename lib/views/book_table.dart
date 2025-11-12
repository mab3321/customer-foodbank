import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/Controllers/book_table_controller.dart';
import '/models/time_slot.dart';
import '/services/validators.dart';
import '/utils/font_size.dart';
import '/utils/size_config.dart';
import '/utils/theme_colors.dart';
import '/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class BookTable extends StatefulWidget {
  final restaurantId;
  const BookTable({Key? key, required this.restaurantId}) : super(key: key);

  @override
  _BookTableState createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  final _formKey = GlobalKey<FormState>();
  Validators validators = Validators();
  final bookTableController = Get.put(BookTableController());
  int? timeSlotListIndex = 0;
  var mainHeight, mainWidth;
  double guestNo = 1.0;
  DatePickerController _controller = DatePickerController();
  DateTime _selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  String? timeSlotID;
  String? currentMonth = new DateFormat("MMMM y").format(DateTime.now());

  @override
  void initState() {
    bookTableController.onInit();
    bookTableController.getTimeSlot(
        _selectedDate.toString(), guestNo.toInt(), widget.restaurantId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return GetBuilder<BookTableController>(
        init: BookTableController(),
        builder: (bookTable) => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                floatingActionButton: bookTable.name == null
                    ? Container()
                    : FloatingActionButton.extended(
                        backgroundColor: ThemeColors.baseThemeColor,
                        onPressed: () {
                          timeSlotListIndex == 0
                              ? Fluttertoast.showToast(
                                  msg: 'CHOOSE_A_VALID_TIMESLOT'.tr,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                )
                              : bookTable.tabelBook(
                                  _selectedDate.toString(),
                                  timeSlotID,
                                  guestNo.toInt(),
                                  widget.restaurantId);
                        },
                        icon: Icon(
                          Icons.library_books_outlined,
                          color: Colors.white,
                        ),
                        label: Text("BOOK_NOW".tr),
                      ),
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0.0,
                  backgroundColor: ThemeColors.baseThemeColor,
                  title: Text(
                    "BOOK_TABLE".tr,
                    style: TextStyle(
                        fontSize: FontSize.xLarge, fontWeight: FontWeight.bold),
                  ),
                ),
                body: Material(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 10.0, 15.0, 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: mainWidth / 3.5,
                                      height: mainHeight / 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2.0),
                                            topRight: Radius.circular(2.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/table2.png"),
                                          fit: BoxFit.fill,
                                          //alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: mainWidth / 3.5,
                                      height: mainHeight / 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2.0),
                                            topRight: Radius.circular(2.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/table1.png"),
                                          fit: BoxFit.fill,
                                          //alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: mainWidth / 3.5,
                                      height: mainHeight / 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(2.0),
                                            topRight: Radius.circular(2.0)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/table3.png"),
                                          fit: BoxFit.fill,
                                          //alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 20, bottom: 5, left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "NO_OF_PERSONS".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                              sliderRange(),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PICK_A_DATE".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () => FocusManager
                                          .instance.primaryFocus
                                          ?.unfocus(),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios_sharp,
                                            size: 13,
                                            color: Colors.blueGrey,
                                          ),
                                          Text(
                                            currentMonth!.toString(),
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blueGrey,
                                              fontFamily: 'AirbnbCerealBold',
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            size: 13,
                                            color: Colors.blueGrey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              datePicker(),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "PICK_A_TIME".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_sharp,
                                          size: 13,
                                          color: Colors.blueGrey,
                                        ),
                                        Text(
                                          currentMonth!.toString(),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blueGrey,
                                            fontFamily: 'AirbnbCerealBold',
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          size: 13,
                                          color: Colors.blueGrey,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              bookTable.dataLoader
                                  ? Loader()
                                  : bookTable.timeSlotList.isEmpty
                                      ? Container()
                                      : Container(
                                          height: 55,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3)),
                                            color: Color(0xFFF2F2F2),
                                          ),
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButtonHideUnderline(
                                              child:
                                                  DropdownButton<TimeSlotList>(
                                                value: timeSlotListIndex == null
                                                    ? null
                                                    : bookTable.timeSlotList[
                                                        timeSlotListIndex!],
                                                isExpanded: true,
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                iconEnabledColor:
                                                    ThemeColors.baseThemeColor,
                                                items: bookTable.timeSlotList
                                                    .map((TimeSlotList value) {
                                                  return new DropdownMenuItem<
                                                      TimeSlotList>(
                                                    value: value,
                                                    child: Text(
                                                      value.startTime
                                                              .toString() +
                                                          ' - ' +
                                                          value.endTime
                                                              .toString(),
                                                      style: TextStyle(
                                                        color: ThemeColors
                                                            .baseThemeColor,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    timeSlotListIndex =
                                                        bookTable.timeSlotList
                                                            .indexOf(newValue!);
                                                    timeSlotID =
                                                        newValue.id.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                              bookTable.profileLoader == true
                                  ? Container()
                                  : informationField(bookTable),
                            ],
                          ),
                        ),
                      ),
                      bookTable.commonLoader
                          ? Positioned(
                              child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white60,
                                  child: Center(child: Loader())),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ));
  }

  sliderRange() {
    return SfSliderTheme(
      data: SfSliderThemeData(
        thumbRadius: 10,
      ),
      child: SfSlider(
        min: 1.0,
        max: 10.0,
        stepSize: 1,
        activeColor: Colors.red,
        interval: 1,
        showDividers: true,
        showTicks: true,
        showLabels: true,
        value: guestNo,
        onChanged: (dynamic newValue) {
          setState(() {
            FocusManager.instance.primaryFocus?.unfocus();
            guestNo = newValue;
            bookTableController.getTimeSlot(
                _selectedDate.toString(), guestNo.toInt(), widget.restaurantId);
          });
        },
      ),
    );
  }

  datePicker() {
    return Container(
      padding: EdgeInsets.all(20.0),
      //   color: light_orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: DatePicker(
              DateTime.now(),
              width: mainWidth / 5.58,
              height: mainHeight / 9,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              selectionColor: ThemeColors.baseThemeColor,
              selectedTextColor: Colors.white,
              inactiveDates: [
                DateTime.now().add(Duration(days: 3)),
                //  DateTime.now().add(Duration(days: 4)),
                DateTime.now().add(Duration(days: 7))
              ],
              onDateChange: (date) {
                // New date selected
                setState(() {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _selectedDate = date;
                  bookTableController.getTimeSlot(_selectedDate.toString(),
                      guestNo.toInt(), widget.restaurantId);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  informationField(bookTable) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "YOUR_INFORMATION".tr,
              style: TextStyle(
                fontSize: FontSize.xLarge,
                fontWeight: FontWeight.bold,
                fontFamily: 'AirbnbCerealBold',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: bookTable.nameController
                  ..text = bookTable.name!
                  ..selection = TextSelection.collapsed(
                      offset: bookTable.nameController.text.length),
                //style: textStyle,
                onChanged: (value) {
                  bookTable.name = value;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle,
                      color: ThemeColors.baseThemeColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ThemeColors.baseThemeColor, width: 0.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  hintText: 'ENTER_YOUR_NAME'.tr,
                  hintStyle:
                      TextStyle(color: Colors.grey, fontSize: FontSize.medium),
                  labelText: 'NAME'.tr,
                  labelStyle:
                      TextStyle(color: Colors.grey, fontSize: FontSize.medium),
                  // labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            //Name textfield

            //Email textfield
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: bookTable.emailController
                  ..text = bookTable.email!
                  ..selection = TextSelection.collapsed(
                      offset: bookTable
                          .emailController.text.length), //style: textStyle,
                onChanged: (value) {
                  bookTable.email = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined,
                        color: ThemeColors.baseThemeColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ThemeColors.baseThemeColor, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    hintText: 'ENTER_YOUR_EMAIL'.tr,
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: FontSize.medium),
                    labelText: 'EMAIL'.tr,
                    labelStyle: TextStyle(
                        color: Colors.grey, fontSize: FontSize.medium),
                    // labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
              ),
            ),

            //Phone textfield
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: bookTable.phoneController
                  ..text = bookTable.phone!
                  ..selection = TextSelection.collapsed(
                      offset: bookTable
                          .phoneController.text.length), //style: textStyle,
                onChanged: (value) {
                  bookTable.phone = value;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: ThemeColors.baseThemeColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ThemeColors.baseThemeColor, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    hintText: 'ENTER_YOUR_PHONE_NUMBER'.tr,
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: FontSize.medium),
                    labelText: 'PHONE'.tr,
                    labelStyle: TextStyle(
                        color: Colors.grey, fontSize: FontSize.medium),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
