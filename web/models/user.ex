defmodule Discuss.User do
  use Discuss.Web, :model

  @derive {Poison.Encoder, only: [:email]}

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:nickname, :string)
    field(:image, :string)
    field(:provider, :string)
    field(:token, :string)

    has_many(:topics, Discuss.Topic)
    has_many(:comments, Discuss.Comment)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :nickname, :image, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
