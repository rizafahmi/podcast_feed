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
  title: "Ngobrolin URL - Ngobrolin WEB ep45",
  description:
    "Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

  Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb",
  image: "https://i.ytimg.com/vi/EMynH33TrBI/maxresdefault.jpg",
  duration: 4216,
  link:
    "https://ngweb-assets.s3.amazonaws.com/Ngobrolin+URL+-+Ngobrolin+WEB+ep45+%5BEMynH33TrBI%5D.mp4",
  episode: 45,
  season: 1
})
