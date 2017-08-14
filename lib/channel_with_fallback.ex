defmodule ChannelWithFallback do
  @moduledoc """
  This module wraps the standard Phoenix `join`, `handle_in` and `handle_info`
  functions and allows for a fallback response in a similar way to fallback
  controllers.

  If the return value of any of the wrapped functions is not an expected
  response for that function, the given fallback module's `call` function will
  be invoked with the function name, the response and the socket.
  """
  defmacro __using__(module) do
    quote location: :keep do
      @channel_fallback_module unquote(module)

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote location: :keep do
      defoverridable [join: 3, handle_in: 3, handle_info: 2]

      def join(topic, params, socket) do
        result = super(topic, params, socket)

        case result do
          {:ok, _socket} -> result
          {:ok, _map, _socket} -> result
          {:error, _reason} -> result
          _ -> @channel_fallback_module.join(topic, params, socket, result)
        end
      end

      def handle_info(message, socket) do
        result = super(message, socket)

        case result do
          {:noreply, _socket} -> result
          {:stop, _socket} -> result
          _ -> @channel_fallback_module.handle_info(message, socket, result)
        end
      end

      def handle_in(event, message, socket) do
        result = super(event, message, socket)

        case result do
          {:noreply, _} -> result
          {:noreply, _, _} -> result
          {:reply, _, _} -> result
          {:stop, _, _} -> result
          {:stop, _, _, _} -> result
          _ -> @channel_fallback_module.handle_in(event, message, socket, result)
        end
      end
    end
  end

end
