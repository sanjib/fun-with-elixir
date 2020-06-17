defmodule Servy.Conv do
  defstruct method: "",
            path: "",
            params: %{},
            headers: %{},
            resp_headers: %{"Content-Type"   => "text/html",
                            "Content-Length" => 0},
            resp_content_type: "text/html",
            resp_body: "",
            status: nil

  def put_resp_content_type(conv, content_type) do
#   %{conv | resp_headers: %{conv.resp_headers | "Content-Type" => content_type}}
    resp_headers = Map.put(conv.resp_headers, "Content-Type", content_type)
    %{conv | resp_headers: resp_headers}
  end

  def put_content_length(conv) do
    # Never use String.length, always use byte_size
    # Why? We need the actual byte length for special characters
    # otherwise the browser will only render up to length which
    # may be shorter than what needs to be rendered
#    content_length = String.length(conv.resp_body)

    content_length = byte_size(conv.resp_body)
    resp_headers = Map.put(conv.resp_headers, "Content-Length", content_length)
    %{conv | resp_headers: resp_headers}
  end

  def format_response_headers(conv) do
#    list = for {key, val} <- conv.resp_headers, do: "#{key}: #{val}"

    resp_string = Enum.map(conv.resp_headers, fn {key, val} -> "#{key}: #{val}" end)
    |> Enum.sort(:desc)
    |> Enum.join("\r\n")

    resp_string <> "\r"
  end
            
  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
  end

  defp status_reason(code) do
    %{200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"}[code]
  end
end
