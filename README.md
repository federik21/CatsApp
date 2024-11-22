
# Cats App
An app that retrieves useful information about cats utilising the Cat API (https://thecatapi.com/).

# Description
<p>The app displays a variety of cat breeds and displays them to the user<br>
The user can also save the cats as favourites.<br>
The main language of the app is Swift 5.6, UI was developed using SwiftUI, I have been using Swift Concurrency and Combine to propagate messages within the app.
</p>

# Getting started
<p>
1. Make sure you have the Xcode version 14.0 or above installed on your computer.<br>
2. Download the Cat App project files from the repository.<br>
3. Run the active scheme.<br>

# Architecture
* The Cats app is implemented using the <strong>Model-View-ViewModel(MVVM)</strong> architecture pattern.
* The Model will retrieve the information from network and local database, and merge them before providing them.
* The View is responsible for displaying the data to the user, such as cat informations and filtering options, as it changes in the viewModel.
* The ViewModel will get the data from the model, and propagate any user input or interactions to be handled.

# Structure 
* "View": Contains Views and ViewModels. Having a single "main" view and a viewmodel doesnt' make much sense to have different groups (for now).
* "Manager": It is the main interactor with the Domain level and the ViewModel level. In this way, the Viewmodel doesn't even know where the data is from,
* and doesn't even have to integrate it from different sources. All the logic is inside the manager, which needs a database and a network client.
* "Domain": It contains the two domains of the app, the database and the network client. The DB implementation in CoreData contains 2 entities
in relationship with eachother: Favourites and CatBreeds. Their relationship is 1-to-1 and is created whenever an user adds a cat to their favourites.
In other words, if a cat was marked as a favourite, it will exist a favourite entity with his id.
Deletion has been handled accordingly with the direction.

# Running the tests
<p>The Cat App can be tested using the built-in framework XCTest.<br>

# Deployment
Keep in mind that deploying an iOS app to the App Store requires having an Apple Developer account.

1. Click on the "Product" menu in Xcode and select "Archive." This will create an archive of your project.
2. Once the archive has been created, select it in the Organizer window and click on the "Validate" button to perform some preliminary tests on the app.
3. Once validation is complete, click on the "Distribute" button and select "Ad Hoc" or "App Store" distribution. 
This will create a signed IPA file that can be installed on iOS devices.
4. Follow the prompts in the distribution wizard to complete the distribution process.
5. Once the distribution is complete, you can use the IPA file to install the app on iOS devices

# Dependencies
No external dependencies were used.
