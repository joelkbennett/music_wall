# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Tracks.all
  erb :'tracks/index'
end

get '/tracks/new' do 
  erb :'tracks/new'
end

post '/tracks' do
  new_track = Tracks.new(
    song_title: params[:song_title],
    author: params[:author],
    url: params[:url]
  )
  if new_track.save 
    redirect '/'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do |id|
  @track = Tracks.find(id)
  erb :'tracks/show'
end
 

