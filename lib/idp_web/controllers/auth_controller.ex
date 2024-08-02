defmodule IdpWeb.AuthController do
  use IdpWeb, :controller

  # OAuth 2.0 spec: https://www.rfc-editor.org/rfc/rfc6749.html

  def authorize(conn, _params) do
    # REQUEST
    # Spec: https://openid.net/specs/openid-connect-basic-1_0.html#AuthenticationRequest
    #
    # Required query string params
    #   - response_type: must be "code"
    #   - client_id: OAuth 2.0 Client Identifier
    #   - scope: OpenID Connect requests MUST contain the "openid" scope value
    #   - redirect_uri: This URI MUST exactly match one of the Redirection URI values for the Client pre-registered at the OpenID Provider
    #   - state: RECOMMENDED. Opaque value used to maintain state between the request and the callback
    #
    # Example:
    #
    # /authorize?
    #   response_type=code
    #   &scope=openid
    #   &client_id=123
    #   &state=af0ifjsldkj
    #   &redirect_uri=https%3A%2F%2Fclient.example.org%2Fcb

    conn
    |> send_resp(200, "Authorize")
  end

  def token(conn, _params) do
    # REQUEST
    #
    # Example:
    #
    # POST /token HTTP/1.1
    # Host: server.example.com
    # Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW
    # Content-Type: application/x-www-form-urlencoded
    #
    # grant_type=authorization_code&code=SplxlOBeZQQYbYS6WxSbIA
    #   &redirect_uri=https%3A%2F%2Fclient%2Eexample%2Ecom%2Fcb

    # RESPONSE
    #
    # Required:
    #   - access_token
    #   - token_type: The value MUST be Bearer (case-insensitive)
    #   - id_token
    #
    # Note: Also can return expires_in.
    # 
    # Example:
    #
    # HTTP/1.1 200 OK
    # Content-Type: application/json
    # Cache-Control: no-store
    #
    # {
    #  "access_token":"SlAV32hkKG",
    #  "token_type":"Bearer",
    #  "expires_in":3600,
    #  "refresh_token":"tGzv3JOkF0XG5Qx2TlKWIA",
    #  "id_token":"eyJ0 ... NiJ9.eyJ1c ... I6IjIifX0.DeWt4Qu ... ZXso"
    # }

    conn
    |> send_resp(200, "Token")
  end
end
