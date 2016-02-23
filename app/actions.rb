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
  @user = User.find(session[:uid])
  @upvotes = Vote.where(song_id: id).where(liked: true).count
  @downvotes = Vote.where(song_id: id).where(liked: false).count
  @user_vote = Vote.where(user_id: @user.id).where(song_id: id).take
  erb :'tracks/show'
end

delete '/tracks/:id' do |id|
  track = Track.find(id)
  track.destroy
  redirect '/tracks'
end

# User Routes
# TODO: Replace direct session bits with instance vars
post '/' do
  @user = User.find_by(email: params[:email])
  if @user.authenticate(params[:password])
    session[:name] = @user.first_name
    session[:uid] = @user.id
    redirect '/tracks'
  else
    erb 'error logging in'
  end
end

get '/signup' do
  erb :'users/new'
end

post '/signup' do
  @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: '', password_confirmation: 'nomatch')
  @user.password = params[:password]
  @user.password_confirmation = params[:pass_conf]
  @user.save
  session[:name] = @user.first_name
  session[:uid] = @user.id
  redirect '/'
end

get '/logout' do
  session[:name] = nil
  session[:id] = nil
  redirect '/'
end

# Vote actions

post '/tracks/:tid/:uid/up' do |tid, uid|
  vote = Vote.where(user_id: uid).where(song_id: tid).load
  # byebug
  if vote[0]
    vote.liked = true;
  else
    vote = Vote.new(user_id: uid, song_id: tid, liked: true)
  end

  if vote.save
    redirect "/tracks/#{tid}"
  else
    "FUCK"
  end
end

post '/tracks/:tid/:uid/down' do |tid, uid|
  vote = Vote.where(user_id: uid).where(song_id: tid).load
  # byebug
  if vote[0]
    vote.liked = false;
  else
    vote = Vote.new(user_id: uid, song_id: tid, liked: false) 
  end

  if vote.save
    redirect "/tracks/#{tid}"
  else
    "OHHH SHIT"
  end
end

get '/search' do

end

post '/search' do
  @results = Track.where(title: params[:search_term]).load
  erb = :'tracks/search_results'
end