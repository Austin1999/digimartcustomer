import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/screens/payment.dart/widgets/details.dart';
import 'package:digimartcustomer/utils/helper/showLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../drawer.dart';

class ListUploadPage extends StatefulWidget {
  @override
  _ListUploadPageState createState() => _ListUploadPageState();
}

class _ListUploadPageState extends State<ListUploadPage> {
  TextEditingController phone =
      TextEditingController(text: userController.userModel.value.phone);
  TextEditingController address =
      TextEditingController(text: userController.userModel.value.address);
  TextEditingController name =
      TextEditingController(text: userController.userModel.value.name);
  TextEditingController pincode =
      TextEditingController(text: userController.userModel.value.pincode);
  File _image;
  final picker = ImagePicker();
  final _firebaseStorage = FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Get.off(() => ShoppingCartWidget())),
                new Obx(
                  () => Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: new CircleAvatar(
                      radius: 6.5,
                      backgroundColor: Colors.red,
                      child: Text(
                        userController.userModel.value.cart?.length.toString(),
                        style: TextStyle(color: textwhite, fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            'Upload Product List',
            style: TextStyle(color: kprimarycolor),
          ),
        ),
        drawer: SideDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null ? Text('No image selected.') : Image.file(_image),
              _image == null
                  ? ElevatedButton.icon(
                      onPressed: getImage,
                      icon: Icon(Icons.upload_file),
                      label: Text('Upload File'),
                    )
                  : ElevatedButton.icon(
                      onPressed: () async {
                        var snapshot = await _firebaseStorage
                            .ref()
                            .child(
                                'listuploads/${userController.firebaseUser.value.uid}${DateTime.now()}')
                            .putFile(_image);
                        var downloadUrl = await snapshot.ref.getDownloadURL();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Confirm Address',
                                    style: TextStyle(
                                        color: kprimarycolor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ProfileDetails(
                                      name: name,
                                      phone: phone,
                                      address: address,
                                      pincode: pincode),
                                  Row(
                                    children: [
                                      FlatButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Cancel',
                                          style:
                                              TextStyle(color: kprimarycolor),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          showLoading();
                                          try {
                                            firebaseFirestore
                                                .collection('users')
                                                .doc(userController
                                                    .firebaseUser.value.uid)
                                                .update({
                                              'listorders':
                                                  FieldValue.arrayUnion(
                                                      ['$downloadUrl'])
                                            }).whenComplete(() {
                                              firebaseFirestore
                                                  .collection('listorders')
                                                  .add({
                                                'photo_url': '$downloadUrl'
                                              }).whenComplete(() {
                                                dismissLoadingWidget();
                                                Get.defaultDialog(
                                                    barrierDismissible: false,
                                                    onConfirm: () => Get.off(
                                                        () => NavigationPage()),
                                                    title: 'Congratulations',
                                                    middleText:
                                                        'Order Successfully Placed',
                                                    textConfirm: 'Okay',
                                                    confirmTextColor:
                                                        textwhite);
                                              });
                                            });
                                          } catch (e) {
                                            Get.snackbar("Error",
                                                "Cannot Place this item");
                                            debugPrint(e.toString());
                                          }
                                        },
                                        child: Text(
                                          'Confirm Order',
                                          style:
                                              TextStyle(color: kprimarycolor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.send_outlined),
                      label: Text('Send Order'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
