defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:nickname, :string)
    field(:image, :string)
    field(:provider, :string)
    field(:token, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :nickname, :image, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end