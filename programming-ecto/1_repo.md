# Repo

```iex
Repo.all Artist
Repo.insert %Artist{name: "Foo Bar"}
foo = Repo.get_by Artist, name: "Foo Bar"
Repo.update Ecto.Changeset.change(foo, name: "Foo Baz")
baz = Repo.get_by Artist, name: "Foo Baz"
Repo.delete baz
```

```iex
Repo.insert_all "artists", [[name: "Foo"], [name: "Bar"], [name: "Baz"]]
Repo.update_all "artists", set: [updated_at: DateTime.utc_now()]
Repo.all Artist
Repo.delete_all "tracks"
Repo.all Track
```

```iex
Repo.query("select * from artists where id=1")
Repo.aggregate Artist, :count, :id
Repo.aggregate "artists", :count, :id
```
