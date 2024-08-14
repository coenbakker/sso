# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :example_client,
  ecto_repos: [ExampleClient.Repo]

# Configures the endpoint
config :example_client, ExampleClientWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ExampleClientWeb.ErrorHTML, json: ExampleClientWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ExampleClient.PubSub,
  live_view: [signing_salt: "hzf7Dqkk"]

# TODO: Set a real client ID
# Configures the Single Sign-On (SSO) provider
# Required keys are:
#   - `:domain` - The domain of the SSO provider
#   - `:endpoint` - The path of the authorize endpoint
#   - `:client_id` - The client ID given by the SSO provider to the client application
#   - `:redirect_uri` - The URI to redirect to after the user has been authenticated
config :example_client, :sso,
  domain: "http://localhost:4000",
  endpoint: "/auth/v1/authorize",
  client_id: "example_client_id",
  redirect_uri: "http://localhost:4001/callback"

# Configures the public key belonging to the authentication server's private
# key. The client application must request the public key from the
# authentication server.
config :joken,
  public_key: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PUBLIC KEY-----
    MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA3aJ8TlGe0MnM0DtVqVuI
    ++G7HItLdebXOVYh/eosPBEWcR5eTiVwNqr+fzvE4P83tP2jvukdEX0/UFHJzkRf
    lndo4f7CoeH6WsxKX2s5jVl7vEILoF8miUHQ/k6JYW5bBjfYzhZ+J1LdBrgXzlha
    gRv42xbx0i3NP4oJKnqGt+o+wBePG02wwhE6oRjJr4461Du8hOR758rwrnnMTl7F
    7DAgvPbE0CGMbjAFyjbmABAovNectiBdb0BzQZXO79c8weqdUuhpldhmg2KemD6T
    ykQXsRZwVDDIh+atF8zPxk59wB/jt/kasYmmDHIkBAtmORsxwVmYcCT8BJ9kOd70
    4VisBMRYipyLfa3o+Y3GyUOXnzfzKOaZ+HBAA/N78USCYrJjYPGH77yYEORq2tSZ
    VB/zyOOjTIGPXVsnxNpxWeCS0DrjQSFSnIn4xqmc/5baaZd3ZclHH15CSD032oMg
    ro9A/JmLnF74a/ObjEIIbZm+uAnem8uRxHR0lkhmsqi7YqIRUhiHBkGtfNh6kkgp
    gr7lSknbNeYNnnK+JULNerfnaD1V4H5dMrmz22jvrTZlOFgRKIRH6DueFs6UCjzY
    C9djtreP3TyRD1NTUqorcw6QG7e0prhAbtUh5JtoSztzPPjpvfUPtliuEl/lEeaT
    Qles0WAsjRcTd97YoswVAM0CAwEAAQ==
    -----END PUBLIC KEY-----
    """
  ]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :example_client, ExampleClient.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
