import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_task/utils/validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubits/login_cubit/auth_cubit.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passworController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 30), child: formFields()),
    );
  }

  Widget formFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Chemist Login",
              style: TextStyle(fontSize: 30),
            ),
          ),
          mobileField(),
          passwordField(),
          submitButton(),
          //forgot password
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF316996),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //mobile number textfield
  Widget mobileField() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: TextFormField(
        maxLength: 10,
        validator: Validator.phoneNumber,
        keyboardType: TextInputType.number,
        controller: _phoneController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          labelText: "Mobile",
          enabledBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

  //password textfield

  Widget passwordField() {
    return TextFormField(
      controller: _passworController,
      validator: Validator.password,
      obscureText: _passwordVisible ? false : true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: "Password",
        enabledBorder: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            _passwordVisible = _passwordVisible ? false : true;
            setState(() {});
          },
          icon: _passwordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
        ),
      ),
    );
  }

  //submit button
  Widget submitButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthLoginSuccess) {
          Fluttertoast.showToast(msg: "LoggedIn Successfully");
        } else if (state is AuthErrorState) {
          Fluttertoast.showToast(msg: state.errorMessage ?? "Not given Error From Backend");
        }
        return GestureDetector(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<AuthCubit>(context).login(_phoneController.text, _passworController.text);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            color: Colors.blue[900],
            width: double.infinity,
            height: 45,
            child: const Center(
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
