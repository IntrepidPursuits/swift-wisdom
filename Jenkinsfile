def xcodeProject = new io.intrepid.XcodeProject()
xcodeProject.name = 'SwiftWisdom'
xcodeProject.addBuild([ configuration: "Debug" ])
xcodeProject.xcodeVersion = '10.0'
xcodeProject.simulator = 'iPhone 8'

def config = [
  deploy: false,
  slack: [
    enabled: true,
    channel: "#ios",
  ]
]

xcodePipeline(this, xcodeProject, config)
