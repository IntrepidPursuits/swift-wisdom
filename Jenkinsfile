def xcodeProject = new io.intrepid.XcodeProject()
xcodeProject.name = 'SwiftWisdom'
xcodeProject.addBuild([ configuration: "Debug" ])
xcodeProject.xcodeVersion = '9.3'
xcodeProject.simulator = 'iPhone 8'

def config = [
  deploy: false,
  slack: [
    enabled: true,
    channel: "#ios",
  ]
]

xcodePipeline(this, xcodeProject, config)
