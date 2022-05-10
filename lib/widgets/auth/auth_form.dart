import 'package:flutter/material.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/10/2022
 * Time: 1:00 PM
 */
class AuthForm extends StatefulWidget {
  final void Function(
      String email, String password, String username, bool isLogin) submitFn;
  final bool isLoading;

  const AuthForm({
    Key? key,
    required this.submitFn,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _user = '';
  String _password = '';
  bool _isLogin = true;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_email, _password, _user, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
              ),
              FlatButton(onPressed: () {}, child: Icon(Icons.image)),
              TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email address')),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter at least 4 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user = value!;
                },
                decoration: InputDecoration(labelText: 'User Name'),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 7) {
                    return 'Password must be at least 7 characters long.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              if (!_isLogin)
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Confirm password'),
                ),
              SizedBox(
                height: 12,
              ),
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                ElevatedButton(
                  onPressed: _submit,
                  child: _isLogin ? Text('Login') : Text('Create'),
                ),
              if (!widget.isLoading)
                TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child:
                        _isLogin ? Text('Create an account') : Text('Sign In'))
            ],
          ),
        ),
      ),
    );
  }
}
