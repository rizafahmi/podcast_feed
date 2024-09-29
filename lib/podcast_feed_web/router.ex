defmodule PodcastFeedWeb.Router do
  use PodcastFeedWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PodcastFeedWeb do
    pipe_through :api
  end
end
