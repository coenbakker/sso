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

**Important**: These instructions will work shortly, when the `feature/sso` branch is merged with the `main` branch. Can't wait? Go to the `feature/sso` branch to try out the SSO service while it is still in development.

## Branches
This repository currently contains four branches beside the `main` branch.

The development branches will be merged with the `main` branch:
1. **`feature/sso`**: On this branch the SSO service is being implemented. It will be merged with the `main` branch soon.

The research branches serve for research only and will NOT be merged with the `main` branch:
1. **`feature/auth-flow-stub`**: SSO without the use of `mix phx.gen.auth`.
1. **`feature/boruta`**: SSO with the Boruta package.
1. **`feature/openid-connect`**: SSO with OpenID Connect.

## Feature Roadmap
1. A Mix task for Phoenix clients for generating SSO client code.
1. A Mix task for Phoenix authorization servers for generating SSO server code.
1. A package that allows non-Phoenix clients to easily set up an Assent strategy.
