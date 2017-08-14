defmodule ChannelWithFallbackTest do
  use ExUnit.Case

  alias TestChannel
  alias TestChannelFallbackModule

  defmodule TestChannelFallbackModule do
    def join(_topic, _params, _socket, _result) do
      :handled
    end

    def handle_info(_message, _socket, _result) do
      :handled
    end

    def handle_in(_event, _message, _socket, _result) do
      :handled
    end
  end

  defmodule TestChannel do
    use ChannelWithFallback, TestChannelFallbackModule

    def join(_topic, _params, _socket) do
      :error
    end

    def handle_info(_message, _socket) do
      :error
    end

    def handle_in(_event, _message, _socket) do
      :error
    end
  end

  test "should handle join call" do
    assert :handled == TestChannel.join("test_channel", %{}, %{})
  end

  test "should handle handle_info call" do
    assert :handled == TestChannel.handle_info(%{}, %{})
  end

  test "should handle handle_in call" do
    assert :handled == TestChannel.handle_in("test", %{}, %{})
  end

end
