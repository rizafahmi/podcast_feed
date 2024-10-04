defmodule PodcastFeedWeb.Router do
  use PodcastFeedWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :xml do
    plug :accepts, ["xml"]
  end

  scope "/api", PodcastFeedWeb do
    pipe_through :api
    get "/", HomeController, :index
    resources "/episodes", EpisodeController, except: [:new, :edit]
  end

  scope "/feed", PodcastFeedWeb do
    pipe_through :xml
    get "/", HomeController, :feed
  end
end
