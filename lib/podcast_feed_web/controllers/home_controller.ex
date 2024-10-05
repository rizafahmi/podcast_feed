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
      <?xml version="1.0"?>
      <rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
      xmlns:podcast="https://podcastindex.org/namespace/1.0"
      xmlns:atom="http://www.w3.org/2005/Atom"
      xmlns:content="http://purl.org/rss/1.0/modules/content/">
          <channel>
          <title>
          <![CDATA[Ngobrolin WEB]]>
          </title>
          <description><![CDATA[Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

      Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb]]>
          </description>
          <link>https://ngobrol.in/web</link>
          <image>
          <url><![CDATA[https://ngweb-assets.s3.amazonaws.com/thumbnail-podcast-square.png]]></url>
          <title>Ngobrolin WEB</title>
          <link>https://ngobrol.in/web</link>
          </image>
          <generator>Podcast Creator</generator>
          <lastBuildDate>Tue, 24 Sep 2024 10:27:25 GMT</lastBuildDate>
          <atom:link href="https://ngobrolinweb.riza.world/feed" rel="self" type="application/rss+xml"/>
          <author>Ngobrolin WEB</author>
          <copyright>
          <![CDATA[Ngobrolin WEB]]>
          </copyright>
          <language>
          <![CDATA[in]]>
          </language>
          <itunes:author>Ngobrolin WEB</itunes:author>
          <itunes:summary><![CDATA[Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

          Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb]]>
          </itunes:summary>
          <itunes:type>episodic</itunes:type>
          <itunes:owner>
          <itunes:name>Ngobrolin WEB</itunes:name>
          <itunes:email>rizafahmi@gmail.com</itunes:email>
          </itunes:owner>
          <itunes:explicit>No</itunes:explicit>
          <itunes:category text="Technology"/>
          <itunes:image href="https://ngweb-assets.s3.amazonaws.com/thumbnail-podcast-square.png"/>
          <% import Format %>
          <item>
          <%= for episode <- @episodes do %>
              <title>
              <![CDATA[<%= episode.title %>]]>
              </title>
              <description>
              <![CDATA[<%= episode.description %>]]>
              </description>
              <link>https://ngweb-assets.s3.amazonaws.com/Ngobrolin%20URL%20-%20Ngobrolin%20WEB%20ep45%20%5BEMynH33TrBI%5D.mp4</link>
              <pubDate><%= episode.updated_at %></pubDate>
              <guid isPermaLink="false"><%= episode.id %></guid>
              <enclosure url="<%= episode.link %>" length="<%= episode.duration %>" type="audio/mpeg" />
              <itunes:summary>
              <![CDATA[<%= episode.description %>]]>
              </itunes:summary>
              <itunes:explicit>No</itunes:explicit>
              <itunes:duration><%= Format.duration_format(episode.duration) %></itunes:duration>
              <itunes:image href="https://ngweb-assets.s3.amazonaws.com/thumbnail-podcast-square.png" />
              <itunes:season><%= episode.season %></itunes:season>
              <itunes:episode><%= episode.episode %></itunes:episode>
              <itunes:episodeType>full</itunes:episodeType>
              <itunes:explicit>false</itunes:explicit>
              <% end %>
          </item>
        </channel>
      </rss>
      """
      |> EEx.eval_string(assigns: [episodes: episodes])

    conn
    # |> put_resp_content_type("application/rss+xml")
    |> put_resp_content_type("application/xml")
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
