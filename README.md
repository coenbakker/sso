# Identity Provider (IdP) for Single Sign-On (SSO) Service

This repository contains the code for an Identity Provider (IdP) server that is part of a Single Sign-On (SSO) service. Additionally, it includes an example SSO client located in the example_client directory.

## Running the Application

### Identity Provider Server

To start the identity provider server:

1. Run mix setup to install and set up dependencies.
1. Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.

The identity provider server will be available on http://localhost:4000.

### Example Client

To start the example client:

1. Navigate to the example_client directory.
1. Run `mix setup` to install and set up dependencies.
1. Start the Phoenix endpoint with either `mix phx.server` or inside IEx with `iex -S mix phx.server`.

The example client server will be available on http://localhost:4001. Open a browser and go to `http://localhost:4001` to find further instructions on how to use the example client.

**Note**: Ensure that the identity provider server is running when trying out the example client.

## Auth Flow
This app uses an Authorization Code Flow with Proof Key for Code Exchange (PKCE).

### Specifications
The following specification resources can be useful when learning about the authorization protocol that we use.

- OAuth 2.0 (https://www.rfc-editor.org/rfc/rfc6749.html)
- PKCE (https://www.rfc-editor.org/rfc/rfc7636)

### Terminology

The following OAuth definitions are part of the OAuth 2.0 specification. The definitions have been simplified to fit our use case more closely.

- **Resource Server**: The server hosting the protected resources, capable of accepting and responding to protected resource requests using access tokens.
- **Client**: An application making protected resource requests on behalf of a user and with its authorization.
- **Authorization Server**: The server issuing access tokens to the client after successfully authenticating the user and obtaining authorization.

In our SSO use case their may be many Clients, but each is served by a Resource Server. The Authorization Server is a separate entity that serves as an authentication service for all the available Clients. The Authorization Server also servers the login application (i.e., the login UI).


### Flow Graph
TODO: Implement flow graph

```
+----------+                              +---------------+  
|          |                              |               |
|          |                              |               |
|          |                              |               |
| Client   |        +------------+        | Authorization |
|          |        |            |        | Server        |
|          |        | Login UI   |        |               |    
|          |        |            |        |               |
|          |        |            |        |               |
|          |        +------------+        |               |
|          |                              |               |
+----------+                              |               |
                                          |               |
                                          |               |
+----------+                              |               |  
|          |                              |               |
|          |                              |               |
|          |                              |               |
| Resource |                              |               |
| Server   |                              |               |
|          |                              |               |
|          |                              |               |
|          |                              |               |
|          |                              |               |
|          |                              |               |
|          |                              |               |
|          |                              |               |
+----------+                              +---------------+  
```
