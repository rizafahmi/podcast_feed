defmodule PodcastFeedWeb.EpisodeJSON do
  alias PodcastFeed.Podcasts.Episode

  @doc """
  Renders a list of episodes.
  """
  def index(%{episodes: episodes}) do
    %{data: for(episode <- episodes, do: data(episode))}
  end

  @doc """
  Renders a single episode.
  """
  def show(%{episode: episode}) do
    %{data: data(episode)}
  end

  defp data(%Episode{} = episode) do
    %{
      id: episode.id,
      title: episode.title,
      description: episode.description,
      link: episode.link,
      duration: episode.duration,
      image: episode.image,
      season: episode.season,
      episode: episode.episode
    }
  end
end
