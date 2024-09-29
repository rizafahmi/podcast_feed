defmodule PodcastFeed.Podcasts.Episode do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "episodes" do
    field :description, :string
    field :duration, :integer
    field :episode, :integer
    field :image, :string
    field :link, :string
    field :season, :integer
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [:title, :description, :link, :duration, :image, :season, :episode])
    |> validate_required([:title, :description, :link, :duration, :image, :season, :episode])
  end
end
