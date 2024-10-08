# Authorization Server for a Single Sign-On (SSO) service
This repository houses the authorization server for a Single Sign-On (SSO) service.

Users authenticate by logging into the authorization server using their credentials. Note that this server does not integrate with any third-party identity providers (e.g., Google, GitHub), meaning authentication and identity are solely managed through the provided credentials.

Additionally, this repository includes an example SSO client, which can be found in the `/example_client` directory.

## Status
**In development**: Not all functionality you might expect will work at this point.

## Research Branches
The research branches serve for research only and will NOT be merged with the `main` branch:
1. **`research/auth-flow-stub`**: SSO without the use of `mix phx.gen.auth`.
2. **`research/openid-connect`**: SSO based on OpenID Connect.

## Running the Application
In order to demo the SSO service, you need to serve the authorization server and the example client at the same time.

### Authorization Server
1. Run `mix setup` to install and set up dependencies.
1. Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.
1. The authorization server will be available on http://localhost:4000.

### Example Client
1. In your CLI, navigate to the `/example_client` directory.
1. Run `mix setup` to install and set up dependencies.
1. Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.
1. The example client server will be available on http://localhost:4001. Open a browser and go to `http://localhost:4001` to find further instructions on how to use the example client.

## Feature Roadmap
1. A Mix task for Phoenix clients for generating SSO client code.
1. A Mix task for Phoenix authorization servers for generating SSO server code.
1. A package that allows to easily set up an Assent strategy.
