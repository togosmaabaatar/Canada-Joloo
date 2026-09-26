require 'webrick'
root = File.expand_path(__dir__)
server = WEBrick::HTTPServer.new(Port: 8080, BindAddress: '127.0.0.1', DocumentRoot: root, AccessLog: [], Logger: WEBrick::Log.new($stderr, WEBrick::Log::WARN))
trap('INT') { server.shutdown }
puts 'Canada Joloo is ready at http://localhost:8080'
server.start
