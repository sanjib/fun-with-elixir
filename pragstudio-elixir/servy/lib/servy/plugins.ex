defmodule Servy.Plugins do
  @moduledoc "Plugins for Servy.Handler"

  require Logger

  @doc ""
  def rewrite_path(conv = %{path: path}) do
    re = ~r/\/(?<thing>\w+)\?id=(?<id>\d+)/
    captures = Regex.named_captures(re, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path_captures(conv, %{"thing" => thing, "id" => id}) do
    %{conv | path: "/#{thing}/#{id}"}
  end

  def rewrite_path_captures(conv = %{path: "/wildlife"}, nil) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path_captures(conv, nil), do: conv

  @doc "Logs conv (conversation). Currently used before and after rewrite_path."
  def log(conv), do: IO.inspect(conv)

  @doc "Logs 404 requests"
  def track(conv = %{status: 404, path: path}) do
    Logger.info "--> It's lunchtime somewhere."
    Logger.warn "--> Do we have a problem, Houston?"
    Logger.error "--> Danger Will Robinson!"

    IO.puts "Warning: #{path} is on the loose!"
    conv
  end

  def track(conv), do: conv
end