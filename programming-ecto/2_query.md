# Query

Query Basics, Where, Select, Dynamic Values

```iex
> q = from "artists", select: [:name]
> Repo.all q

> q = from "artists", where: [name: "Bill Evans"], select: [:name]
> Repo.all q

> q = from "artists", where: [name: "Bill Evans"], select: [:name, :id]
> Repo.all q

> artist_name = "Bill Evans"
> q = from "artists", where: [name: ^artist_name], select: [:name, :id]
> Repo.all q

> Ecto.Adapters.SQL.to_sql(:all, Repo, q)

> artist_id = 1
> q = from "artists", select: [:name, :id], where: [id: ^artist_id]
> Repo.all q

> artist_id = "1"
> q = from "artists", select: [:name, :id], where: [id: type(^artist_id, :integer)]
> Repo.all q
```

Query Bindings, Fragments, Union

```iex
> q = from a in "artists", select: [:name, :id], where: a.name == "Bill Evans"
> Repo.all q

> q = from a in "artists", select: [:name, :id], where: like(a.name, "Miles%")
> Repo.all q

> q = from a in "artists", select: [:name, :id], where: is_nil(a.inserted_at)
> Repo.all q

> q = from a in "artists", select: [:name, :id], where: not is_nil(a.inserted_at)
> Repo.all q

> q = from a in "artists", select: [:name, :id], where: a.inserted_at > ago(1, "year")
> Repo.all q

> q = from a in "artists", select: [:name, :id], where: fragment("lower(?)", a.name) == "miles davis"
> Repo.all q

> tracks_query = from t in "tracks", select: t.title
> union_query = from a in "albums", select: a.title, union: ^tracks_query
> union_query = from a in "albums", select: a.title, union_all: ^tracks_query
> union_query = from a in "albums", select: a.title, intersect: ^tracks_query
> union_query = from a in "albums", select: a.title, except: ^tracks_query
> Repo.all union_query
```

Ordering, Grouping

```iex
> q = from a in "artists", select: a.name, order_by: a.name
> Repo.all q
["Bill Evans", "Bobby Hutcherson", "Bruce Springsteen", "Miles Davis"]

> q = from a in "artists", select: [a.name], order_by: a.name
> Repo.all q
[
  ["Bill Evans"],
  ["Bobby Hutcherson"],
  ["Bruce Springsteen"],
  ["Miles Davis"]
]

> q = from t in "tracks", select: [t.album_id, t.title, t.index], order_by: [t.album_id, t.index]
> Repo.all q

> q = from t in "tracks", select: [t.album_id, sum(t.duration)], group_by: t.album_id
> Repo.all q

> q = from t in "tracks", select: [t.album_id, sum(t.duration)], group_by: t.album_id, having: sum(t.duration) > 3600
> Repo.all q
```

Joins

```iex
> q = from t in "tracks", join: a in "albums", on: t.album_id == a.id, select: [a.title, t.title]
> q = from t in "tracks", join: a in "albums", on: t.album_id == a.id, select: [a.title, t.title], where: t.duration > 90
> q = from t in "tracks", join: a in "albums", on: t.album_id == a.id, where: t.duration > 900, select: %{album: a.title, track: t.title}
> Repo.all q

> q = from t in "tracks", join: al in "albums", on: t.album_id == al.id, join: ar in "artists", on: al.artist_id == ar.id, where: t.duration > 900, select: %{artist: ar.name, album: al.title, track: t.title}
> Repo.all q
[
  %{
    album: "Cookin' At The Plugged Nickel",
    artist: "Miles Davis",
    track: "If I Were A Bell"
  },
  %{
    album: "Cookin' At The Plugged Nickel",
    artist: "Miles Davis",
    track: "No Blues"
  }
]
```

Composing Queries, Named Bindings

