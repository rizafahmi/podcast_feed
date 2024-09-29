defmodule PodcastFeedWeb.EpisodeController do
  use PodcastFeedWeb, :controller

  alias PodcastFeed.Podcasts
  alias PodcastFeed.Podcasts.Episode

  action_fallback PodcastFeedWeb.FallbackController

  def index(conn, _params) do
    episodes = Podcasts.list_episodes()
    render(conn, :index, episodes: episodes)
  end

  def create(conn, %{"episode" => episode_params}) do
    with {:ok, %Episode{} = episode} <- Podcasts.create_episode(episode_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/episodes/#{episode}")
      |> render(:show, episode: episode)
    end
  end

  def show(conn, %{"id" => id}) do
    episode = Podcasts.get_episode!(id)
    render(conn, :show, episode: episode)
  end

  def update(conn, %{"id" => id, "episode" => episode_params}) do
    episode = Podcasts.get_episode!(id)

    with {:ok, %Episode{} = episode} <- Podcasts.update_episode(episode, episode_params) do
      render(conn, :show, episode: episode)
    end
  end

  def delete(conn, %{"id" => id}) do
    episode = Podcasts.get_episode!(id)

    with {:ok, %Episode{}} <- Podcasts.delete_episode(episode) do
      send_resp(conn, :no_content, "")
    end
  end
end
