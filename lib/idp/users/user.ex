defmodule Idp.Users.User do
  use Ecto.Schema

  @type t :: %__MODULE__{
          id: integer(),
          email: String.t(),
          password_hash: String.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, redact: true, virtual: true

    timestamps()
  end
end
