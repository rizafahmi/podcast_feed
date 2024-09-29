defmodule PodcastFeed.Repo.Migrations.CreateEpisodes do
  use Ecto.Migration

  def change do
    create table(:episodes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :link, :string
      add :duration, :integer
      add :image, :string
      add :season, :integer
      add :episode, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
