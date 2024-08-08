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

# Configures the Single Sign-On (SSO) provider
config :example_client, :sso,
  domain: "http://localhost:4000",
  endpoint: "/authorize"

# Configures the public key belonging to the authentication server's private
# key. The client application must request the public key from the
# authentication server.
config :joken,
  public_key: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PUBLIC KEY-----
    MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAq0e7KhzB1RmAfxjqrJHE
    9cPcEY1X4GecwwSE4L+P1MghSDGVfG5Tbag107ENS6+e1PyH8M1f+btpSOuB0CvT
    zMSlvYQvm+QK0rRdI4mfbEFnb4fSqm8h7avzNBOOGJ6Hd14MKYXRPgw1nQ17d9V6
    Rk9Yr2gjq11/iAleFOCKuqXNT3IHwGIrDAjbGteNkhfritWCEPLo5V97rNVirr91
    1HKdmkrRe7D0kHPF2YnEqvDBEsiDrFeiVCsz/QloOa4dJidu2e2z+RsvCYPWkYVJ
    nhy4VZ8E/mZG3xI9hJTWKnFM3SAvri/fch7RgFTtnHXTKF1HoZC+0oS6mcrxnnWR
    eWQBPurTtlfw0YPHzGAzF7VlK+c5RFL8ZvzlU5d/wMLwzr50Ba4xwD1AbB+h419z
    X5ApWVTZOlBOgu8OC4wYnvFws0s1om/HPXsBxXoRHUqKMgXtxgJv6zQEglHjeWbb
    36ejSdeE8+wM2LM6js0Vl0CcJT09HfwKzoSH8N67RVBOvl/DDJO2JlhKkjWhqk2e
    nFaFc05UajY+zLRpfbB5LkgWXe+HEAEdagkj3EEpBQ81W9CQxysTnBTX5EssHqxR
    dmiwKTT1PK1i3dqAWRElHKcRT8zo71UFpxrDSNJNXkUCt4ThVOX1SpjYYrJsDtHr
    xoP25oM0exZnwNheFuKvCDUCAwEAAQ==
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
