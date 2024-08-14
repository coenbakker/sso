import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :idp, Idp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "idp_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :idp, IdpWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Ft8ZGieRQm8tAiBv7s4b3Wdh6fzqfs3mbElDw9y9ip4RDJltxwfhWikXi9EFRyFR",
  server: false

# In test we don't send emails.
config :idp, Idp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Configure private and public RSA keys. These keys are for testing purposes
# only and should not be used in production
config :joken,
  private_key: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PRIVATE KEY-----
    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
    m/oPnEiJ8w8KdxaWwyz2681ueCRC1T0=
    -----END PRIVATE KEY-----
    """
  ],
  public_key: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PUBLIC KEY-----
    MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAzdMLqYQBKSP1rUSdhQeg
    5ygIWmW6WWpj1q7V/qn2b2KEzJ6FrlZFQt5YAwe2USSjpBBuH8rVPAANxHQSOiC+
    c+8vh230imQknO4ASwUtvReHmOeiM4HoGJji5B6lhKMNGLKWpWad32s/aKFLoFo2
    gv2qQE3ZBL/ihRpq78uvqXFZVC+I+seDi8DNxba3L8cSeBb805H8qoOTn+Stj2Ti
    E4MKvLBkpshwC/EhOzTkzyDERAL8llso2Erseer7nv0WRQUWc2xC+FRTwdK8cUbp
    sDiMbZ6Gth6eVIpbEA0e4694NiLvMJHqZ1IIqmPNwYRz+0LSmgV60dUhlO40VqyR
    s3sFAKGm6iASpDrryGm9hvJ5B14hnUOsQjluIzPlkpATnUPlzZNw3lxpZ7UExTKL
    r9I+3L/O0wyz3Wzvb2bL52RDegonX9WrW0co8bsmA0XDFalRfYklZ7YtG5tAn9yC
    VVr97XyP/9q2Jt63liRX3gfhdtvRBEqGhh3KfSTVHVTuhm3kKA1B3yO7/GGGDY5B
    8oUOuo7OgtypxoB4SjmqXF4z4UquuoXNLTfZ22nXvfSNNXlSFWhVuV0t3XCfRQPo
    JOyDV+HPZERjETvjyVP7+iUGRtCKHfU5d8WdbyC5QzTZLe9q+GZK+OptuRi3dy+k
    P4VpRysvGd83+dcgKLgEBB0CAwEAAQ==
    -----END PUBLIC KEY-----
    """
  ]
