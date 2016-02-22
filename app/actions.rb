get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do 
  erb :'tracks/new'
end

post '/tracks' do
  new_track = Track.new(
    song_title: params[:song_title],
    author: params[:author],
    url: params[:url]
  )
  if new_track.save 
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do |id|
  @track = Track.find(id)
  erb :'tracks/show'
end

delete '/tracks/:id' do |id|
  track = Tracks.find(id)
  track.destroy
  redirect '/tracks'
end

# User Routes
post '/' do
  byebug
  @user = User.find_by(email: params[:email])
  if @user.password == BCrypt::Engine.hash_secret(params[:password], @user.salt)
    session[:name] = params[:first_name]
    redirect '/'
  else
    erb 'error logging in'
  end
end

get '/signup' do
  erb :'users/new'
end

post '/signup' do
  pw_salt = BCrypt::Engine.generate_salt
  pw_hash = BCrypt::Engine.hash_secret(params[:password], pw_salt)
  @user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: pw_hash, salt: pw_salt)
  session[:name] = @user.first_name
  redirect '/'
end

get '/logout' do
  session[:name] = nil
  redirect '/'
end