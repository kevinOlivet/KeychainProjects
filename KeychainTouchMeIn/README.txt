#KeychainTouchMeIn

This project uses Keychain to save a username and password.
It doesn't use any 3rd party framework.
It uses a KeychainPasswordItem class taken from Apple's example files for GenericKeychain.
The sample code is available here:
https://developer.apple.com/library/content/samplecode/GenericKeychain/Introduction/Intro.html

If a username isn't detected it will offer the ability to sign up.
Once the user is verified they will have access to the notes in CoreData.

The project uses TouchID to verify the user's identity.
If the TouchID ability isn't detected the user can use a password instead.
Either way their data is detected.

This project also comes from a Ray Wenderlich tutorial here:
https://www.raywenderlich.com/147308/secure-ios-user-data-keychain-touch-id