get '/' do
  @track_count = Track.all.count
  erb :index
end

get '/tracks' do
  tracks = Track.all
  if params[:search_term]
    tracks = tracks.where("song_title LIKE :query", query: "%#{params[:search_term]}")
  end

  @tracks = tracks.sort_by { |track| track.total_votes }.reverse
  erb :'tracks/index'
end

get '/tracks/new' do 
  erb :'tracks/new'
end

post '/tracks' do
  new_track = Track.new(
    song_title: params[:song_title],
    author: params[:author],
    url: params[:url],
    user_id: session[:uid]
  )
  if new_track.save 
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do |id|
  @track = Track.find(id)
  if session[:uid]
    @user = User.find(session[:uid])
    @upvotes = Vote.where(track_id: id).where(liked: true).count
    @downvotes = Vote.where(track_id: id).where(liked: false).count
    @user_vote = Vote.where(user_id: @user.id).where(track_id: id).take
  end
  erb :'tracks/show'
end

post '/tracks/:id' do |id|
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
  session.clear
  redirect '/'
end

get '/users/:id' do |id|
  @user = User.find(id)
  erb :'users/show'
end

# Vote actions

post '/tracks/:tid/up' do |tid|
  vote = Vote.where(user_id: session[:uid]).where(track_id: tid).take

  if vote
    vote.liked = true;
  else
    vote = Vote.new(user_id: session[:uid], track_id: tid, liked: true)
  end

  if vote.save
    redirect "/tracks/#{tid}"
  else
    "FUCK"
  end
end

post '/tracks/:tid/down' do |tid|
  vote = Vote.where(user_id: session[:uid]).where(track_id: tid).take
  if vote
    vote.liked = false;
  else
    vote = Vote.new(user_id: session[:uid], track_id: tid, liked: false)
  end

  if vote.save
    redirect "/tracks/#{tid}"
  else
    "OHHH SHIT"
  end
end

get '/search' do

end

# Comments

post '/tracks/:id/comment' do |id|
  new_comment = Comment.new(user_id: session[:uid], track_id: id, comment: params[:comment], rating: params[:rating])
  if new_comment.save
    redirect "/tracks/#{id}"
  else
    "BLERG"
  end
end

post '/tracks/:id/comment/:cid' do |tid, cid|
  review = Comment.find(cid)
  if session[:uid] && session[:uid] == review.user_id
    review = Comment.find(cid)
    review.destroy
    redirect "/tracks/#{tid}"
  end
end

# Search
# 
# post '/search' do
#   @results = Track.where(title: params[:search_term]).load
#   erb = :'tracks/search_results'
# end