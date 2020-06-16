defmodule Servy.VideoCam do

  def get_snapshot(camera_name) do
    # simulate work
    :timer.sleep(1000)

    # dummy response
    "#{camera_name}-snapshot.jpg"
  end
end
