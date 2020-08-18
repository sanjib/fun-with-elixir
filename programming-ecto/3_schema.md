# Schema

Creating Schemas

```elixir
use Ecto.Schema

schema "tracks" do
  field :title, :string
  field :duration, :integer
  field :index, :integer
  field :number_of_plays, :integer
  timestamps()
end
```

Benfit of pre-select and type-convert

```iex
> track_id = "1"
> q = from Track, where: [id: ^track_id]
> Repo.all q
[
  %MusicDB.Track{
    __meta__: #Ecto.Schema.Metadata<:loaded, "tracks">,
    duration: 544,
    id: 1,
    index: 1,
    inserted_at: ~N[2020-08-02 16:36:12],
    number_of_plays: 0,
    title: "So What",
    updated_at: ~N[2020-08-02 16:36:12]
  }
]
```

Without Schema: count and custom map - tracks per album

```iex
> q = from al in "albums", join: tr in "tracks", on: tr.album_id == al.id, select: [al.id, al.title, count(tr.id)], group_by: al.id, order_by: al.id
> Repo.all q
[
  [1, "Kind Of Blue", 5],
  [2, "Cookin' At The Plugged Nickel", 5],
  [3, "You Must Believe In Spring", 10],
  [4, "Portrait In Jazz", 9],
  [5, "Live At Montreaux", 4]
]
```

Inserting, Deleting

```iex
> Repo.insert_all "artists", [[name: "John Coltrane"]]
{1, nil}

> Repo.insert %Artist{name: "John Coltrane"}
{:ok,
 %MusicDB.Artist{
   __meta__: #Ecto.Schema.Metadata<:loaded, "artists">,
   albums: #Ecto.Association.NotLoaded<association :albums is not loaded>,
   birth_date: nil,
   death_date: nil,
   id: 6,
   inserted_at: ~N[2020-08-04 06:17:03],
   name: "John Coltrane",
   tracks: #Ecto.Association.NotLoaded<association :tracks is not loaded>,
   updated_at: ~N[2020-08-04 06:17:03]
 }}

> Repo.delete_all "tracks"
{33, nil}

> q = from "tracks", select: [:title], where: [title: "Song Of Songs"]
> Repo.delete_all q
{1, [%{title: "Song Of Songs"}]}

> t = Repo.get_by Track, title: "Farallone"
> Repo.delete t
{:ok,
 %MusicDB.Track{
   __meta__: #Ecto.Schema.Metadata<:deleted, "tracks">,
   album: #Ecto.Association.NotLoaded<association :album is not loaded>,
   album_id: 5,
   duration: 805,
   duration_string: nil,
   id: 32,
   index: 3,
   inserted_at: ~N[2020-08-04 06:57:34],
   number_of_plays: 0,
   title: "Farallone",
   updated_at: ~N[2020-08-04 06:57:34]
 }}
```

Queries

```iex

```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

```iex
```

