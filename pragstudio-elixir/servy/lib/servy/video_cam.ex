defmodule Servy.VideoCam do

  def get_snapshot(camera_name) do
    # simulate work
    :timer.sleep(1000)

    # dummy response
#    "#{camera_name}-snapshot.jpg"
    "#{camera_name}-snapshot-#{:rand.uniform(1000)}.jpg"
  end
end
