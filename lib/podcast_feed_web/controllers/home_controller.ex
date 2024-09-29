defmodule PodcastFeedWeb.HomeController do
  use PodcastFeedWeb, :controller

  def index(conn, _params) do
    text(conn, "OK. Environment: #{Mix.env()}")
  end
end