```iex
> albums_by_miles = from al in "albums", join: ar in "artists", on: al.artist_id == ar.id, where: ar.name == "Miles Davis"
> album_query = from [al, ar] in albums_by_miles, select: [al.title, ar.name]
> Repo.all album_query
[
  ["Kind Of Blue", "Miles Davis"],
  ["Cookin' At The Plugged Nickel", "Miles Davis"]
]

> track_query = from [al, ar] in albums_by_miles, join: t in "tracks", on: al.id == t.album_id, select: [al.title, ar.name, t.title]
> Repo.all track_query
[
  ["Kind Of Blue", "Miles Davis", "So What"],
  ["Kind Of Blue", "Miles Davis", "Freddie Freeloader"],
  ["Kind Of Blue", "Miles Davis", "Blue In Green"],
  ["Kind Of Blue", "Miles Davis", "All Blues"],
  ["Kind Of Blue", "Miles Davis", "Flamenco Sketches"],
  ["Cookin' At The Plugged Nickel", "Miles Davis", "If I Were A Bell"],
  ["Cookin' At The Plugged Nickel", "Miles Davis", "Stella By Starlight"],
  ["Cookin' At The Plugged Nickel", "Miles Davis", "Walkin'"],
  ["Cookin' At The Plugged Nickel", "Miles Davis", "Miles"],
  ["Cookin' At The Plugged Nickel", "Miles Davis", "No Blues"]
]

> albums_by_miles = from al in "albums", as: :albums, join: ar in "artists", as: :artists, on: al.artist_id == ar.id, where: ar.name == "Miles Davis"
> albums_query = from [artists: at, albums: am] in albums_by_miles, select: [at.name, am.title]
> Repo.all albums_query
[
  ["Miles Davis", "Kind Of Blue"],
  ["Miles Davis", "Cookin' At The Plugged Nickel"]
]
```

Composing Queries with Functions

```elixir
def albums_by_artist(artist_name) do
  from al in "albums", as: :albums,
    join: ar in "artists", as: :artists,
    on: al.artist_id == ar.id,
    where: ar.name == ^artist_name
end

def albums_by_artist(query, artist_name) do
  from al in query, as: :albums,
    join: ar in "artists", as: :artists,
    on: al.artist_id == ar.id,
    where: ar.name == ^artist_name
end

def with_tracks_longer_than(query, duration) do
  from [albums: al] in query,
    join: tr in "tracks", as: :tracks,
    on: tr.album_id == al.id,
    where: tr.duration > ^duration,
    distinct: true
end

def select_titles(query) do
  from [albums: al, artists: ar, tracks: tr] in query,
    select: %{artist: ar.name, album: al.title, track: tr.title}
end

albums_by_miles = albums_by_artist("Miles Davis")
albums_query = from [artists: at, albums: am] in albums_by_miles,
  select: %{artist: at.name, album: am.title}
Repo.all albums_query

"albums"
|> albums_by_artist("Miles Davis")
|> with_tracks_longer_than(1000)
|> select_titles
|> Repo.all
```

Or, Where

```iex
> albums_by_miles = from a in "albums", join: ar in "artists", on: a.artist_id == ar.id, where: ar.name == "Miles Davis"
> q = from [a, ar] in albums_by_miles, or_where: ar.name=="Bill Evans", select: [ar.name, a.title]
> Repo.all q
[
  ["Miles Davis", "Kind Of Blue"],
  ["Miles Davis", "Cookin' At The Plugged Nickel"],
  ["Bill Evans", "You Must Believe In Spring"],
  ["Bill Evans", "Portrait In Jazz"]
]
> Repo.to_sql(:all, q)
{"SELECT a1.\"name\", a0.\"title\" FROM \"albums\" AS a0 INNER JOIN \"artists\" AS a1 ON a0.\"artist_id\" = a1.\"id\" WHERE ((a1.\"name\" = 'Miles Davis')) OR (a1.\"name\" = 'Bill Evans')",
 []}
```
