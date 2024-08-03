defmodule Idp.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: integer(),
          email: String.t(),
          password_hash: String.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "users" do
    field :email, :string
    field :password_hash, :string, redact: true
    field :password, :string, redact: true, virtual: true

    timestamps()
  end

  @doc false
  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_email()
    |> validate_password()
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  @spec validate_email(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
  end

  @spec validate_password(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 10, max: 70)
    |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/,
      message: "at least one digit or punctuation character"
    )
  end

  @spec put_password_hash(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp put_password_hash(changeset) do
    if changeset.valid? do
      put_change(
        changeset,
        :password_hash,
        Bcrypt.hash_pwd_salt(get_change(changeset, :password))
      )
    else
      changeset
    end
  end
end
