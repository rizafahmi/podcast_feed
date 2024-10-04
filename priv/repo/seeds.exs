# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PodcastFeed.Repo.insert!(%PodcastFeed.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

PodcastFeed.Repo.insert!(%PodcastFeed.Podcasts.Episode{
  title: "The History of the World",
  description: "The History of the World",
  image:
    "https://media.npr.org/assets/img/2018/04/13/ap_170324854415_16x9-e1523888859682-s6-c85.jpg",
  duration: 3600,
  link: "https://www.npr.org/podcasts/510313/npr/the-history-of-the-world/podcast.mp3",
  episode: 1,
  season: 1
})
