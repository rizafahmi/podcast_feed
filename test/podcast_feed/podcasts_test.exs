defmodule PodcastFeed.PodcastsTest do
  use PodcastFeed.DataCase

  alias PodcastFeed.Podcasts

  describe "episodes" do
    alias PodcastFeed.Podcasts.Episode

    import PodcastFeed.PodcastsFixtures

    @invalid_attrs %{description: nil, duration: nil, episode: nil, image: nil, link: nil, season: nil, title: nil}

    test "list_episodes/0 returns all episodes" do
      episode = episode_fixture()
      assert Podcasts.list_episodes() == [episode]
    end

    test "get_episode!/1 returns the episode with given id" do
      episode = episode_fixture()
      assert Podcasts.get_episode!(episode.id) == episode
    end

    test "create_episode/1 with valid data creates a episode" do
      valid_attrs = %{description: "some description", duration: 42, episode: 42, image: "some image", link: "some link", season: 42, title: "some title"}

      assert {:ok, %Episode{} = episode} = Podcasts.create_episode(valid_attrs)
      assert episode.description == "some description"
      assert episode.duration == 42
      assert episode.episode == 42
      assert episode.image == "some image"
      assert episode.link == "some link"
      assert episode.season == 42
      assert episode.title == "some title"
    end

    test "create_episode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Podcasts.create_episode(@invalid_attrs)
    end

    test "update_episode/2 with valid data updates the episode" do
      episode = episode_fixture()
      update_attrs = %{description: "some updated description", duration: 43, episode: 43, image: "some updated image", link: "some updated link", season: 43, title: "some updated title"}

      assert {:ok, %Episode{} = episode} = Podcasts.update_episode(episode, update_attrs)
      assert episode.description == "some updated description"
      assert episode.duration == 43
      assert episode.episode == 43
      assert episode.image == "some updated image"
      assert episode.link == "some updated link"
      assert episode.season == 43
      assert episode.title == "some updated title"
    end

    test "update_episode/2 with invalid data returns error changeset" do
      episode = episode_fixture()
      assert {:error, %Ecto.Changeset{}} = Podcasts.update_episode(episode, @invalid_attrs)
      assert episode == Podcasts.get_episode!(episode.id)
    end

    test "delete_episode/1 deletes the episode" do
      episode = episode_fixture()
      assert {:ok, %Episode{}} = Podcasts.delete_episode(episode)
      assert_raise Ecto.NoResultsError, fn -> Podcasts.get_episode!(episode.id) end
    end

    test "change_episode/1 returns a episode changeset" do
      episode = episode_fixture()
      assert %Ecto.Changeset{} = Podcasts.change_episode(episode)
    end
  end
end
