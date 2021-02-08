require './config/environment'


use Rack::MethodOverride
use QuizzesController
use SessionsController
use UsersController
use CategoriesController
use UsersAccessesController
run ApplicationController