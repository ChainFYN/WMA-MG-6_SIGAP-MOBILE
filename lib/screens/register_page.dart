import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/section_title.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/step_progress.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final emailController = TextEditingController();
  final noHpController = TextEditingController();
  final passwordController = TextEditingController();
  final alamatController = TextEditingController();

  String? selectedProvinsi = 'Jawa Timur';
  String? selectedKota = 'Jember';

  bool obscurePassword = true;

  @override
  void dispose() {
    namaController.dispose();
    nikController.dispose();
    emailController.dispose();
    noHpController.dispose();
    passwordController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran berhasil! Silakan login.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'SIGAP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pendaftaran Akun Warga',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Buat akun SIGAP untuk mengakses layanan warga.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),

                // PROGRESS STEP
                const StepProgress(currentStep: 1),

                const SizedBox(height: 28),

                // SECTION: DATA AKUN
                const SectionTitle(
                  icon: Icons.person_outline,
                  title: 'Data Akun',
                ),
                const SizedBox(height: 12),

                CustomInput(
                  controller: namaController,
                  label: 'Nama Lengkap',
                  hint: 'Masukkan nama lengkap',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 14),

                CustomInput(
                  controller: nikController,
                  label: 'NIK',
                  hint: 'Masukkan NIK',
                  icon: Icons.badge_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),

                CustomInput(
                  controller: emailController,
                  label: 'Email',
                  hint: 'contoh@email.com',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),

                CustomInput(
                  controller: noHpController,
                  label: 'Nomor HP',
                  hint: '08xxxxxxxxxx',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Minimal 8 karakter',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password minimal 8 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // SECTION: DATA DOMISILI
                const SectionTitle(
                  icon: Icons.location_on_outlined,
                  title: 'Data Domisili',
                ),
                const SizedBox(height: 12),

                CustomInput(
                  controller: alamatController,
                  label: 'Alamat',
                  hint: 'Masukkan alamat lengkap',
                  icon: Icons.home_outlined,
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        title: 'Provinsi',
                        items: const ['Jawa Timur', 'Jawa Tengah', 'Jawa Barat'],
                        value: selectedProvinsi,
                        onChanged: (val) {
                          setState(() {
                            selectedProvinsi = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDropdown(
                        title: 'Kabupaten/Kota',
                        items: const ['Jember', 'Banyuwangi', 'Lumajang'],
                        value: selectedKota,
                        onChanged: (val) {
                          setState(() {
                            selectedKota = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // SECTION: KEAMANAN
                const SectionTitle(
                  icon: Icons.security_outlined,
                  title: 'Keamanan',
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Pastikan data yang kamu masukkan sudah benar. '
                          'Data akan digunakan untuk proses verifikasi akun.',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E88E5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Daftar Akun',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sudah punya akun? Sign In',
                      style: TextStyle(
                        color: Color(0xFF1E88E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
