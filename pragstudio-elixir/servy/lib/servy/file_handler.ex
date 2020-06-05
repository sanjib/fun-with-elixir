defmodule Servy.FileHandler do
  def file_read(filename, conv) do
    filename
    |> Path.expand(__DIR__)
    |> File.read
    |> file_read_result(conv)
  end

  defp file_read_result({:ok, content}, conv) do
    %{conv | status: 200, resp_body: content}
  end

  defp file_read_result({:error, :enoent}, conv) do
    %{conv | status: 500, resp_body: "File not found!"}
  end

  defp file_read_result({:error, reason}, conv) do
    %{conv | status: 500, resp_body: "File error: #{reason}"}
  end
end