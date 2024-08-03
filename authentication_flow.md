# Authentication flow
This file is meant to help to understand how the OpenID Connect specifications relate to our SSO implementation. It contains specification resources and a high level overview of the OpenID Connect authentication flow that is being implemented in this branch. 

**Note**. Before merging this branch with the main branch, this file should be deleted, as it is meant to help implementation only.

## SSO implementation goal
The Idb app can be used by a selection of other apps to authenticate a user and consequently grant them access to those apps resources and services.

## OpenID Connect
OpenID Connect is an authentication flow on top of the OAuth 2.0 authorization flow.

### Relevant Elixir packages
  - **Oidcc**: OpenID Connect client library for Erlang (https://hexdocs.pm/oidcc/readme.html).
  - **Oidcc Plug**: Oidcc integration with Plug and Phoenix (https://hexdocs.pm/oidcc_plug/readme.html).
  
### Specifications
  - **OAuth** 2.0: https://www.rfc-editor.org/rfc/rfc6749.html
  - **OpenID** Connect Core: https://openid.net/specs/openid-connect-core-1_0.html

## Definitions
Definitions from the Oauth 2.0 and OpenID Connect specifications, adjusted to fit our purposes.

  - **End-User**: The human participant.
  - **Claim**: Piece of information asserted about an End-User.
  - **Relying Party (RP)**: An app that wants to authenticate an End-User and requires Claims.
  - **OpenID Provider (OP)**: App that can authenticate an End-User and provide Claims (i.e., the Idp app).
  - **Access Token**: JWT that contains credentials used to access protected Claims. It represents specific scopes and durations of access that are issued, granted and enforced by the OP.
  - **ID** Token: JWT that contains Claims.
  - **client_id**: string that uniquely identifies a RP 
  - **client_secret**: secret string that proves that the RP is authentic


## Flow overview
This is an overview of our implementation of the OpenID Connect flow. The graph shows a successful End-User authentication.

**Note**. We use the implicit flow and this the implicit grant type. This explains the absense of the token endpoint. See `OAuth 2.0 spec 1.3.1` and `OpenID Connect Core spec 3.2`.
**Note**. In our case the OP is not only responsible for the authentication endpoint, but also the token and user info endpoints.

```
+----------+                              +----------+  
|          |                              |          |
|          |----------------------------->|          |    (1) RP makes authentication request: `POST /authorize` or `GET /authorize`
|          |                              |          |
|          |        +------------+        |          |
|          |        |            |<-------|          |    (2) OP back end sends End-User to OP front end to fill out authentication form
|          |        |     OP     |        |          |    
|          |        | front end  |        |          |
|          |        |            |------->|          |    (3) OP front end requests user login
|          |        +------------+        |          |
|    RP    |                              |    OP    |
|          |<-----------------------------| back end |    (4) OP responds with ID Token and Access Token
|          |                              |          |
|          |                              |          |
|          |----------------------------->|          |    (5) OPTIONAL: RP requests Claims: GET `user-info?`
|          |                              |          |
|          |                              |          |
|          |<-----------------------------|          |    (6) OPTIONAL: OP responds with Claims
|          |                              |          |
+----------+                              +----------+  
```

## Authorization server endpoints
Being the authorization server, the Idb app requires the following endpoints.

### `POST /authorize`
Endpoint for authenticating End-User.

#### Request
##### Query string paramaters
  - **response_type**: Must have the value `"id_token token"`.
  - **client_id**: OAuth 2.0 Client Identifier.
  - **scope**: Must contain the value `"openid"`, but may contain others.
  - **redirect_uri**: Must exactly match one of the redirection URI values that are pre-registered at the OP.
  - **state**: Opaque value used to maintain state between the request and the callback. Countermeasure for CSRF.
  - **max_age**: Maximum Authentication Age. Specifies the allowable elapsed time in seconds since the last time the End-User was actively authenticated by the OP.

##### Example
```
POST /authorize?
  response_type=id_token%20token
  &client_id=s6BhdRkqt3
  &scope=openid
  &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb
  &state=af0ifjsldkj
  &max_age=864000
```

#### Success response
##### Parameters
  - **access_token**
  - **token_type**: Must be value `"Bearer"`.
  - **id_token**
  - **state**: Same value as value of request state parameter. Client must verify that they are equal.
  - **expires in**: Expiration time of the Access Token in seconds since the response was generated.

##### Example
```
HTTP/1.1 302 Found
  Location: https://client.example.org/cb#
  access_token=SlAV32hkKG
  &token_type=bearer
  &id_token=eyJ0 ... NiJ9.eyJ1c ... I6IjIifX0.DeWt4Qu ... ZXso
  &expires_in=3600
  &state=af0ifjsldkj
```

### `GET /authorize`
Same as `POST /authorize`. The OpenID Connect specification requires both to be available to RPs.
