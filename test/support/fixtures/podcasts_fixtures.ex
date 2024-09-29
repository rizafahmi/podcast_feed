defmodule PodcastFeed.PodcastsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PodcastFeed.Podcasts` context.
  """

  @doc """
  Generate a episode.
  """
  def episode_fixture(attrs \\ %{}) do
    {:ok, episode} =
      attrs
      |> Enum.into(%{
        description: "some description",
        duration: 42,
        episode: 42,
        image: "some image",
        link: "some link",
        season: 42,
        title: "some title"
      })
      |> PodcastFeed.Podcasts.create_episode()

    episode
  end
end
