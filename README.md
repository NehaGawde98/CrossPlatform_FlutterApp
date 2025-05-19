# Book Buddy

Book Buddy is a Flutter-based application for efficient management of books data.
It utilizes Back4App for seamless data storage and retrieval of the book information.

**Assignment PPT**- **https://github.com/NehaGawde98/CrossPlatform_FlutterApp/blob/main/BookBuddy.pptx**

**1. ARCHITECTURE**
UI Layer -  Frontend built using Flutter, enabling cross-platform compatibility for Android and iOS - 
    * Signup/Login Screens
    * Book service screens – Book list, Add Book, Edit Book, Delete book
Parse API Layer (Back4App Integration) - The app uses ParseUser API [signUp(), login()] to communicate 	with Back4App.
Backend - Powered by Back4App (Parse Server), which handles user 	authentication, data storage, and session validation

**2. AUTHENTICATION**
Signup/Login  screens built using Flutter forms.
Used Back4App’s ParseUser class to handle –  
    * User registration : ParseUser.signUp()   
    * User login : ParseUser.login()    
    * Session Management : Persistent login using session tokens
Access Control – Data is protected using ACLs(Access Control Lists) so that only logged in users can access/modify book data.

**3. DATABASE STRUCTURE**
User – default class – manages authentication      
    * Fields : email, password
Books – custom class – stores book details for CRUD operations    
    * Fields : title, author, genre, availability

**4. SOFTWARE REQUIREMENTS**
Android Studio – IDE for development 
Flutter SDK – for UI development 
Back4App server – Backend service

**5. Demo Link**
https://youtu.be/1iPj51VFaTs



   







