import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  myhome(),
    );
  }
}
 
class myhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas UTS'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyForm();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.assignment,
                size: 100,
                color: Colors.blue,
              ),
            ),
            Text('Buatlah Program form pada FLutter')
          ],
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  String selectedFile = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Future<void> _uploadFile() async {
    FilePickerResult? result= await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      selectedFile =result.files.first.name;
      setState(() {});
    }
  }

  void _resetForm(){
    nameController.clear();
    nimController.clear();
    classController.clear();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Tugas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Nama harus diisi';
                }
                return null;
              },
              ),

              TextFormField(
              controller: nimController,
              decoration: InputDecoration(labelText: 'NIM'),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'NIM harus diisi';
                }else if (!RegExp(r'^[0-9]+$').hasMatch(value)){
                  return 'NIM harus berisi angka';
                }
                return null;
              },
              ),

              TextFormField(
              controller: classController,
              decoration: InputDecoration(labelText: 'Kelas'),
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Kelas harus diisi';
                }
                return null;
              },
              ),
              SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Text('Pilih File: $selectedFile'),
                  ElevatedButton(
                    onPressed: () {
                      _uploadFile();   
                    },
                    child: Text('Unggah File'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()){
                    String name = nameController.text;
                    String nim = nimController.text;
                    String kelas = classController.text;
                    
                    _resetForm();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context){
                        return TaskCofirmationPage(
                          name: name,
                          nim: nim,
                          kelas: kelas,
                          selectedFile: selectedFile,
                        );
                        },
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCofirmationPage extends StatelessWidget {
  final String name;
  final String nim;
  final String kelas;
  final String selectedFile;

  TaskCofirmationPage({
    required this.name,
    required this.nim,
    required this.kelas,
    required this.selectedFile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konfirmasi Tugas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tugas Anda Telah Dikumpulkan!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nama: $name', style: TextStyle(fontSize: 18)),
                  Text('NIM: $nim', style: TextStyle(fontSize: 18)),
                  Text('Kelas: $kelas', style: TextStyle(fontSize: 18)),
                  Text('File: $selectedFile', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  } 
}