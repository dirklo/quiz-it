class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        use Rack::Flash
        enable :sessions
        set :session_secret, ENV['SESSION_SECRET']
    end

    get '/' do
        erb :index
    end

    helpers do
        def logged_in?
            !!session[:user_id]
        end

        def login(user)
            session[:user_id] = user.id
        end

        def logout!
            session.clear
        end

        def current_user
            User.find(session[:user_id]) if session[:user_id]
        end
    end
end