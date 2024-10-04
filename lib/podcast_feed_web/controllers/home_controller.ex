defmodule PodcastFeedWeb.HomeController do
  use PodcastFeedWeb, :controller

  alias PodcastFeed.Podcasts

  def index(conn, _params) do
    text(conn, "OK. Environment: #{Mix.env()}")
  end

  def feed(conn, _params) do
    episodes = Podcasts.list_episodes()

    xml_data =
      """
      <% import Format %>
          <rss xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
          <channel>
          <title>
          <![CDATA[ Ngobrolin WEB ]]>
          </title>
          <description>
          <![CDATA[
      Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

      Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb
          ]]>
          </description>
          <link>https://ngobrol.in/web</link>
          <image>
          <url>
          https://i.ytimg.com/pl_c/PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT/studio_square_thumbnail.jpg?sqp=CKGX6bcG-oaymwEICNAFENAFSFqi85f_AwYIoI6eqgY=&rs=AOn4CLC_S19WzNPoIBZOQedMhNkzSFUQjQ
          </url>
          <title>Ngobrolin WEB</title>
          <link>https://ngobrol.in/web</link>
          </image>
          <generator>Podcast Creator</generator>
          <lastBuildDate>Tue, 24 Sep 2024 10:27:25 GMT</lastBuildDate>
          <atom:link href="https://anchor.fm/s/30348d4/podcast/rss" rel="self" type="application/rss+xml"/>
          <author>
          <![CDATA[ Ngobrolin WEB ]]>
          </author>
          <copyright>
          <![CDATA[ Ngobrolin WEB ]]>
          </copyright>
          <language>
          <![CDATA[ in ]]>
          </language>
          <atom:link rel="hub" href="https://pubsubhubbub.appspot.com/"/>
          <itunes:author>Ngobrolin WEB</itunes:author>
          <itunes:summary>
          Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

          Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb
          </itunes:summary>
          <itunes:type>episodic</itunes:type>
          <itunes:owner>
          <itunes:name>Ngobrolin WEB</itunes:name>
          <itunes:email>rizafahmi@gmail.com</itunes:email>
          </itunes:owner>
          <itunes:explicit>No</itunes:explicit>
          <itunes:category text="Technology"/>
          <itunes:image href="https://i.ytimg.com/pl_c/PLTY2nW4jwtG8Sx2Bw6QShC271PzX31CtT/studio_square_thumbnail.jpg?sqp=CKGX6bcG-oaymwEICNAFENAFSFqi85f_AwYIoI6eqgY=&rs=AOn4CLC_S19WzNPoIBZOQedMhNkzSFUQjQ"/>
          <item>
          <%= for episode <- @episodes do %>
              <title>
              <![CDATA[ <%= episode.title %> ]]>
              </title>
              <description>
              <![CDATA[
              <%= episode.description %>
              ]]>
              </description>
              <link>TODO</link>
              <pubDate><%= episode.updated_at %></pubDate>
              <guid isPermaLink="false"><%= episode.id %></guid>
              <dc:creator>Ngobrolin WEB</dc:creator>
              <enclosure url="<%= episode.link %>" length="<%= episode.duration %>" type="audio/mpeg" />
              <itunes:summary>
              <![CDATA[
              <%= episode.description %>
              ]]>
              </itunes:summary>
              <itunes:explicit>No</itunes:explicit>
              <itunes:duration><%= Format.duration_format(episode.duration) %></itunes:duration>
              <itunes:image href="" />
              <itunes:season><%= episode.season %></itunes:season>
              <itunes:episode><%= episode.episode %></itunes:episode>
              <itunes:episodeType>full</itunes:episodeType>
              <% end %>
          </item>
      """
      |> EEx.eval_string(assigns: [episodes: episodes])

    conn
    |> put_resp_content_type("application/rss+xml")
    |> send_resp(200, xml_data)
  end
end

defmodule Format do
  def duration_format(duration) do
    minutes = div(duration, 60)
    seconds = rem(duration, 60)
    "#{minutes}:#{String.pad_leading(Integer.to_string(seconds), 2, "0")}"
  end
end
