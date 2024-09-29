defmodule PodcastFeedWeb.EpisodeControllerTest do
  use PodcastFeedWeb.ConnCase

  import PodcastFeed.PodcastsFixtures

  alias PodcastFeed.Podcasts.Episode

  @create_attrs %{
    description: "some description",
    duration: 42,
    episode: 42,
    image: "some image",
    link: "some link",
    season: 42,
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    duration: 43,
    episode: 43,
    image: "some updated image",
    link: "some updated link",
    season: 43,
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, duration: nil, episode: nil, image: nil, link: nil, season: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all episodes", %{conn: conn} do
      conn = get(conn, ~p"/api/episodes")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create episode" do
    test "renders episode when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/episodes", episode: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/episodes/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "duration" => 42,
               "episode" => 42,
               "image" => "some image",
               "link" => "some link",
               "season" => 42,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/episodes", episode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update episode" do
    setup [:create_episode]

    test "renders episode when data is valid", %{conn: conn, episode: %Episode{id: id} = episode} do
      conn = put(conn, ~p"/api/episodes/#{episode}", episode: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/episodes/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "duration" => 43,
               "episode" => 43,
               "image" => "some updated image",
               "link" => "some updated link",
               "season" => 43,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, episode: episode} do
      conn = put(conn, ~p"/api/episodes/#{episode}", episode: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete episode" do
    setup [:create_episode]

    test "deletes chosen episode", %{conn: conn, episode: episode} do
      conn = delete(conn, ~p"/api/episodes/#{episode}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/episodes/#{episode}")
      end
    end
  end

  defp create_episode(_) do
    episode = episode_fixture()
    %{episode: episode}
  end
end
