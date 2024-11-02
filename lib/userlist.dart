import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/firebase_service.dart';
import 'package:crud_firebase/userdata.dart';
import 'package:crud_firebase/useritem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  FirebaseService firebaseService = new FirebaseService();

  TextEditingController nama = TextEditingController();
  TextEditingController umur = TextEditingController();
  TextEditingController email = TextEditingController();

  // Tambahan untuk dropdown semester
  String selectedSemester = 'Ganjil';
  List<String> semesterOptions = ['Ganjil', 'Genap'];

  // Tambahan untuk radio button gender
  String selectedGender = 'Laki-laki';

  Color btnSimpanColorDefault = Colors.green;
  Color btnSimpanColor = Colors.green;
  Color btnUbahColor = Colors.orange;
  String btnSimpanTextDefault = "Simpan";
  String btnSimpanText = "Simpan";
  String btnUbahText = "Ubah";

  bool isReadOnly = false;

  int selectedDaftarUserIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.purple[50],
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              "CRUD Firebase App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.purple[50]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: nama,
                          readOnly: isReadOnly,
                          decoration: InputDecoration(
                            labelText: "Nama",
                            labelStyle: TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 2),
                            ),
                            prefixIcon:
                                Icon(Icons.person, color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: umur,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Umur",
                            labelStyle: TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 2),
                            ),
                            prefixIcon: Icon(Icons.calendar_today,
                                color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.purple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 2),
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.purple),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        // Dropdown Semester
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedSemester,
                              isExpanded: true,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.purple),
                              items: semesterOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSemester = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Radio Button Gender
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender:',
                                  style: TextStyle(color: Colors.purple)),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Laki-laki',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value!;
                                      });
                                    },
                                    activeColor: Colors.purple,
                                  ),
                                  Text('Laki-laki'),
                                  SizedBox(width: 20),
                                  Radio<String>(
                                    value: 'Perempuan',
                                    groupValue: selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedGender = value!;
                                      });
                                    },
                                    activeColor: Colors.purple,
                                  ),
                                  Text('Perempuan'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.save),
                              label: Text(btnSimpanText,
                                  style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: btnSimpanColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              onPressed: () {
                                try {
                                  if (nama.text.isEmpty ||
                                      umur.text.isEmpty ||
                                      email.text.isEmpty ||
                                      selectedSemester.isEmpty ||
                                      selectedGender.isEmpty)
                                    throw ("Data tidak boleh kosong");
                                  if (btnSimpanText == btnSimpanTextDefault) {
                                    UserData userData = new UserData(
                                        nama.text,
                                        int.parse(umur.text),
                                        email.text,
                                        selectedSemester,
                                        selectedGender);
                                    firebaseService.tambah(userData);
                                  } else {
                                    UserData userData = new UserData(
                                        nama.text,
                                        int.parse(umur.text),
                                        email.text,
                                        selectedSemester,
                                        selectedGender);
                                    firebaseService.ubah(userData);
                                    btnSimpanColor = btnSimpanColorDefault;
                                    btnSimpanText = btnSimpanTextDefault;
                                    setState(() {
                                      btnSimpanColor;
                                      btnSimpanText;
                                    });
                                  }

                                  setState(() {
                                    isReadOnly = false;
                                  });

                                  nama.text = "";
                                  umur.text = "";
                                  email.text = "";
                                } catch (e) {
                                  Fluttertoast.showToast(msg: '$e');
                                }
                              },
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.clear),
                              label:
                                  Text("Clear", style: TextStyle(fontSize: 16)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                              onPressed: () {
                                nama.text = "";
                                umur.text = "";
                                email.text = "";
                                btnSimpanColor = btnSimpanColorDefault;
                                btnSimpanText = btnSimpanTextDefault;
                                isReadOnly = false;
                                setState(() {
                                  btnSimpanColor;
                                  btnSimpanText;
                                  isReadOnly;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(height: 32, thickness: 2, color: Colors.purple[200]),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: firebaseService.ambilData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.purple),
                          ));
                        }
                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];
                            UserData userData = new UserData(
                                documentSnapshot["nama"],
                                documentSnapshot["umur"],
                                documentSnapshot["email"],
                                documentSnapshot["semester"],
                                documentSnapshot["gender"]);
                            return Dismissible(
                              key: ValueKey(userData),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.purple[50]!
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    title: Text(userData.nama),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Umur: ${userData.umur}'),
                                        Text('Email: ${userData.email}'),
                                        Text('Semester: ${userData.semester}'),
                                        Text('Gender: ${userData.gender}'),
                                      ],
                                    ),
                                    onTap: () {
                                      nama.text = userData.nama;
                                      umur.text = userData.umur.toString();
                                      email.text = userData.email;
                                      selectedSemester = userData.semester;
                                      selectedGender = userData.gender;
                                      btnSimpanColor = btnUbahColor;
                                      btnSimpanText = btnUbahText;
                                      isReadOnly = true;
                                      setState(() {
                                        btnSimpanColor;
                                        btnSimpanText;
                                        isReadOnly;
                                        selectedSemester;
                                        selectedGender;
                                      });
                                      selectedDaftarUserIndex = index;
                                    },
                                  ),
                                ),
                              ),
                              background: Container(
                                padding: EdgeInsets.only(left: 25),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.delete,
                                      color: Colors.white, size: 30),
                                ),
                              ),
                              secondaryBackground: Container(
                                color: Colors.white,
                              ),
                              dismissThresholds: {
                                DismissDirection.startToEnd: 0.2
                              },
                              onDismissed: (direction) {
                                firebaseService.hapus(userData);
                              },
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        title: Text("Konfirmasi",
                                            style: TextStyle(
                                                color: Colors.purple)),
                                        content: Text(
                                            "Apakah Anda yakin ingin menghapus data ini?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: Text("BATAL",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text("HAPUS"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                return false;
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                          itemCount: snapshot.data!.docs.length,
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
