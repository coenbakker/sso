# Identity Provider (IdP) for Single Sign-On (SSO) Service

This repository contains the code for an Identity Provider (IdP) server that is part of a Single Sign-On (SSO) service. Additionally, it includes an example SSO client located in the example_client directory.

## Running the Application

### Identity Provider Server

To start the identity provider server:

	1.	Run mix setup to install and set up dependencies.
	2.	Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.

The identity provider server will be available on `http://localhost:4000`.

### Example Client

To start the example client:

	1.	Navigate to the example_client directory.
	2.	Run `mix setup` to install and set up dependencies.
	3.	Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.

The example client server will be available on http://localhost:4001. Open a browser and go to http://localhost:4001 to find further instructions on how to use the example client.

**Note**: Ensure that the identity provider server is running when trying out the example client.
