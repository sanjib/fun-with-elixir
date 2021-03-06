defmodule LiveViewStudioWeb.VolunteersLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Volunteers
  alias LiveViewStudio.Volunteers.Volunteer

  def mount(_params, _session, socket) do
    volunteers = Volunteers.list_volunteers()
    changeset = Volunteers.change_volunteer(%Volunteer{})

    socket = assign(socket,
      volunteers: volunteers,
      changeset: changeset
    )
    {:ok, socket, temporary_assigns: [volunteers: []]}
  end

  def handle_event("save", %{"volunteer" => params}, socket) do
    case Volunteers.create_volunteer(params) do
      {:ok, volunteer} ->
        socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
        changeset = Volunteers.change_volunteer(%Volunteer{})
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"volunteer" => params}, socket) do
    changeset =
      %Volunteer{}
      |> Volunteers.change_volunteer(params)
      |> Map.put(:action, :insert)
    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("toggle_status", %{"id" => id}, socket) do
#    id = String.to_integer(id)
    volunteer = Volunteers.get_volunteer!(id) # id is string
    {:ok, _volunteer} = Volunteers.toggle_checked_out(volunteer)

    socket = assign(socket,
      volunteers: Volunteers.list_volunteers()
    )
    :timer.sleep(1000)
    {:noreply, socket}
  end

end