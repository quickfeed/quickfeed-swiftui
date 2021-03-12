# QuickFeed SwiftUI

macOS client for [QuickFeed](https://github.com/autograde/quickfeed)


## Guide
### Reqirements
* Macos 
* Xcode
* Go
* Docker

### quickfeed / local-docker:
* `git pull git@github.com:oskargj/quickfeed.git`
* `git checkout local-docker`
* add a db file

### quickfeed-swiftui
* specify path to quickfeed in the makefile, and make local-server (or run the server from quickfeed dir)
* open the xcode project
`open Quickfeed.xcodeproj`
* specify your userid in `providers/serverProvider:14`
* run the project
