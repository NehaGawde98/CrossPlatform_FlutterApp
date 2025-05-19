# Book Buddy

Book Buddy is a Flutter-based application for efficient management of books data.
It utilizes Back4App for seamless data storage and retrieval of the book information.

**Assignment PPT**- **https://github.com/NehaGawde98/CrossPlatform_FlutterApp/blob/main/BookBuddy.pptx**

**1. ARCHITECTURE**<br>
UI Layer -  Frontend built using Flutter, enabling cross-platform compatibility for Android and iOS - <br>
&nbsp;&nbsp;&nbsp;&nbsp;- Signup/Login Screens <br>
&nbsp;&nbsp;&nbsp;&nbsp;- Book service screens – Book list, Add Book, Edit Book, Delete book <br>
Parse API Layer (Back4App Integration) - The app uses ParseUser API [signUp(), login()] to communicate 	with Back4App. <br>
Backend - Powered by Back4App (Parse Server), which handles user 	authentication, data storage, and session validation. <br>

**2. AUTHENTICATION** <br>
Signup/Login  screens built using Flutter forms.<br>
Used Back4App’s ParseUser class to handle –  <br>
&nbsp;&nbsp;&nbsp;&nbsp;- User registration : ParseUser.signUp()<br>
&nbsp;&nbsp;&nbsp;&nbsp;- User login : ParseUser.login()<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Session Management : Persistent login using session tokens<br>
Access Control – Data is protected using ACLs(Access Control Lists) so that only logged in users can access/modify book data. <br>

**3. DATABASE STRUCTURE** <br>
User – default class – manages authentication<br> 
&nbsp;&nbsp;&nbsp;&nbsp;- Fields : email, password <br>
Books – custom class – stores book details for CRUD operations<br>
&nbsp;&nbsp;&nbsp;&nbsp;- Fields : title, author, genre, availability <br>

**4. SOFTWARE REQUIREMENTS** <br>
Android Studio – IDE for development <br>
Flutter SDK – for UI development <br>
Back4App server – Backend service <br>

**5. DEMO LINK** <br>
https://youtu.be/1iPj51VFaTs

**6. FEATURES** <br>
  - Signup Screen :<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Allows new users to register by providing mail and password.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Displays success/error toast messages after signup.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Redirects user to Login screen upon successful signup.<br>
  - Login Screen :<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Allows users to login by providing mail and password.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Displays success/error toast messages after signup.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Redirects user to Book List screen upon successful signup.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Provides option for new users to sign up.<br>
  - Book List Screen :<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Displays list of books fetched from Back4App server.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Provides option to add, edit, delete books.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Redirects user to Book Form screen for add/edit operations.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Refreshes the book list after CRUD operations.<br>
  - Book Form Screen :<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Allows user to add or edit book details.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Displays success/error toast messages after operation.<br>
  &nbsp;&nbsp;&nbsp;&nbsp;- Redirects user to Book List screen after saving changes.<br>




   







