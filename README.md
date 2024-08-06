# Universal Authorization Server for a Single Sign-On (SSO) service
This repository contains the universal authorization server of a Single Sign-On (SSO) service. Additionally, it contains an example SSO client located in the `/example_client` directory.

## Running the Application
In order to demo the SSO service, you need to serve the authorization server and the example client at the same time.

### Universal Authorization Server
1. Run `mix setup` to install and set up dependencies.
1. Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.
1. The authorization server will be available on http://localhost:4000.

### Example Client
1. Navigate to the `/example_client` directory.
1. Run `mix setup` to install and set up dependencies.
1. Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.
1. The example client server will be available on http://localhost:4001. Open a browser and go to `http://localhost:4001` to find further instructions on how to use the example client.
