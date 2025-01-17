import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Word extends Translations {
  static const Locale localeID = Locale("id", "ID");
  static const Locale localeEN = Locale("en", "US");
  static const List<Locale> localeList = [localeEN, localeID];

  @override
  Map<String, Map<String, String>> get keys =>
      {'en_US': english, 'id_ID': indonesia};
}

Map<String, String> english = {
  'greenCampusApp': 'Green Campus App',
  'register': 'Register',
  'login': 'Login',
  'nipnim': 'NIP / NIM',
  'name': 'Name',
  'email': 'Email',
  'password': 'Password',
  'confirmPassword': 'Confirm Password',
  'forgetPassword': 'Forget Password',
  'goSignIn': 'Already have an account? Sign in',
  'goRegister': "Didn't have an account? Register",
  'continueWGoogle': 'Continue With Google',

  // HOME SCREEN
  'welcomeBack': 'Welcome Back',
  'greenPoints': 'Green Points',
  'gp': 'GP',
  'earnMoreGP': 'Earn More GP',
  'popularChallenge': 'Popular Challenges',
  'seeAll': 'See All',
  'redeem': 'Redeem Your Points',
  'sustainabilityMap': 'Sustainability Map',
  'facilityDetail': 'Facility Detail',
  'buildingLocation': 'Building Location',
  'description': 'Description',
  'recycleCenter': 'Recycle Center',
  'trashCan': 'Trash Can',
  'bikeRental': 'Bike Rental',
  'drinkingFountain': 'Drinking Fountain',
  'park': 'Park',
  'compostingCenter': 'Composting Center',
  "emptyNotification": "Your notification is empty",

  // Challenges
  'greenChallenges': 'Green Challenges',
  'challengeCompletion': 'Challenge Completion',
  'challengeDetail': 'Challenge Detail',
  'completed': 'Completed',
  'openChallenge': 'Open Challenges',
  'recentActivity': 'Recent Activities',
  'addActivity': 'Add new activity',
  'weeklyAchievement': 'Weekly Achievement',
  'earningGP': 'Earning GP',

  // Challenges Form
  'addChallenge': 'Add Challenge',
  'startChallenge': 'Start this Challenge',
  'title': 'Title',
  'reward': 'Reward',
  'status': 'Status',
  'aktif': 'Active',
  'nonaktif': 'Non Active',
  'startDate': 'Start Date',
  'endDate': 'End Date',
  'submit': 'Submit',

  // ACTIVITY
  'selectChallenge': 'Select Challenge',
  'unauthorizedUser': 'Unauthorized user, please re-login',
  'locationError': 'Location Service Error',
  'activityValidationError': 'Make sure all field are filled',
  'pleaseAddPhoto': 'Please add a photo of your activity!',
  'activityTime': 'Activity Time',
  'activityDetail': 'Activity Detail',
  'location': 'Location',
  'rewards': 'Rewards',
  'In Review': 'In Review',
  'Aprroved': 'Aprroved',
  'Rejected': 'Rejected',
  'changeStatusConfirmation':
      'Are you sure to change status of this activity to ',

  // PROFILE
  'profile': 'Profile',
  'faculty': 'Faculty',
  'language': 'Language',
  'english': 'English',
  'indonesian': 'Bahasa Indonesia',
  'theme': 'Theme Mode',
  'light': 'Ligth',
  'dark': 'Dark',
  'appVersion': 'App Version',
  'logout': 'Log Out',
  'confirmation': 'Are you sure?',
  'logoutConfirmation': 'Are you sure to log out from this app?',
  'cancel': 'Cancel',
  'adminDashboard': 'Admin Dashboard',
  'profilePictureChanged': 'Profile picture successfully changed!',

  // ADMIN DASHBOARD
  'rewardProducts': 'Reward Products',
  'greenFacilities': 'Green Facilities',
  'activities': 'Activities',
  'allActivities': 'All Activities',
  'filter': 'Filter',
  'bannerCarousel': 'Banner Carousel',

  // TRANSACTION
  'transactionGP': 'GP Transaction',
  'rewardsFrom': 'Rewards from Challenge @challenge',

  // Common
  'success': 'Success',
  'dataSaved': 'Data Saved Successfully',
  'statusChanged': 'Status Changed Successfully',

  // PRODUCTS
  'addProduct': 'Add Product',
  'editProduct': 'Edit Product',
  'detailProduct': 'Product Detail',
  'price': 'Price',
  'store': 'Store',
  'available': 'Available',
  'notAvailable': 'Not Available',
  'redeemInstruction': 'Redemption Instruction',
  'notEnoughGP': 'Not Enough GP',
  'notEnoughGPMessage':
      "You don't have enough Green Points for this product, let's increase your Green Points!",
  'redeemConfirmation': 'Are you sure to redeem this product?',
  'redeemConfirmMessage': 'You will spend your green point to get this product',
  'wait': 'Wait...',
  "error": 'Error',

  // REDEMPTION
  'redemption': 'Redemption',
  'redeemConfirmed': 'Redemption Confirmed',
  'redemptionInfo': 'Redemption Information',
  'dateCreated': 'Date Created',
  'invalid': 'Invalid',
  'valid': 'Valid',
  'dateRedeemed': 'Date Redeemed',
  'productInfo': 'Product Information',
  'failedLoadRedemption': 'Failed to load redemption info, please back.',

  // FACILITY
  'facilitiesForm': 'Facilities Form',
  'facilitiesDetail': 'Facilities Detail',
  'building': 'Building',
  'type': 'Type',
  'latitude': 'Latitude',
  'longitude': 'Longitude',
  'isNotValidNumber': 'Insert with valid number format',
  'susMap': 'Sustainability Map',
  'bikeStationQr': 'Bike Station QR Code',
  'pickLocation': 'Pick Location',
  'showQr': 'Show QR',

  // BIKE SHARING
  'bikeSharing': 'Bike Sharing',
  'bikeSharingQr': 'Bike Sharing QR Code',
  'saveToGallery': 'Save to Gallery',
  'saveQr': 'Save QR',
  'bikeStationLocation': 'Bike Station Location',
  'rentalHistory': 'Rental History',
  'rentABike': 'Rent a Bike',
  'activeRent': 'Active Rent',
  'start': 'Start',
  'finish': 'Finish',
  'bikeForm': 'Bike Form',
  'bikeStation': 'Bike Station',
  'rentalInstructions': 'Rental Instructions',
  'finishInstructions': 'Bike Return Instructions',
  'goToBikeStation': 'Go to Bike Station',
  'askStaffForBike': 'Ask staff for the bike',
  'scanBikeQR': 'Scan QR on the bike',
  'makeSureSuccessNotification':
      'Wait and make sure you have success notifivation',
  'enjoyBike': 'Enjoy Bike',
  'putBikeAtLocation': 'Put Bike at location',
  'scanStation': 'Scan Station QR',
  'youreDone': 'Your rent is done, thanks for using',
  'invalidQR': 'Invalid QR Code',
  'invalidQRMessageBike':
      "It's seem not a qr for bike sharing. Make sure you scan correct QR",
  'failedToLoadBike': 'Failed to load bike data',
  'bikeStatusUnavailable': 'Bike status is unavailable for use',
  'successFinishRent': 'Success Finish Rent',
  'successRentABike': 'Success Rent a Bike',
  'bikeAvailable': 'Bike Available',
  'rentVerificator': 'Rental Verificator',
  'verificationConfirmation': 'Confirm Verification',
  'verificationConfirmationMessage':
      'Are you sure to confirm this rent, and change status of the rent to done?',
  'successVerification': 'Success Verify Rent',
  'allRedemptions': 'All Redemptions',
  'scan': 'Scan',
  'confirmRedeem': 'Confirm Redemption',
  'confirmRedeemMessage': 'Are you sure to confirm this redemption?',
  'succeConfirmRedeem': 'Success confirm redemption',
  'verified': 'Verified',
  'unverified': 'Unverified',
};

