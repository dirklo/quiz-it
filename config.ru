require './config/environment'


use Rack::MethodOverride
use QuizzesController
use SessionsController
run ApplicationController