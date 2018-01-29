def xcodeProject = new io.intrepid.XcodeProject()
xcodeProject.name = 'SwiftWisdom'
xcodeProject.addBuild([ configuration: "Debug" ])
xcodeProject.xcodeVersion = '9'
xcodeProject.simulator = 'iPhone 7'

def config = [
  deploy: false,
  slack: [
    enabled: true,
    channel: "#ios",
  ]
]

xcodePipeline(this, xcodeProject, config)
