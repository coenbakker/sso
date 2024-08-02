defmodule Idp.TestUtils do
  @moduledoc false

  @spec has_error?(Ecto.Changeset.t(), field :: atom()) :: boolean()
  def has_error?(changeset, field) do
    Keyword.has_key?(changeset.errors, field)
  end

  @spec get_error(Ecto.Changeset.t(), field :: atom()) :: {:ok, Ecto.Changeset.error()} | :error
  def get_error(changeset, field) do
    Keyword.fetch(changeset.errors, field)
  end
end
