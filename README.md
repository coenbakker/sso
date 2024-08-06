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

### Oauth 2.0 RFCs
- OAuth 2.0 specifications (https://www.rfc-editor.org/rfc/rfc6749.html)
- PKCE specifications (https://www.rfc-editor.org/rfc/rfc7636)
- OAuth 2.0 Threat Model and Security Considerations (https://datatracker.ietf.org/doc/html/draft-ietf-oauth-v2-threatmodel-08)
- The above RFCs, plus others (https://oauth.net/books/The%20Little%20Book%20of%20OAuth%202.0%20RFCs.pdf)

### Terminology

The following OAuth definitions are part of the OAuth 2.0 specification. The definitions have been simplified to fit our use case more closely.

- **Resource Server**: The server hosting the protected resources, capable of accepting and responding to protected resource requests using access tokens.
- **Client**: An application making protected resource requests on behalf of a user and with its authorization.
- **Authorization Server**: The server issuing access tokens to the client after successfully authenticating the user and obtaining authorization.

In our SSO use case their may be many Clients, but each is served by a Resource Server. The Authorization Server is a separate entity that serves as an authentication service for all the available Clients. The Authorization Server also servers the login application (i.e., the login UI).


### Flow Graph
TODO: Implement flow graph

```
Authorization Code Grant

The authorization code grant type is used to obtain both access
tokens and refresh tokens and is optimized for confidential clients.
Since this is a redirection-based flow, the client must be capable of
interacting with the resource owner's user-agent (typically a web
browser) and capable of receiving incoming requests (via redirection)
from the authorization server.

  +----------+
  | Resource |
  |   Owner  |
  |          |
  +----------+
       ^
       |
      (B)
  +----|-----+          Client Identifier      +---------------+
  |         -+----(A)-- & Redirection URI ---->|               |
  |  User-   |                                 | Authorization |
  |  Agent  -+----(B)-- User authenticates --->|     Server    |
  |          |                                 |               |
  |         -+----(C)-- Authorization Code ---<|               |
  +------|---+                                 +---------------+
    |    |                                         ^      v
   (A)  (C)                                        |      |
    |    |                                         |      |
    ^    v                                         |      |
  +---------+                                      |      |
  |         |>---(D)-- Authorization Code ---------'      |
  |  Client |          & Redirection URI                  |
  |         |                                             |
  |         |<---(E)----- Access Token -------------------'
  +---------+       (w/ Optional Refresh Token)

Note: The lines illustrating steps (A), (B), and (C) are broken into
two parts as they pass through the user-agent.

(A)  The client initiates the flow by directing the resource owner's
    user-agent to the authorization endpoint.  The client includes
    its client identifier, requested scope, local state, and a
    redirection URI to which the authorization server will send the
    user-agent back once access is granted (or denied).

(B)  The authorization server authenticates the resource owner (via
    the user-agent) and establishes whether the resource owner
    grants or denies the client's access request.

(C)  Assuming the resource owner grants access, the authorization
    server redirects the user-agent back to the client using the
    redirection URI provided earlier (in the request or during
    client registration).  The redirection URI includes an
    authorization code and any local state provided by the client
    earlier.

(D)  The client requests an access token from the authorization
    server's token endpoint by including the authorization code
    received in the previous step.  When making the request, the
    client authenticates with the authorization server.  The client
    includes the redirection URI used to obtain the authorization
    code for verification.

(E)  The authorization server authenticates the client, validates the
    authorization code, and ensures that the redirection URI
    received matches the URI used to redirect the client in
    step (C).  If valid, the authorization server responds back with
    an access token and, optionally, a refresh token.
```
