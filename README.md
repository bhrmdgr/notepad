# 🗒️ Flutter Notepad App

This project is a simple and user-friendly **notepad application** built with **Flutter**. Users can create note categories (titles), add sub-pages under each title, and write notes for each page.

## ✨ Features

- 📁 **Title → Subpage → Note** structure
- 💾 Uses **SQLite** for local data storage
- ✏️ Add, edit, and delete notes
- 📱 Responsive and minimal UI
- 💜 Soft pastel-themed design

## 📸 Screenshots

### Home Page
Displays all note titles created by the user.

![Ekran görüntüsü 2024-08-19 171318](https://github.com/user-attachments/assets/c4f746d4-6d27-4930-8bc0-143879b78b13)


### Subpages (Note Pages)
Shows pages (sub-notes) under the selected title.

![Ekran görüntüsü 2024-08-19 171346](https://github.com/user-attachments/assets/7bb8d8cf-8957-4f58-994e-4b261f527515)


### Note Detail
Write and automatically save the content of a selected note page.

![Ekran görüntüsü 2024-08-19 171415](https://github.com/user-attachments/assets/b8342188-945f-4e6b-9815-64da12bb5e67)


## 🛠️ Built With

- [Flutter](https://flutter.dev/) – UI toolkit for building apps
- [sqflite](https://pub.dev/packages/sqflite) – SQLite plugin for Flutter
- [Path Provider](https://pub.dev/packages/path_provider) – Access to local file paths


```bash
git clone https://github.com/your-username/flutter-notepad.git
cd flutter-notepad
flutter pub get
flutter run
