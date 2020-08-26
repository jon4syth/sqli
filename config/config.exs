# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sqli,
  ecto_repos: [Sqli.Repo]

# Configures the endpoint
config :sqli, SqliWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zGVszvVUoB78+Otoa5rwSl4+gdttWrOPUJ0wO9s3edUDMGA5AyFyoWiYIBgDLjQ3",
  render_errors: [view: SqliWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Sqli.PubSub,
  live_view: [signing_salt: "2tfp57Od"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
