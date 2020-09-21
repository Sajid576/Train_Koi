# Project Architecture

TrainKoi is composed of a backend and a frontend side. Backend is responsible for storing realtime locations of all the trains,running a graph algorithm for creating a route ,calculating required distance and estimated time between the train and the stations.
And the frontend to allow the user to query their desired train locations and view the route , required distance , estimated time and the nearest stations.





## Documentation

- https://blog.codemagic.io/creating-a-route-calculator-using-google-maps/  (Google Map API for flutter)


## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

- Operating Systems: Windows 7 SP1 or later (64-bit)
- Disk Space: 1.32 GB (does not include disk space for IDE/tools).
- Tools: Flutter depends on these tools being available in your environment.
- Windows PowerShell 5.0 or newer (this is pre-installed with Windows 10)
- Git for Windows 2.x, with the Use Git from the Windows Command Prompt option.

If Git for Windows is already installed, make sure you can run git commands from the command prompt or PowerShell.




## Installation Guide:


- Download and install Android Studio.
- Start Android Studio, and go through the ‘Android Studio Setup Wizard’. This installs the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, which are required by Flutter when developing for Android.
- Minimum Android studio version 4.0

##### Install the Flutter and Dart Plugins.

- First, start Android Studio.
- Open plugin preferences (File > Settings > Plugins )
- Select Browse repositories, select the Flutter plugin and click Install. 

##### Set up your Android device 
- To prepare to run and test your Flutter app on an Android device, you need an Android device running Android 4.1 (API level 16) or higher.

- Enable Developer options and USB debugging on your device. Detailed instructions are available in the Android documentation.

- Using a USB cable, plug your phone into your computer. If prompted on your device, authorize your computer to access your device.
In the terminal, run the flutter devices command to verify that Flutter recognizes your connected Android device. By default, Flutter uses the version of the Android SDK where your adb tool is based. If you want Flutter to use a different installation of the Android SDK, you must set the ANDROID_SDK_ROOT environment variable to that installation directory.

##### Get the flutter SDK

- Go to the SDK archive page(https://flutter.dev/docs/development/tools/sdk/releases) to see all releases of Flutter SDK.

- Create the new folder as flutter into C:\src (C:\src\flutter) and extract the Flutter SDK zip file in to there.

- After extracting the Flutter SDK, Start it by double-clicking on flutter_console.bat inside the Flutter file.

After finishing this all, now you can run the flutter commands in the flutter console.

If you wish to run the Flutter commands in regular windows console, You have to set up the environment variable for flutter path.
After finishing this all, now you can run the flutter commands in the flutter console.
If you wish to run the Flutter commands in regular windows console, You have to set up the environment variable for flutter path.

##### Set up an Environment variable for Flutter.
- In your start search bar search as ‘eve’ and select Edit environment variables for your account.
Under User Variables select the option PATH and Edit…

<img width="473" alt="Capture" src="https://user-images.githubusercontent.com/36130772/93694748-5d916380-fb31-11ea-96ed-68534e7517cd.PNG">

- Edit environment variable window will pop-up.

<img width="482" alt="Capture1" src="https://user-images.githubusercontent.com/36130772/93694807-e3151380-fb31-11ea-8158-9363844f2823.PNG">

- Click the option New and Input the flutter bin path (C:\src\flutter\bin). 

<img width="460" alt="Capture2" src="https://user-images.githubusercontent.com/36130772/93694818-18216600-fb32-11ea-8ba6-b8bfd9d30a21.PNG">

Then click ok, ok.
Note: Note that you will have to close and reopen any existing console windows for these changes to take effect.

##### Run Flutter Doctor.
`flutter doctor` command use to see if there any platform dependencies need to complete the setup.
You can also run this command from android studio IDE.

##### Configure the android project

- After opening the project you might have to configure the flutter SDK.

- Then use `pub get` command to install all the required plugins.(Make sure you are on the path where the pubspec.yaml exists)

- Then use `flutter clean` command and run the project.

You are good to go... :)



