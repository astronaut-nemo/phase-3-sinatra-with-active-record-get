class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  get '/' do
    { message: "Hello world" }.to_json
  end

  get "/games" do
    # Get all the games from the database
    games = Game.all.order(:title).limit(10)
    # Return a JSON response with an array of all the game data
    games.to_json
  end

  get "/games/:id" do
    # Look up the game in the database using its ID
    game = Game.find(params[:id])

    # Send a JSON-formatted response of the game data
    game.to_json(only: [:id, :title, :genre, :price],
      include: {
        reviews:{only: [:comment, :score],
          include: {
            user: {only: [:name]}
          }
        }
      }
    )
  end

end
