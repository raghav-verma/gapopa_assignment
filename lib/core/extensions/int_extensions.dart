name: Deploy Flutter Web to GitHub Pages

on:
push:
branches:
- main  # The workflow will trigger on a push to the 'main' branch

jobs:
build:
runs-on: ubuntu-latest

steps:
- name: Checkout the repository
uses: actions/checkout@v2

- name: Set up Flutter
uses: subosito/flutter-action@v2
with:
flutter-version: 'stable'

- name: Install dependencies
run: flutter pub get

- name: Build Flutter Web
run: flutter build web

- name: Deploy to GitH
