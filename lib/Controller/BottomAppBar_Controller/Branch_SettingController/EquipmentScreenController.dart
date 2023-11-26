import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:async/src/delegate/stream.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../Utils/constant.dart';
import '../../../Utils/pref_manager.dart';
import '../../../api/request.dart';
import '../../../api/url.dart';
import '../../../model/Equipment_model.dart';
import '../../../model/Truck_model.dart';

class EquipmentScreenController extends GetxController {
  var inspectionItems = <Datum>[].obs;
  var inspectionList = <EquipmentInspectionModel>[].obs;
  var selectedTruck = "".obs;
  var truckId = "".obs;
  //var truckList = ['Select Truck', 'Truck 1', 'Truck 2'].obs;
  var truckList = <TruckList>[].obs;
  TextEditingController odometerText = TextEditingController();
  TextEditingController notesText = TextEditingController();
  // Define a RxString to hold the selected status (Pass, Fail, N/A)
  RxString selectedStatus = ''.obs;
  var pdf = pw.Document();
  File? generatedPdf;

  @override
  void onInit() {
    super.onInit();
    parseJson();
    getTruckList();
  }

  // Setter method to update the selected status
  void setSelectedStatus(String status) {
    selectedStatus.value = status;
  }

  void getTruckList() {
    truckList.clear();
    RequestHttp request = RequestHttp(url: urlTruckList, token: Prefs.getString(TOKEN));
    request.get().then((response) async {
      if (response.statusCode == 200) {
        // Parse the response and update the employees list
        TruckListModel truckListModel = truckListModelFromJson(response.body);
        truckList.assignAll(truckListModel.truckList); // Assign employees list
        selectedTruck.value = truckList[0].name;
        truckId.value = truckList[0].id.toString();
        Fluttertoast.showToast(msg: "UserList fetch successfully");
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      // Get.snackbar("Error", onError.toString(),
      //     colorText: Colors.white,
      //     backgroundColor: Colors.red,
      //     snackPosition: SnackPosition.TOP);
      Fluttertoast.showToast(msg: 'Truck Not Available');
    });
  }

  void printList() {
    for (var data in inspectionList) {
      if (kDebugMode) {
        print(data.truck);
      }
      for (var item in data.data) {
        if (kDebugMode) {
          print(item.title);
        }
        for (var list in item.inspectionItems) {
          if (kDebugMode) {
            print(list.name);
          }
        }
      }
    }
    generatePdf();
  }


  // Function to capture image from camera
  Future<void> captureImage(int mainIndex, int index) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Convert the image file to Uint8List
      Uint8List imageBytes = await pickedFile.readAsBytes();

      // Update the InspectionItem's images list
      var item = inspectionList[0].data[mainIndex].inspectionItems[index];
      item.images!.add(imageBytes);
      // Update the UI using GetX update() function
      update();
    }
  }

  // Update the status of InspectionItem at the given index
  void updateInspectionStatus(int mainIndex, int index, String status) {
    if (inspectionList.isNotEmpty &&
        mainIndex >= 0 &&
        mainIndex < inspectionList[0].data.length &&
        inspectionList[0].data[mainIndex].inspectionItems.isNotEmpty) {
      var item = inspectionList[0].data[mainIndex].inspectionItems[index];
      switch (status) {
        case 'Pass':
          item.pass!.value = true;
          item.fail!.value = false;
          item.nA!.value = false;
          break;
        case 'Fail':
          item.pass!.value = false;
          item.fail!.value = true;
          item.nA!.value = false;
          break;
        case 'N/A':
          item.pass!.value = false;
          item.fail!.value = false;
          item.nA!.value = true;
          break;
      }
    }
  }

  void updateNotes(int mainIndex, int index,String notes){
    var item = inspectionList[0].data[mainIndex].inspectionItems[index];
    item.notes = notes;

  }

  void parseJson() {
    String jsonData = '''
     {
    "data": [
        {
            "title": "Underhood/Engine Compartment",
            "values": [
                "Engine Oil Level",
                "Radiator Fluid Level",
                "Battery Fluid Level",
                "Windshield Washer Fluid Level",
                "Engine Hoses/Belts",
                "Terminals"
            ]
        },
        {
            "title": "Interior/Cab",
            "values": [
                "Brakes",
                "Steering",
                "Transmission",
                "Mirrors",
                "Gauge/Instruments",
                "Controls (Equipment)",
                "Radio (Two-Way)",
                "Damage/Cleanliness"
            ]
        },
        {
            "title": "Exterior",
            "values": [
                "Tires",
                "Turn Signal",
                "Headlights",
                "Tail/Brakes Lights",
                "Windshield Wipers",
                "Fresh Body Damage",
                "Cleanliness"
            ]
        },
        {
            "title": "Lift/Boom Equipment",
            "values": [
                "Hoist",
                "Winch",
                "Chains",
                "Lift Cables",
                "Cycle Lift",
                "Tire Blocks",
                "Snatch Blocks"
            ]
        },
        {
            "title": "Safety Equipment",
            "values": [
                "Fire Extinguisher",
                "Web Cutter",
                "Triangles",
                "First Aid Kit",
                "Back-Up Alarm",
                "Rear Door Buzzer (LTV only)",
                "Biohazard Kit"
            ]
        },
        {
            "title": "Other",
            "values": [
                "Registration/Insurance",
                "Driver's License"
            ]
        }
    ]
}
    ''';

    var data = json.decode(jsonData);

    InspectionModel iLisData = InspectionModel.fromJson(data);
    for (var list in iLisData.data) {
      inspectionItems.add(list);
    }
    var inspectionModel = EquipmentInspectionModel(
      data: [],
      truck: "", // Provide actual truck details
      odometer: "", // Provide actual odometer reading
      notes: "", // Provide any additional notes
    );
    for (var element in inspectionItems.value) {
      var list = EIMList(title: element.title, inspectionItems: []);
      for (var value in element.values) {
        var inspectionList = InspectionItem(
          name: value,
          notes: "",
          images: [],
          pass: true,
          fail: false,
          nA: false,
        );
        list.inspectionItems.add(inspectionList);
      }
      inspectionModel.data.add(list);
    }
    inspectionList.add(inspectionModel);
  }

  void generatePdf() async {
    pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) {
          return pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(selectedTruck.value),
                  pw.SizedBox(height: 20),
                  pw.Text(odometerText.text),
                ]),
            pw.SizedBox(height: 20),
            pw.Container(
                height: 30,
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.rectangle,
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 2.0,
                  ),
                ),
                child: pw.Center(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                      pw.SizedBox(width: 5),
                      pw.Text('Pass',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      pw.Container(
                        width:
                            15, // Set the width and height to create a circular shape
                        height: 15,
                        decoration: const pw.BoxDecoration(
                            shape: pw.BoxShape.circle, color: PdfColors.green),
                      ),
                      pw.SizedBox(width: 5),
                      pw.Text('Fail',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      pw.Container(
                        width:
                            15, // Set the width and height to create a circular shape
                        height: 15,
                        decoration: const pw.BoxDecoration(
                            shape: pw.BoxShape.circle, color: PdfColors.yellow),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text('NA',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 7)),
                      pw.Container(
                        width:
                            15, // Set the width and height to create a circular shape
                        height: 15,
                        decoration: const pw.BoxDecoration(
                            shape: pw.BoxShape.circle, color: PdfColors.grey),
                      ),
                      pw.SizedBox(width: 5),
                    ]))),
          ]);
        },
        build: (context) {
          return [
            pw.SizedBox(height: 20),
            for (var data in inspectionList[0].data)
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      height: 35,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.rectangle,
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 2.0,
                        ),
                      ),
                      child: pw.Row(children: [
                        pw.SizedBox(width: 10),
                        pw.Container(
                            width: 100,
                            child: pw.Text(data.title,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 12))),
                        pw.SizedBox(width: 35),
                        pw.Container(
                            width: 30,
                            child: pw.Text('State',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 12))),
                        pw.SizedBox(width: 40),
                        pw.Container(
                            width: 210,
                            child: pw.Row(children: [
                              pw.Text('Notes',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10)),
                            ])),
                      ]),
                    ),
                    for (var item in data.inspectionItems)
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(10),
                        child: pw.Container(
                            height: 30,
                            width: double.infinity,
                            child: pw.Row(children: [
                              pw.Container(
                                  width: 100,
                                  child: pw.Text(item.name!,
                                      style: const pw.TextStyle(fontSize: 8))),
                              pw.SizedBox(width: 40),
                              pw.Container(
                                  width:
                                      20, // Set the width and height to create a circular shape
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    color: item.pass!.value
                                        ? PdfColors.green
                                        : (item.fail!.value
                                            ? PdfColors.red
                                            : (item.nA!.value
                                                ? PdfColors.grey
                                                : PdfColors.grey)),
                                  )),
                              pw.SizedBox(width: 50),
                              item.notes == null
                                  ? pw.SizedBox(width: 200)
                                  : pw.SizedBox(
                                      width: 160,
                                      child: pw.Text('${item.notes}',
                                          style: const pw.TextStyle(
                                              fontSize: 10))),
                              pw.SizedBox(width: 45),
                            ])),
                      ),
                    pw.SizedBox(height: 10)
                  ]),
            for (var data in inspectionList[0].data)
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    for (var item in data.inspectionItems)
                      if (item.images != null && item.images!.isNotEmpty)
                        for (var image in item.images!)
                          pw.Column(
                            children: [
                              pw.SizedBox(height: 10),
                              pw.Text(item.name ?? ''),
                              pw.SizedBox(height: 10),
                              pw.Container(
                                  height: 100,
                                  width: 150,
                                  child: pw.Image(pw.MemoryImage(image.buffer.asUint8List()))
                              )
                            ]
                          )
                      else
                        pw.SizedBox()
                  ])
          ];
        }));
    final tempDir = await getTemporaryDirectory();
    generatedPdf = File('${tempDir.path}/InspectionReport${DateTime.now()}.pdf');
    await generatedPdf?.writeAsBytes(await pdf.save());
    if(generatedPdf == null){
      debugPrint('pdf not generated');
    }else{
      onSubmit();
    }
    // await OpenFile.open(generatedPdf?.path);
  }

  void onSubmit() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer ${Prefs.getString(TOKEN)}"
    };
    var uri = Uri.parse(urlAddInspection);
    var request = http.MultipartRequest("POST", uri);
    if(generatedPdf == null){

    }else{
      // Add PDF file to the request
      //var pdfFile = File('${tempDir.path}/InspectionReport${DateTime.now()}.pdf');
      var pdfStream = http.ByteStream(DelegatingStream.typed(generatedPdf!.openRead()));
      var length = await generatedPdf!.length();
      var pdfMultipartFile = http.MultipartFile('inspection_file', pdfStream, length,
          filename: generatedPdf!.path);
      request.files.add(pdfMultipartFile);
    }
    request.headers.addAll(headers);
    request.fields['truck_id'] = truckId.value;
    request.fields['odometer'] = odometerText.text;
    request.fields['notes'] = notesText.text;
    if (kDebugMode) {
      print('REQUEST  : - ${request.fields}  ${request.files}');
    }

// send
    var response = await request.send();
    if (kDebugMode) {
      print(response.statusCode);
    }
    response.stream.transform(utf8.decoder).listen((value) async {
      //Get.back();
      try {
        if (kDebugMode) {
          print(value);
        }
        if (response.statusCode == 200) {
          Fluttertoast.showToast(msg: "Inspection Created Successfully");
          Get.offAllNamed(ROUTE_HOME);
        }else{
          Get.snackbar("Error", response.statusCode.toString(),
              colorText: Colors.white,
              backgroundColor: Colors.blue,
              snackPosition: SnackPosition.TOP);
        }
        //isLoading.value = false;
      } catch (e) {
        print(e.toString());
      }
      // Get.back();
      update();
    });
  }
}
