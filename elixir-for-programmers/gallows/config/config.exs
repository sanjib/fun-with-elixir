# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :gallows, GallowsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bALKW2J5iKgBWlR0g2Iv4bW9rkjo1wBpOJ7+T2+WD2t3Mk5qLeBxbfwqgOCG3vYJ",
  render_errors: [view: GallowsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gallows.PubSub,
  live_view: [signing_salt: "gpztNo/M"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
