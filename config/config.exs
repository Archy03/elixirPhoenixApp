# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :buru,
  ecto_repos: [Buru.Repo]

# Configures the endpoint
config :buru, BuruWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "s6hxkRJW6IEXrArzMZHf3ZFG9LYwd5z5+LIOwA+5NXWEIyxgRwjb8n+7J8MWFp9c",
  render_errors: [view: BuruWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Buru.PubSub,
  live_view: [signing_salt: "KeynDFJW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
