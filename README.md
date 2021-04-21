# QuickFeed SwiftUI

macOS client for [QuickFeed](https://github.com/autograde/quickfeed)


## Guide
### Reqirements
* macOS 
* Xcode
* Go
* Docker

### quickfeed / local-docker:
* `git pull git@github.com:oskargj/quickfeed.git`
* `git checkout local-docker`
* add a db file
* build: `docker-compose up`

### quickfeed-swiftui
* open the xcode project
`open Quickfeed.xcodeproj`
* specify your userid in `Managers/GitHubManager:35`
* run the project
