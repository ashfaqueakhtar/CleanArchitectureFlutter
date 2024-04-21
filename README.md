# CLEAN ARCHITECTURE in GetX

Before Starting lets have the tree level understanding about CLEAN ARCHITECTURE
Lets summarise as below

1. Data (local data, database)
    1. Model
    2. Repositories
    3. DataSources
2. Domain (Business logic layer)
    1. Entities
    2. Repositories
    3. UseCases
3. Presentation (UI like widgets, Screen)
    1. Pages or Screen
    2. Widgets

Repositories acts as a bridge between Data and Domain
UseCase has all logic that presentation layer observes or give action to

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## **Project required plugins**
`get: ^4.6.6'
'get_storage: ^2.1.1'
'dio: ^5.1.2'
'flutter_dotenv: ^5.0.1'
'fluttertoast: ^8.2.2'
'flutter_svg: ^2.0.7`

It's a minimalistic project with API call, Please don't expect an amazing UI rather expect something
related to code structure understanding below.

* **ENV** are used to store data securely with setup to multiple environment.

we can have 3 env for development: 
**UAT:** used for sharing build t client for their testing
**LIVE:** used for sharing app in store
**DEV:** used for development

* For **Json response** please follow a single format response for all APIs like below

`{
"success": true,
"status": 200,
"message": "Successfully fetch customer details",
"data": null
}`

where "data" has the main consumable data for all pages

* For **naming convention** use following

**File Name:** use Lower Snake case like file_utils.dart, home_screen.dart
**Class Name:** use Upper Camel case like FileUtils{}, HomeScreen{}
**Function Name:** use Lower Camel case like remove(), addPath()
**Variable Name** use Lower Camel case like isBoolean, urlPath

Add svg icon names with a prefix icon like iconShare.svg
Add screen as postFix for main screen like HomeScreen{}, DashboardScreen{} 

* **RepoImpl** has the code level breakup for handling of different error situations for API calls
Every repo is a collection of data sets that is used in a controller(usecase) to update UI(presentation).
AuthRepo can apis like loginWithPhone, loginWithNumber, logout and many more.
UserRepo can have apis like getUserDetails, getAllUsers and many more

