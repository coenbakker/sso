# Authentication flow
This file is meant to help to understand how the OpenID Connect specifications relate to our implementation goal. It contains specification resources and a high level overview of the OpenID Connect authentication flow that is being implemented in this branch. 

**Note**. Before merging this branch with the main branch, this file should be deleted, as it is meant to help implementation only.

## Our implementation goal
The Idb app can be used by a selection of other apps to authenticate a user and consequently grant them access to those apps resources and services.

## OpenID Connect
OpenID Connect is an authentication flow on top of the OAuth 2.0 authorization flow.

### Specifications
  - OAuth 2.0 spec: https://www.rfc-editor.org/rfc/rfc6749.html
  - OpenID Connect Core: https://openid.net/specs/openid-connect-core-1_0.html

## Definitions
Definitions from the Oauth 2.0 and OpenID Connect specifications, adjusted to fit our purposes.

  - End-user: The human participant.
  - Claim: Piece of information asserted about an End-User.
  - Relying Party: An app that wants to authenticate an End-User and requires Claims.
  - Authorization server: The server that performs the authentication (i.e., the Idp app)
  - Resource server: The server that gatekeeps protected resources (i.e., the Idp app).
  - ID Token: JWT that contains Claims

  TODO: Extend and improve

## Flow overview
This is an overview of our implementation of the OpenID Connect flow.

TODO: Make overview

## Authorization server endpoints
Being the authorization server, the Idb app requires the following endpoints.

TODO: List endpoints
