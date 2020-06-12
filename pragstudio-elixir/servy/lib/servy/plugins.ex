defmodule Servy.Plugins do
  @moduledoc "Plugins for Servy.Handler"

  require Logger
  alias Servy.Conv

  @doc ""
  def rewrite_path(conv = %Conv{path: path}) do
    re = ~r/\/(?<thing>\w+)\?id=(?<id>\d+)/
    captures = Regex.named_captures(re, path)
    rewrite_path_captures(conv, captures)
  end

  def rewrite_path_captures(%Conv{} = conv, %{"thing" => thing, "id" => id}) do
    %{conv | path: "/#{thing}/#{id}"}
  end

  def rewrite_path_captures(conv = %Conv{path: "/wildlife"}, nil) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path_captures(%Conv{} = conv, nil), do: conv

  @doc "Logs conv (conversation). Currently used before and after rewrite_path."
  def log(%Conv{} = conv) do
    if Mix.env == :dev do
      IO.inspect(conv)
    end
    conv
  end

  @doc "Logs 404 requests"
  def track(conv = %{status: 404, path: path}) do
    if Mix.env == :dev do
      Logger.info "--> It's lunchtime somewhere."
      Logger.warn "--> Do we have a problem, Houston?"
      Logger.error "--> Danger Will Robinson!"
    end
    if Mix.env != :test do
      IO.puts "Warning: #{path} is on the loose!"
    end
    conv
  end

  def track(%Conv{} = conv), do: conv
end