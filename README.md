# KeychainProjects
A collection of projects using Keychain.

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

#SwiftKeychainWrapperTest

This project implements Keychain to set, retrieve and delete passwords to/from Keychain.
It uses the wrapper files KeychainAccesiblity.swift and KeychainWrapper.swift taken from here:
https://github.com/jrendel/SwiftKeychainWrapper

The instructions say to install the framework using CocoaPods but really you only need those two files.
Save a little memory overhead when possible :)

#KeychainLocksmith

This project uses implements Keychain using the Locksmith 3rd party framework.
The Locksmith GitHub can be found here:
https://github.com/matthewpalmer/Locksmith

The framework was added using CocoaPods.

The project implements save, retrieve, update and delete using mock data.
The mock data and status is displayed in labels in the view.

I like this project as it saves a dictionary to a userAccount and not just a String, Double or Bool.
But using a 3rd party framework adds risk for a Keychain project.
