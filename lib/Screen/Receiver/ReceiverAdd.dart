import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReceiverAdd extends StatefulWidget {
  const ReceiverAdd({super.key});

  @override
  State<ReceiverAdd> createState() => _ReceiverAddState();
}

class _ReceiverAddState extends State<ReceiverAdd> {
  final _formKey = GlobalKey<FormState>();
  int? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reception de colis'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Le code utilisé lors de l\'échange de colis est . le même code doit être utilisé pour lors de la reception',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20),
              Text(
                'Veuillez saisir le code ci-dessous :',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Code de transfert',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le code';
                  }
                  return null;
                },
                onSaved: (value) {
                  code = int.parse(value!);
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // if (_validationCode == widget.code) {
                        //   showNotificationSuccess(
                        //       context, 'Le code de validation est correct.');

                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => ImageCamFile(
                        //                 user: widget.user,
                        //               )));
                        // } else {
                        //   showNotificationError(
                        //       context, 'Le code de validation est incorrect.');
                        // }
                      }
                    },
                    child: Text('Valider'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
