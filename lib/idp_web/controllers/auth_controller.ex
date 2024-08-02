defmodule IdpWeb.AuthController do
  use IdpWeb, :controller

  def authorize(conn, _params) do
    # Spec: https://openid.net/specs/openid-connect-basic-1_0.html#AuthenticationRequest
    #
    # Required query string params
    #   - response_type: must be "code"
    #   - client_id: OAuth 2.0 Client Identifier
    #   - scope: OpenID Connect requests MUST contain the "openid" scope value
    #   - redirect_uri: This URI MUST exactly match one of the Redirection URI values for the Client pre-registered at the OpenID Provider
    #   - state: RECOMMENDED. Opaque value used to maintain state between the request and the callback
    conn
    |> send_resp(200, "Authorize")
  end
end
