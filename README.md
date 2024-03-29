# QuickFeed SwiftUI

macOS client for [QuickFeed](https://github.com/quickfeed/quickfeed)
![Student Lab Result](https://github.com/quickfeed/quickfeed-swiftui/blob/main/Images/macOS/Student/Submissions/LabDarkMode.png)

## Guide

### Requirements

* macOS 11.0+
* Xcode 12
* QuickFeed Server (local or remote)

### quickfeed / local-docker (server in local docker-container)

* `git pull git@github.com:quickfeed/quickfeed.git`
* `git checkout local-docker`
* add a db file
* build: `docker-compose up`

### quickfeed-swiftui

* open the xcode project `open Quickfeed.xcodeproj`
* specify server hostname in `Managers/GRPCManager:21`
* specify server port number in `Managers/GRPCManager:22`
* specify your userid in `Managers/GitHubManager:23`
* run the project
