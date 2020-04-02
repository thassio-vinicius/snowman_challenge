# Snowman Labs Challenge

A mobile challenge using Flutter for Snowman Labs. Implemented using Provider, GeoLocator, Google Maps, Firebase, Firestore and Facebook authentication.

# User Stories and Business Rules implemented

### 🔒 As an anonymous user

✅ I want to sign up using my Facebook account.

✅ I want to sign in using my Facebook account.

### 🔓 As a logged in User

❌ I want to see a list of tourist spots in a 5 km radius from a given location.

❌ I want to search for tourist spots by name.

✅ I want to register a tourist spot (picture, name, geographical location and category).

✅ I want to comment about a tourist spot.

✅ I want to see comments about a tourist spot.

✅ I want to add pictures to a tourist spot.

❌ I want to remove pictures I added to a tourist spot.

✅ I want to favorite a tourist spot.

✅ I want to see my favorites tourist spots.

✅ I want to remove a tourist spot from my favorites.

✅ I want to upvote a tourist spot.

✅ I want to see the tourist spots I registered.

❌ I want to create new categories.

### Business Rules

✅ Anonymous users can only see things.

❌ Initial Categories are "Park", "Museum", "Theater", "Monument"

# A few notes about the project:

📌 Although i've created the layout with responsiveness in mind, i only had time to test it on a Nexus 5X emulator, there's no way to know if the app is gonna look responsive on different screensizes. Please keep that in mind.

📌 The project is supposed to run on iOS as well and i fully configured it to do so. But, as i said, i only had time to test it on a Nexus 5X, and also i don't have an iOS system to test on.

📌 Unfortunately, i didn't implement a loading state on a few screens (i.e Sign Options screen when signIn/signUp button is pressed), that doesn't mean the feature/screen isn't working, just wait a few seconds.

📌 Terminal and Logcat might show a few errors depending on which feature you're testing, but most of those errors come from non-implemented exception treatments.

📌 From time to time, GeoLocator (dependency for getting the user's current location and parsing coordinates) throws the following exception: PlatformException(ERROR_GEOCODING_COORDINATES, grpc failed, null). According to the dependency's issues section on github, this exception occurs for people that are in a region that are restricted for accessing Google Play Services. (https://github.com/Baseflow/flutter-geolocator/issues/398 ; https://github.com/Baseflow/flutter-geolocator/issues/223) When that happens, the only solution for me is to restart the app, call flutter clean and wait for a few minutes. 

📌 I didn't have time to implement google places, so in order to add a new tourist spot, you have to type in correctly the full address (i.e Avenida Paulista, 1230)

📌 Since it's a test project, i've left the API key inside the project. I hope there's no problem.

📌 Facebook authentication doesn't work on real devices, due to Facebook's policy to only allow it's SDK to work with apps that already have privacy policy and license terms defined. On top of that, the Emulator's current location always defaults to Google's office in Palo Alto, which means you'll be testing only as an anonymous user or as a Palo Alto's tourist. Because of that, i've created a new branch that points directly to SnowMan Labs' office coordinates. That should make it easier to test all of the app's features at once. Just switch branches to snow_coords and you're good to go! 

📌 That's it! Thank you for this opportunity, and i sincerely hope you guys have enjoyed my 1-week project. 😊

