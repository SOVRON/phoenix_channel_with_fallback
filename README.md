# Phoenix ChannelWithFallback

This library provides a way to handle unexpected responses in channel functions
in a similar method to Phoenix's fallback controller paradigm.

## Example

If we wanted to automatically log a user out after a certain API response, we
could do so by matching against the API failure tuple, like so:

  ```elixir
  # The channel:

  def handle_in("some_message", message_data, socket) do
    with {:ok, data} <- make_api_call()
    do
      handle_data(data)
      {:noreply, socket}
    end
  end
  ```

  ```elixir
  # The fallback module:

  defmodule AppWeb.ChannelFallback do
    alias AppWeb.UserService

    def handle_in(_event, _message, socket, {:error, %OAuth2.Response{body: %{"error" => "Expired token"}}}) do
      current_user = socket.assigns.current_user
      UserService.logout_from_client(current_user)
      {:noreply, socket}
    end
    def handle_in(_event, _message, _socket, other_response) do
      # Let other unexpected responses pass through and raise
      other_response
    end

  end
  ```

## Usage

1. Add it to your `mix.exs` dependencies:

  ```elixir
  def deps do
    [{:phoenix_channel_with_fallback, "~> 0.1.0"}]
  end
  ```

2. Add it to your `app/web/web.ex` or `app_web.ex` file:

  ```elixir
  def channel do
    quote do
      use Phoenix.Channel
      use ChannelWithFallback, AppWeb.ChannelFallback

      # ...
    end
  end
  ```

3. Add a fallback module to handle any unexpected responses from channel
   functions:

  ```elixir
  defmodule AppWeb.ChannelFallback do
    def call(channel_function, response, socket) do
      # handle unexpected response and return expected response
    end
  end
  ```

The fallback module's `call` function should accept three arguments.  The first
is the channel function name that returned the unexpected result, the second is
the unexpected result, and the third is the socket passed to the channel
function.

## License

See `LICENSE`.
