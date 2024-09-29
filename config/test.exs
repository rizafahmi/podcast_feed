import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :podcast_feed, PodcastFeed.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "podcast_feed_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :podcast_feed, PodcastFeedWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "gB24gIlXC4CtMkGMofoNRNxc5bOzmsW/rTDy4wkT+v+UHSLF81iXyGt8Ny31Gy08",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
