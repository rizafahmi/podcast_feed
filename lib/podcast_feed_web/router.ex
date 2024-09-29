defmodule PodcastFeedWeb.Router do
  use PodcastFeedWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PodcastFeedWeb do
    pipe_through :api
    get "/", HomeController, :index
  end
end
