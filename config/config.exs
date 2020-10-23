# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :immediate_act,
  ecto_repos: [ImmediateAct.Repo]

# Configures the endpoint
config :immediate_act, ImmediateActWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eXMeVXL9xQ99PSOs6KuZO1AtcG9WTzcjT8W3sA0GbIGOlBrL6tbebfR+ObzeCfy2",
  render_errors: [view: ImmediateActWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ImmediateAct.PubSub,
  live_view: [signing_salt: "cKHrkql1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