Map<String, String> indonesia = {
  "greenCampusApp": "Green Campus App",
  "register": "Daftar",
  "login": "Masuk",
  "nipnim": "NIP / NIM",
  "name": "Nama",
  "email": "Email",
  "password": "Kata Sandi",
  "confirmPassword": "Konfirmasi Kata Sandi",
  "forgetPassword": "Lupa Kata Sandi",
  "goSignIn": "Sudah memiliki akun? Masuk",
  "goRegister": "Belum memiliki akun? Daftar",
  "continueWGoogle": "Lanjutkan Dengan Google",
  "welcomeBack": "Selamat Datang kembali",
  "greenPoints": "Green Points",
  "gp": "GP",
  "earnMoreGP": "Dapatkan Lebih Banyak GP",
  "popularChallenge": "Tantangan Populer",
  "seeAll": "Lihat Semua",
  "redeem": "Tukarkan Poin Anda",
  "emptyNotification": "Tidak ada notifikasi",
  "sustainabilityMap": "Peta Keberlanjutan",
  "facilityDetail": "Detail Fasilitas",
  "buildingLocation": "Lokasi Bangunan",
  "description": "Deskripsi",
  "recycleCenter": "Pusat Daur Ulang",
  "trashCan": "Tempat Sampah",
  "bikeRental": "Rental Sepeda",
  "drinkingFountain": "Keran Air Minum",
  "park": "Taman",
  "compostingCenter": "Pusat Pengomposan",
  "greenChallenges": "Green Challenges",
  "challengeCompletion": "Penyelesaian Tantangan",
  "challengeDetail": "Detail Tantangan",
  "completed": "Selesai",
  "openChallenge": "Buka Tantangan",
  "recentActivity": "Aktivitas Terkini",
  "addActivity": "Tambah Aktivitas Baru",
  "weeklyAchievement": "Prestasi Mingguan",
  "earningGP": "Perolehan GP",
  "addChallenge": "Tambah Tantangan",
  "startChallenge": "Memulai Tantangan Ini",
  "title": "Judul",
  "reward": "Hadiah",
  "status": "Status",
  "aktif": "Aktif",
  "nonaktif": "Tidak Aktif",
  "startDate": "Tanggal Mulai",
  "endDate": "Tanggal Berakhir",
  "submit": "Kirim",
  "selectChallenge": "Pilih Tantangan",
  "unauthorizedUser": "Pengguna tidak sah, Silakan masuk ulang",
  "locationError": "Kesalahan layanan lokasi",
  "activityValidationError": "Pastikan semua kolom terisi",
  "pleaseAddPhoto": "Silakan tambahkan foto aktivitas Anda!",
  "activityTime": "Waktu Aktivitas",
  "activityDetail": "Detail Aktivitas",
  "location": "Lokasi",
  "rewards": "Hadiah",
  "In Review": "Dalam Ulasan",
  "Aprroved": "Disetujui",
  "Rejected": "Ditolak",
  "changeStatusConfirmation":
      "Apakah Anda yakin akan mengubah status aktivitas ini menjadi ",
  "profile": "Profil",
  "faculty": "Fakultas",
  "language": "Bahasa",
  "english": "Bahasa Inggris",
  "indonesian": "Bahasa Indonesia",
  "theme": "Mode Tema",
  "light": "Terang",
  "dark": "Gelap",
  "appVersion": "Versi Aplikasi",
  "logout": "Keluar",
  "confirmation": "Apakah kamu yakin?",
  "logoutConfirmation": "Apakah Anda yakin untuk keluar dari aplikasi ini?",
  "cancel": "Batal",
  "adminDashboard": "Dashboard Admin",
  'profilePictureChanged': 'Foto profil berhasil diubah!',
  "rewardProducts": "Produk Hadiah",
  "greenFacilities": "Green Fasilitas",
  "activities": "Aktivitas",
  "allActivities": "Semua aktivitas",
  "filter": "Filter",
  "bannerCarousel": "Banner Carousel",
  "transactionGP": "Transaksi GP",
  "rewardsFrom": "Hadiah dari Tantangan @challenge",
  "success": "Berhasil",
  "dataSaved": "Data Berhasil Disimpan",
  "statusChanged": "Status Berhasil Diubah",
  "addProduct": "Tambah Produk",
  "editProduct": "Edit Produk",
  "detailProduct": "Detail Produk",
  "price": "Harga",
  "store": "Toko",
  "available": "Tersedia",
  "notAvailable": "Tidak Tersedia",
  "redeemInstruction": "Instruksi Penukaran",
  "notEnoughGP": "GP Tidak Cukup",
  "notEnoughGPMessage":
      "Anda tidak memiliki cukup Green Points untuk produk ini, mari kita tingkatkan Green Points Anda!",
  "redeemConfirmation": "Apakah Anda yakin ingin menebus produk ini?",
  "redeemConfirmMessage":
      "Anda akan menggunakan Green Point untuk mendapatkan produk ini",
  "wait": "Tunggu...",
  "error": "Kesalahan",
  "redemption": "Penukaran",
  "redeemConfirmed": "Penukaran Dikonfirmasi",
  "redemptionInfo": "Informasi Penukaran",
  "dateCreated": "Tangggal Dibuat",
  "invalid": "Tidak Valid",
  "valid": "Valid",
  "dateRedeemed": "Tanggal Penukaran",
  "productInfo": "Informasi Produk",
  "failedLoadRedemption": "Gagal memuat informasi penukaran, silakan kembali",
  "facilitiesForm": "Formulir Fasilitas",
  "facilitiesDetail": "Detail Fasilitas",
  "building": "Bangunan",
  "type": "Tipe",
  "latitude": "Lintang",
  "longitude": "Bujur",
  "isNotValidNumber": "Masukkan dengan format angka yang valid",
  "susMap": "Peta Keberlanjutan",
  "bikeStationQr": "Kode QR Stasiun Sepeda",
  "pickLocation": "Pilih Lokasi",
  "showQr": "Tampilkan QR",
  "bikeSharing": "Berbagi Sepeda",
  "bikeSharingQr": "Kode Berbagi Sepeda",
  "saveToGallery": "Simpan ke Galeri",
  "saveQr": "Simpan QR",
  "bikeStationLocation": "Lokasi Stasiun Sepeda",
  "rentalHistory": "Riwayat Penyewaan",
  "rentABike": "Sewa Sepeda",
  "activeRent": "Sewa Aktif",
  "start": "Mulai",
  "finish": "Selesai",
  "bikeForm": "Formulir Sepeda",
  "bikeStation": "Stasiun Sepeda",
  "goToBikeStation": "Pergi ke Stasiun Sepeda",
  "askStaffForBike": "Minta staf untuk sepeda",
  "scanBikeQR": "Pindai QR di Sepeda",
  "makeSureSuccessNotification":
      "Tunggu dan pastikan Anda mendapatkan notifikasi sukses",
  "enjoyBike": "Nikmati Sepeda",
  "putBikeAtLocation": "Letakkan Sepeda di lokasi",
  "scanStation": "Pindai QR Stasiun",
  "youreDone": "Penyewaan Anda selesai, terima kasih telah menggunakan",
  "invalidQR": "Kode QR tidak valid",
  "invalidQRMessageBike":
      "Tampaknya bukan kode QR untuk berbagi sepeda. Pastikan Anda memindai QR yang benar",
  "failedToLoadBike": "Gagal memuat data sepeda",
  "bikeStatusUnavailable": "Status sepeda tidak tersedia untuk digunakan",
  "successFinishRent": "Penyewaan Selesai Berhasil",
  "successRentABike": "Sewa Sepeda Berhasil",
  "bikeAvailable": "Sepeda Tersedia",
  'rentVerificator': 'Rental Verifikator',
  'verificationConfirmation': 'Konfirmasi Verifikasi',
  'verificationConfirmationMessage':
      'Apakah anda yakin mengkonfirmasi penyewaan ini, dan mengubah statusnya menjadi selesai',
  'successVerification': 'Berhasil memverifikasi penyewaan',
  'allRedemptions': 'Semua Penukaran',
  'scan': 'Scan',
  'confirmRedeem': 'Konfirmasi Penukaran',
  'confirmRedeemMessage':
      'Apakah anda yakin akan mengkonfirmasi penukaran ini?',
  'succeConfirmRedeem': 'Berhasil mengkonfirmasi penukaran',
  'verified': 'Terverifikasi',
  'unverified': 'Belum terverifikasi',
};
