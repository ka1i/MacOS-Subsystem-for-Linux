import ArgumentParser

public var verStr = "v0.0.2"

public func showVer() {
    print("Author: mardan")
    print("Version: \(verStr)")
}

struct Version: ParsableArguments {
  @Flag(name: .shortAndLong,help: "Show app version.")
  var version: Bool = false

  func validate() throws {
    if version {
      showVer()
      throw ExitCode.success
    }
  }
}