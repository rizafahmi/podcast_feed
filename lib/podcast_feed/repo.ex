defmodule PodcastFeed.Repo do
  use Ecto.Repo,
    otp_app: :podcast_feed,
    adapter: Ecto.Adapters.Postgres
end
