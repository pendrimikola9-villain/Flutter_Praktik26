import 'package:flutter/material.dart';
import 'register_screen.dart';

// StatefulWidget digunakan karena halaman ini punya state yang bisa berubah
// contoh: nilai input email & password bisa berubah
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Controller digunakan untuk mengambil nilai yang diketik user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Kunci unik untuk form, digunakan saat validasi
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Fungsi yang dipanggil saat tombol Login ditekan
  void _login() {
    // Cek apakah semua isian form valid
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      // Ambil nilai email dan password yang diketik user
      String email = _emailController.text;
      String password = _passwordController.text;

      // Untuk sekarang, hanya tampilkan snackbar
      // Nantinya diganti dengan proses ke API/server
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login dengan email: $email')),
      );
    }
  }

  // Jangan lupa dispose controller saat widget sudah tidak dipakai
  // Ini penting agar tidak terjadi memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar adalah bar di bagian atas halaman
      appBar: AppBar(
        title: const Text('Login'),
      ),

      // Body adalah isi halaman
      body: Padding(
        // Padding memberi jarak di sisi kiri, kanan, atas, bawah
        padding: const EdgeInsets.all(16),

        // Form membungkus semua input agar bisa divalidasi bersama
        child: Form(
          key: _formKey, // hubungkan form dengan key

          child: Column(
            // Column menyusun widget secara vertikal (dari atas ke bawah)
            children: [

              // Input untuk Email
              TextFormField(
                controller: _emailController, // hubungkan dengan controller
                decoration: const InputDecoration(
                  labelText: 'Email',       // teks label di atas input
                  hintText: 'Masukkan email', // teks placeholder di dalam input
                  border: OutlineInputBorder(), // tampilan border kotak
                ),
                keyboardType: TextInputType.emailAddress, // keyboard tipe email
                validator: (value) {
                  // validator dipanggil saat form.validate()
                  // jika return null → valid
                  // jika return string → tidak valid, string itu jadi pesan error
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  return null; // valid
                },
              ),

              const SizedBox(height: 16), // jarak vertikal antar widget

              // Input untuk Password
              TextFormField(
                controller: _passwordController,
                obscureText: true, // true = karakter disembunyikan (untuk password)
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Tombol Login - lebar penuh
              SizedBox(
                width: double.infinity, // lebar mengikuti layar
                child: ElevatedButton(
                  onPressed: _login, // panggil fungsi _login saat ditekan
                  child: const Text('Login'),
                ),
              ),

              const SizedBox(height: 12),

              // Tombol pindah ke halaman Register
              TextButton(
                onPressed: () {
                  // Navigator.push = pindah ke halaman baru (ditumpuk)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text('Belum punya akun? Daftar di sini'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}