class ApplicationController < Sinatra::Base
  get '/games' do
    content_type :json
    games = Game.all

    # return an array of JSON objects
    games.to_json(only: [:id, :title, :platform, :genre, :price])
  end

  get '/games/:id' do
    content_type :json
    game = Game.find(params[:id])

    # include associated reviews and users in the JSON response
    game.to_json(only: [:id, :title, :platform, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } },
      users: { only: [:name] }
    })
  end
end
