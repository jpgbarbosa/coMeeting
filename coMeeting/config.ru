# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# And beautifully gzipped responses
use Rack::Deflater

run CoMeeting::Application
