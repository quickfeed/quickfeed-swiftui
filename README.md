# QuickFeed SwiftUI

macOS client for [QuickFeed](https://github.com/autograde/quickfeed)


## Guide
### Reqirements
* macOS 11.0+
* Xcode 12
* QuickFeed Server (local or remote)

### quickfeed / local-docker (server in local docker-container):
* `git pull git@github.com:oskargj/quickfeed.git`
* `git checkout local-docker`
* add a db file
* build: `docker-compose up`

### quickfeed-swiftui
* open the xcode project
`open Quickfeed.xcodeproj`
* specify server hostname in `Managers/GRPCManager:21`
* specify server port number in `Managers/GRPCManager:22`
* specify your userid in `Managers/GitHubManager:23`
* run the project
