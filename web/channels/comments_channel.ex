defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.Topic

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Topic, topic_id)
    IO.inspect(topic)

    {:ok, %{}, socket}
  end

  def handle_in(_topic, %{"content" => content}, socket) do
    IO.inspect(content)
    {:reply, :ok, socket}
  end
end
